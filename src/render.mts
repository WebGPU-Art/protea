import spriteWGSL from "../shaders/sprite.wgsl?raw";
import updateSpritesWGSL from "../shaders/update-sprites.wgsl?raw";
import { createBuffer, createDepthTexture } from "./buffer.mjs";
import {
  atomViewerPosition,
  atomViewerUpward,
  newLookatPoint,
} from "./perspective.mjs";
import { vCross, vLength, vNormalize } from "./quaternion.mjs";
import { coneBackScale } from "./config.mjs";
import { atomDepthTexture, atomDevice } from "./globals.mjs";

export let createRenderer = async (
  canvas: HTMLCanvasElement,
  makeSeed: () => {
    size: number;
    data: Float32Array;
  },
  loadParams: () => number[],
  loadVertex: () => number[]
) => {
  let { size: numParticles, data: initialParticleData } = makeSeed();
  let paramsData = loadParams();
  let vertexData = loadVertex();

  let device = atomDevice.deref();
  const context = canvas.getContext("webgpu") as GPUCanvasContext;
  const presentationFormat = navigator.gpu.getPreferredCanvasFormat();

  context.configure({
    device,
    format: presentationFormat,
    alphaMode: "premultiplied",
  });

  /** TODO don't know why, but fixes, https://programmer.ink/think/several-best-practices-of-webgpu.html */
  let emtpyBuffer = {};
  let uniformBindGroupLayout = device.createBindGroupLayout({
    entries: [
      { binding: 0, visibility: GPUShaderStage.VERTEX, buffer: emtpyBuffer },
    ],
  });

  const pipelineLayoutDesc = { bindGroupLayouts: [uniformBindGroupLayout] };
  let renderLayout = device.createPipelineLayout(pipelineLayoutDesc);

  const spriteShaderModule = device.createShaderModule({ code: spriteWGSL });
  const renderPipeline = device.createRenderPipeline({
    layout: renderLayout,
    vertex: {
      module: spriteShaderModule,
      entryPoint: "vert_main",
      buffers: [
        {
          // instanced particles buffer
          arrayStride: 8 * 4,
          stepMode: "instance",
          attributes: [
            { shaderLocation: 0, offset: 0, format: "float32x3" },
            { shaderLocation: 1, offset: 4 * 4, format: "float32x3" },
          ],
        },
        {
          // vertex buffer
          arrayStride: 2 * 4,
          stepMode: "vertex",
          attributes: [{ shaderLocation: 2, offset: 0, format: "float32x2" }],
        },
      ],
    },
    fragment: {
      module: spriteShaderModule,
      entryPoint: "frag_main",
      targets: [{ format: presentationFormat, blend: blendState }],
    },
    primitive: {
      topology: "triangle-list",
    },
    depthStencil: {
      depthWriteEnabled: true,
      depthCompare: "less",
      format: "depth24plus-stencil8",
    },
  });

  const bindGroupLayout = device.createBindGroupLayout({
    entries: [
      {
        binding: 0,
        visibility: GPUShaderStage.COMPUTE,
        buffer: { type: "uniform" },
      },
      {
        binding: 1,
        visibility: GPUShaderStage.COMPUTE,
        buffer: { type: "read-only-storage" },
      },
      {
        binding: 2,
        visibility: GPUShaderStage.COMPUTE,
        buffer: { type: "storage" },
      },
    ],
  });

  const computePipeline = device.createComputePipeline({
    layout: device.createPipelineLayout({
      bindGroupLayouts: [bindGroupLayout],
    }),
    compute: {
      module: device.createShaderModule({ code: updateSpritesWGSL }),
      entryPoint: "main",
    },
  });

  let needClear = true;
  let loadOp: GPULoadOp = (needClear ? "clear" : "load") as GPULoadOp;

  let depthTexture = atomDepthTexture.deref();

  const renderPassDescriptor: GPURenderPassDescriptor = {
    colorAttachments: [
      {
        view: context.getCurrentTexture().createView(), // Assigned later
        clearValue: { r: 0.9, g: 0.9, b: 0.9, a: 1.0 },
        loadOp: loadOp,
        storeOp: "store",
      },
    ],
    depthStencilAttachment: {
      view: depthTexture.createView(),
      depthClearValue: 1,
      depthLoadOp: loadOp,
      depthStoreOp: "store" as const,
      stencilLoadOp: "clear" as const,
      stencilStoreOp: "store" as const,
    },
  };

  let spriteVertexBuffer = buildSpriteVertexBuffer(vertexData);
  let simParamBuffer = buildSimParamBuffer(paramsData);

  const particleBuffers: GPUBuffer[] = new Array(2);
  for (let i = 0; i < 2; ++i) {
    particleBuffers[i] = device.createBuffer({
      size: initialParticleData.byteLength,
      usage: GPUBufferUsage.VERTEX | GPUBufferUsage.STORAGE,
      mappedAtCreation: true,
    });
    new Float32Array(particleBuffers[i].getMappedRange()).set(
      initialParticleData
    );
    particleBuffers[i].unmap();
  }

  const particleBindGroups: GPUBindGroup[] = new Array(2);
  for (let i = 0; i < 2; ++i) {
    let byteLength = initialParticleData.byteLength;
    let fromBuffer = particleBuffers[i % 2];
    let toBuffer = particleBuffers[(i + 1) % 2];
    particleBindGroups[i] = device.createBindGroup({
      layout: computePipeline.getBindGroupLayout(0),
      entries: [
        { binding: 0, resource: { buffer: simParamBuffer } },
        {
          binding: 1,
          resource: { buffer: fromBuffer, offset: 0, size: byteLength },
        },
        {
          binding: 2,
          resource: { buffer: toBuffer, offset: 0, size: byteLength },
        },
      ],
    });
  }

  return async function render(t: number) {
    let uniformBuffer = loadUniformBuffer();

    let uniformBindGroup: GPUBindGroup = device.createBindGroup({
      layout: uniformBindGroupLayout,
      entries: [{ binding: 0, resource: { buffer: uniformBuffer } }],
    });

    // Sample is no longer the active page.

    (
      renderPassDescriptor.colorAttachments as GPURenderPassColorAttachment[]
    )[0].view = context.getCurrentTexture().createView();

    renderPassDescriptor.depthStencilAttachment.view = atomDepthTexture
      .deref()
      .createView();

    const commandEncoder = device.createCommandEncoder();

    const computePassEncoder = commandEncoder.beginComputePass();
    computePassEncoder.setPipeline(computePipeline);
    computePassEncoder.setBindGroup(0, particleBindGroups[t % 2]);
    computePassEncoder.dispatchWorkgroups(Math.ceil(numParticles / 64));
    computePassEncoder.end();

    const passEncoder = commandEncoder.beginRenderPass(renderPassDescriptor);
    passEncoder.setPipeline(renderPipeline);
    passEncoder.setVertexBuffer(0, particleBuffers[(t + 1) % 2]);
    passEncoder.setVertexBuffer(1, spriteVertexBuffer);
    passEncoder.setBindGroup(0, uniformBindGroup);
    passEncoder.draw(3, numParticles, 0, 0);
    passEncoder.end();

    device.queue.submit([commandEncoder.finish()]);
  };
};

let loadUniformBuffer = () => {
  let lookAt = newLookatPoint();
  let forward = vNormalize(lookAt);
  let rightward = vCross(forward, atomViewerUpward.deref());
  // 👔 Uniform Data
  const uniformData = new Float32Array([
    // coneBackScale
    coneBackScale,
    // viewport_ratio
    window.innerHeight / window.innerWidth,
    vLength(lookAt),
    // alignment
    0,
    // lookpoint
    ...forward,
    // alignment
    0,
    // upwardDirection
    ...atomViewerUpward.deref(),
    // alignment
    0,
    ...rightward,
    // alignment
    0,
    // cameraPosition
    ...atomViewerPosition.deref(),
    0,
    // alignment
    // ...(info.addUniform?.() || []),
  ]);

  let uniformBuffer = createBuffer(
    uniformData,
    GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST
  );
  return uniformBuffer;
};

let buildSpriteVertexBuffer = (data: number[]) => {
  let device = atomDevice.deref();

  // prettier-ignore
  const vertexBufferData = new Float32Array(data);

  const spriteVertexBuffer = device.createBuffer({
    size: vertexBufferData.byteLength,
    usage: GPUBufferUsage.VERTEX,
    mappedAtCreation: true,
  });
  new Float32Array(spriteVertexBuffer.getMappedRange()).set(vertexBufferData);
  spriteVertexBuffer.unmap();

  return spriteVertexBuffer;
};

let buildSimParamBuffer = (data: number[]) => {
  let device = atomDevice.deref();

  const simParamBufferSize = 7 * Float32Array.BYTES_PER_ELEMENT;
  const simParamBuffer = device.createBuffer({
    size: simParamBufferSize,
    usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
  });

  function updateSimParams() {
    device.queue.writeBuffer(simParamBuffer, 0, new Float32Array(data));
  }

  updateSimParams();

  return simParamBuffer;
};

// TODO need to learn more details
// https://github.com/takahirox/webgpu-trial/blob/master/cube_alpha_blend.html#L273
// https://github.com/kdashg/webgpu-js/blob/master/hello-blend.html#L98
let blendState: GPUBlendState = {
  color: {
    srcFactor: "src-alpha",
    dstFactor: "one-minus-src-alpha",
    operation: "add",
  },
  alpha: {
    srcFactor: "one",
    dstFactor: "one-minus-src-alpha",
    operation: "add",
  },
};

export function resetCanvasSize(canvas: HTMLCanvasElement) {
  // canvas height not accurate on Android Pad, use innerHeight
  canvas.style.height = `${window.innerHeight}px`;
  canvas.style.width = `${window.innerWidth}px`;
  canvas.height = window.innerHeight * devicePixelRatio;
  canvas.width = window.innerWidth * devicePixelRatio;
}
