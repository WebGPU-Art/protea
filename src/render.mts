import { createBuffer, createDepthTexture } from "./buffer.mjs";
import {
  atomViewerPosition,
  atomViewerUpward,
  newLookatPoint,
  coneBackScale,
  atomViewerScale,
} from "./perspective.mjs";
import { vCross, vLength, vNormalize } from "@triadica/touch-control";
import { atomDepthTexture, atomDevice } from "./globals.mjs";
import proteaColors from "../shaders/protea-colors.wgsl?raw";
import proteaPerspective from "../shaders/protea-perspective.wgsl?raw";

let renderGroupEntries: GPUBindGroupLayoutEntry[] = [
  {
    binding: 0,
    visibility: GPUShaderStage.VERTEX,
    buffer: { type: "uniform" },
  },
  {
    binding: 1,
    visibility: GPUShaderStage.VERTEX,
    buffer: { type: "uniform" },
  },
];

let computeUniformEntries: GPUBindGroupLayoutEntry[] = [
  {
    binding: 0,
    visibility: GPUShaderStage.COMPUTE,
    buffer: { type: "uniform" },
  },
  {
    binding: 1,
    visibility: GPUShaderStage.COMPUTE,
    buffer: { type: "uniform" },
  },
];

let computeParticleEntries: GPUBindGroupLayoutEntry[] = [
  {
    binding: 0,
    visibility: GPUShaderStage.COMPUTE,
    buffer: { type: "read-only-storage" },
  },
  {
    binding: 1,
    visibility: GPUShaderStage.COMPUTE,
    buffer: { type: "storage" },
  },
];

let interpolateShader = (shader: string) => {
  return shader
    .replace("#import protea::perspective", proteaPerspective)
    .replace("#import protea::colors", proteaColors);
};

/** setup buffer for compute shader,
 * also mock some buffer in render pass
 */
let setupParticlesBindGroups = (
  device: GPUDevice,
  layout: GPUBindGroupLayout,
  particleBuffers: GPUBuffer[],
  byteLength: number
) => {
  const particleBindGroups: GPUBindGroup[] = new Array(2);
  const mockedBindGroups: GPUBindGroup[] = new Array(2);

  for (let i = 0; i < 2; ++i) {
    let fromBuffer = particleBuffers[i % 2];
    let toBuffer = particleBuffers[(i + 1) % 2];
    particleBindGroups[i] = device.createBindGroup({
      layout: layout,
      entries: [
        { binding: 0, resource: { buffer: fromBuffer, size: byteLength } },
        { binding: 1, resource: { buffer: toBuffer, size: byteLength } },
      ],
    });
    let emptyBuffer = device.createBuffer({
      size: 4,
      usage: GPUBufferUsage.STORAGE,
    });
    let emptyBuffer2 = device.createBuffer({
      size: 4,
      usage: GPUBufferUsage.STORAGE,
    });
    mockedBindGroups[i] = device.createBindGroup({
      layout: layout,
      entries: [
        { binding: 0, resource: { buffer: emptyBuffer, size: 4 } },
        { binding: 1, resource: { buffer: emptyBuffer2, size: 4 } },
      ],
    });
  }

  return {
    particleBindGroups,
    mockedBindGroups,
  };
};

export let createRenderer = async (
  canvas: HTMLCanvasElement,
  computeOptions: {
    seedSize: number;
    seedData: Float32Array;
    params: number[];
    computeShader: string;
  },
  renderOptions: {
    vertexCount: number;
    vertexData: number[];
    vertexBufferLayout: GPUVertexBufferLayout[];
    indexData?: number[];
    topology?: GPUPrimitiveTopology;
    bgColor?: number[];
  }
) => {
  let numParticles = computeOptions.seedSize;
  let initialParticleData = computeOptions.seedData;
  let shaderCode = interpolateShader(computeOptions.computeShader);

  let vertexCount = renderOptions.vertexCount;
  let paramsData = computeOptions.params;
  let vertexData = renderOptions.vertexData;
  let vertexBufferlayout = renderOptions.vertexBufferLayout;
  let indexBuffer = renderOptions.indexData
    ? createBuffer(
        new Uint32Array(renderOptions.indexData),
        GPUBufferUsage.INDEX
      )
    : null;

  let device = atomDevice.deref();
  const context = canvas.getContext("webgpu") as GPUCanvasContext;
  const presentationFormat = navigator.gpu.getPreferredCanvasFormat();

  context.configure({
    device,
    format: presentationFormat,
    alphaMode: "premultiplied",
  });

  let computeParticlesLayout = device.createBindGroupLayout({
    entries: computeParticleEntries,
  });

  let shaderModule = device.createShaderModule({ code: shaderCode });

  const computePipeline = device.createComputePipeline({
    layout: device.createPipelineLayout({
      bindGroupLayouts: [
        device.createBindGroupLayout({ entries: computeUniformEntries }),
        computeParticlesLayout,
      ],
    }),
    compute: {
      module: shaderModule,
      entryPoint: "main",
    },
  });

  shaderModule.getCompilationInfo().then((info) => {
    window.__lagopusHandleCompilationInfo(info, shaderCode);
  });
  const renderPipeline = device.createRenderPipeline({
    layout: device.createPipelineLayout({
      bindGroupLayouts: [
        device.createBindGroupLayout({
          entries: renderGroupEntries,
        }),
        device.createBindGroupLayout({
          entries: computeParticleEntries, // mocked
        }),
      ],
    }),
    vertex: {
      module: shaderModule,
      entryPoint: "vert_main",
      buffers: vertexBufferlayout,
    },
    fragment: {
      module: shaderModule,
      entryPoint: "frag_main",
      targets: [{ format: presentationFormat, blend: blendState }],
    },
    primitive: { topology: renderOptions.topology ?? "triangle-list" },
    depthStencil: {
      depthWriteEnabled: true,
      depthCompare: "less",
      format: "depth24plus-stencil8",
    },
  });

  let needClear = true;
  let loadOp: GPULoadOp = (needClear ? "clear" : "load") as GPULoadOp;

  const renderPassDescriptor: GPURenderPassDescriptor = {
    colorAttachments: [
      {
        view: context.getCurrentTexture().createView(), // Assigned later
        clearValue: renderOptions.bgColor ?? [0.9, 0.9, 0.9, 1.0],
        loadOp: loadOp,
        storeOp: "store",
      },
    ],
    depthStencilAttachment: {
      view: atomDepthTexture.deref().createView(),
      depthClearValue: 1,
      depthLoadOp: loadOp,
      depthStoreOp: "store" as const,
      stencilLoadOp: "clear" as const,
      stencilStoreOp: "store" as const,
    },
  };

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

  let seedSize = initialParticleData.byteLength;

  let { particleBindGroups, mockedBindGroups } = setupParticlesBindGroups(
    device,
    computeParticlesLayout,
    particleBuffers,
    seedSize
  );

  let paramBuffer = buildParamBuffer(paramsData);

  let buildParamsBuffer = (partial: number[]) => {
    let data = paramsData.slice();
    partial.forEach((n, idx) => {
      data[idx] = n;
    });
    paramBuffer = buildParamBuffer(data);

    let ret = setupParticlesBindGroups(
      device,
      computeParticlesLayout,
      particleBuffers,
      seedSize
    );
    particleBindGroups = ret.particleBindGroups;
    mockedBindGroups = ret.mockedBindGroups;
  };

  window.__hotUpdateParams = buildParamsBuffer;

  return async function render(t: number, skipComputing: boolean = false) {
    const commandEncoder = device.createCommandEncoder();

    let uniformEntries: GPUBindGroupEntry[] = [
      { binding: 0, resource: { buffer: loadUniformBuffer() } },
      { binding: 1, resource: { buffer: paramBuffer } },
    ];

    if (!skipComputing) {
      const computePassEncoder = commandEncoder.beginComputePass();
      computePassEncoder.setPipeline(computePipeline);
      computePassEncoder.setBindGroup(
        0,
        device.createBindGroup({
          layout: device.createBindGroupLayout({
            entries: computeUniformEntries,
          }),
          entries: uniformEntries,
        })
      );
      computePassEncoder.setBindGroup(1, particleBindGroups[t % 2]);
      computePassEncoder.dispatchWorkgroups(Math.ceil(numParticles / 64));
      computePassEncoder.end();
    }

    (
      renderPassDescriptor.colorAttachments as GPURenderPassColorAttachment[]
    )[0].view = context.getCurrentTexture().createView();
    renderPassDescriptor.depthStencilAttachment.view = atomDepthTexture
      .deref()
      .createView();

    const passEncoder = commandEncoder.beginRenderPass(renderPassDescriptor);
    passEncoder.setPipeline(renderPipeline);
    passEncoder.setVertexBuffer(0, particleBuffers[(t + 1) % 2]);
    passEncoder.setVertexBuffer(1, buildSpriteVertexBuffer(vertexData));
    passEncoder.setBindGroup(
      0,
      device.createBindGroup({
        layout: device.createBindGroupLayout({
          entries: renderGroupEntries,
        }),
        entries: uniformEntries,
      })
    );
    passEncoder.setBindGroup(1, mockedBindGroups[t % 2]); // mocked

    if (indexBuffer != null) {
      passEncoder.setIndexBuffer(indexBuffer, "uint32");
      passEncoder.drawIndexed(
        renderOptions.indexData.length,
        numParticles,
        0,
        0
      );
    } else {
      passEncoder.draw(vertexCount, numParticles, 0, 0);
    }
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
    atomViewerScale.deref(),
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
  const vertexBufferData = new Uint32Array(data);

  const spriteVertexBuffer = device.createBuffer({
    size: vertexBufferData.byteLength,
    usage: GPUBufferUsage.VERTEX,
    mappedAtCreation: true,
  });
  new Uint32Array(spriteVertexBuffer.getMappedRange()).set(vertexBufferData);
  spriteVertexBuffer.unmap();

  return spriteVertexBuffer;
};

let buildParamBuffer = (data: number[]) => {
  let device = atomDevice.deref();

  const paramBufferSize = data.length * Float32Array.BYTES_PER_ELEMENT;
  const paramBuffer = device.createBuffer({
    size: paramBufferSize,
    usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
  });

  function updateParams() {
    device.queue.writeBuffer(paramBuffer, 0, new Float32Array(data));
  }

  updateParams();

  return paramBuffer;
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
