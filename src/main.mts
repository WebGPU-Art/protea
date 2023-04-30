import { onControlEvent } from "./control.mjs";
import spriteWGSL from "../shaders/sprite.wgsl?raw";
import updateSpritesWGSL from "../shaders/update-sprites.wgsl?raw";
import { renderControl, startControlLoop } from "@triadica/touch-control";
import { createBuffer, createDepthTexture } from "./render.mjs";
import {
  atomViewerPosition,
  atomViewerUpward,
  newLookatPoint,
} from "./perspective.mjs";
import { vCross, vLength, vNormalize } from "./quaternion.mjs";
import { coneBackScale } from "./config.mjs";
import { atomDepthTexture, atomDevice } from "./globals.mjs";

let main = async (canvas: HTMLCanvasElement) => {
  let device = atomDevice.deref();
  const context = canvas.getContext("webgpu") as GPUCanvasContext;
  const devicePixelRatio = window.devicePixelRatio || 1;
  canvas.width = canvas.clientWidth * devicePixelRatio;
  canvas.height = canvas.clientHeight * devicePixelRatio;
  const presentationFormat = navigator.gpu.getPreferredCanvasFormat();

  context.configure({
    device,
    format: presentationFormat,
    alphaMode: "premultiplied",
  });

  let uniformBindGroupLayout = device.createBindGroupLayout({
    entries: [
      {
        binding: 0,
        visibility: GPUShaderStage.VERTEX,
        buffer: {}, // TODO don't know why, but fixes, https://programmer.ink/think/several-best-practices-of-webgpu.html
      },
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
          arrayStride: 6 * 4,
          stepMode: "instance",
          attributes: [
            {
              // instance position
              shaderLocation: 0,
              offset: 0,
              format: "float32x3",
            },
            {
              // instance velocity
              shaderLocation: 1,
              offset: 3 * 4,
              format: "float32x3",
            },
          ],
        },
        {
          // vertex buffer
          arrayStride: 2 * 4,
          stepMode: "vertex",
          attributes: [
            {
              // vertex positions
              shaderLocation: 2,
              offset: 0,
              format: "float32x2",
            },
          ],
        },
      ],
    },
    fragment: {
      module: spriteShaderModule,
      entryPoint: "frag_main",
      targets: [
        {
          format: presentationFormat,
          // TODO need to learn more details
          // https://github.com/takahirox/webgpu-trial/blob/master/cube_alpha_blend.html#L273
          // https://github.com/kdashg/webgpu-js/blob/master/hello-blend.html#L98
          blend: {
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
          },
        },
      ],
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

  const computePipeline = device.createComputePipeline({
    layout: "auto",
    compute: {
      module: device.createShaderModule({
        code: updateSpritesWGSL,
      }),
      entryPoint: "main",
    },
  });

  let needClear = true;

  let depthTexture = atomDepthTexture.deref();

  const renderPassDescriptor: GPURenderPassDescriptor = {
    colorAttachments: [
      {
        view: context.getCurrentTexture().createView(), // Assigned later
        clearValue: { r: 0.0, g: 0.0, b: 0.0, a: 1.0 },
        loadOp: (needClear ? "clear" : "load") as GPULoadOp,
        storeOp: "store",
      },
    ],

    depthStencilAttachment: {
      view: depthTexture.createView(),
      depthClearValue: 1,
      depthLoadOp: (needClear ? "clear" : "load") as GPULoadOp,
      depthStoreOp: "store" as GPUStoreOp,
      stencilLoadOp: "clear" as GPULoadOp,
      stencilStoreOp: "store" as GPUStoreOp,
    },
  };

  // prettier-ignore
  const vertexBufferData = new Float32Array([
    -0.01, -0.02,
    0.01, -0.02,
    0.0, 0.02,
  ]);

  const spriteVertexBuffer = device.createBuffer({
    size: vertexBufferData.byteLength,
    usage: GPUBufferUsage.VERTEX,
    mappedAtCreation: true,
  });
  new Float32Array(spriteVertexBuffer.getMappedRange()).set(vertexBufferData);
  spriteVertexBuffer.unmap();

  const simParams = {
    deltaT: 0.04,
    rule1Distance: 0.1,
    rule2Distance: 0.025,
    rule3Distance: 0.025,
    rule1Scale: 0.02,
    rule2Scale: 0.05,
    rule3Scale: 0.005,
  };

  const simParamBufferSize = 7 * Float32Array.BYTES_PER_ELEMENT;
  const simParamBuffer = device.createBuffer({
    size: simParamBufferSize,
    usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
  });

  function updateSimParams() {
    device.queue.writeBuffer(
      simParamBuffer,
      0,
      new Float32Array([
        simParams.deltaT,
        simParams.rule1Distance,
        simParams.rule2Distance,
        simParams.rule3Distance,
        simParams.rule1Scale,
        simParams.rule2Scale,
        simParams.rule3Scale,
      ])
    );
  }

  updateSimParams();

  const numParticles = 500;
  const initialParticleData = new Float32Array(numParticles * 6);
  for (let i = 0; i < numParticles; ++i) {
    initialParticleData[6 * i + 0] = 2 * (Math.random() - 0.5);
    initialParticleData[6 * i + 1] = 2 * (Math.random() - 0.5);
    initialParticleData[6 * i + 2] = 0;
    // initialParticleData[6 * i + 2] = 2 * (Math.random() - 0.5);
    initialParticleData[6 * i + 3] = 2 * (Math.random() - 0.5) * 0.1;
    initialParticleData[6 * i + 4] = 2 * (Math.random() - 0.5) * 0.1;
    // initialParticleData[6 * i + 5] = 2 * (Math.random() - 0.5) * 0.1;
    initialParticleData[6 * i + 5] = 0;
  }

  const particleBuffers: GPUBuffer[] = new Array(2);
  const particleBindGroups: GPUBindGroup[] = new Array(2);
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

  for (let i = 0; i < 2; ++i) {
    particleBindGroups[i] = device.createBindGroup({
      layout: computePipeline.getBindGroupLayout(0),
      entries: [
        {
          binding: 0,
          resource: {
            buffer: simParamBuffer,
          },
        },
        {
          binding: 1,
          resource: {
            buffer: particleBuffers[i],
            offset: 0,
            size: initialParticleData.byteLength,
          },
        },
        {
          binding: 2,
          resource: {
            buffer: particleBuffers[(i + 1) % 2],
            offset: 0,
            size: initialParticleData.byteLength,
          },
        },
      ],
    });
  }

  let t = 0;
  function frame() {
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
    {
      const passEncoder = commandEncoder.beginComputePass();
      passEncoder.setPipeline(computePipeline);
      passEncoder.setBindGroup(0, particleBindGroups[t % 2]);
      passEncoder.dispatchWorkgroups(Math.ceil(numParticles / 64));
      passEncoder.end();
    }
    {
      const passEncoder = commandEncoder.beginRenderPass(renderPassDescriptor);
      passEncoder.setPipeline(renderPipeline);
      passEncoder.setVertexBuffer(0, particleBuffers[(t + 1) % 2]);
      passEncoder.setVertexBuffer(1, spriteVertexBuffer);
      passEncoder.setBindGroup(0, uniformBindGroup);
      passEncoder.draw(3, numParticles, 0, 0);
      passEncoder.end();
    }
    device.queue.submit([commandEncoder.finish()]);

    ++t;

    setTimeout(() => {
      requestAnimationFrame(frame);
    }, 200);
  }
  requestAnimationFrame(frame);
};

window.onload = async () => {
  if (navigator.gpu == null) {
    alert("WebGPU is required to run this sample.");
  }

  const adapter = await navigator.gpu.requestAdapter();
  const device = await adapter.requestDevice();

  atomDevice.reset(device);

  let canvas = document.querySelector("#canvas-container") as HTMLCanvasElement;
  renderControl();
  startControlLoop(10, onControlEvent);
  resetCanvasSize(canvas);

  atomDepthTexture.reset(createDepthTexture());

  main(canvas as HTMLCanvasElement);

  window.onresize = () => {
    resetCanvasSize(canvas);
    atomDepthTexture.reset(createDepthTexture());
  };
};

export function resetCanvasSize(canvas: HTMLCanvasElement) {
  // canvas height not accurate on Android Pad, use innerHeight
  canvas.style.height = `${window.innerHeight}px`;
  canvas.style.width = `${window.innerWidth}px`;
  canvas.height = window.innerHeight * devicePixelRatio;
  canvas.width = window.innerWidth * devicePixelRatio;
}

declare global {
  /** dirty hook for extracting error messages */
  var __lagopusHandleCompilationInfo: (
    info: GPUCompilationInfo,
    code: string
  ) => void;
}
