import { createRenderer, resetCanvasSize } from "./render.mjs";
import spriteWGSL from "../shaders/sprite.wgsl?raw";
import updateSpritesWGSL from "../shaders/update-sprites.wgsl?raw";
import computeGravityWgsl from "../shaders/compute-gravity.wgsl?raw";
import computeLorenz from "../shaders/compute-lorenz.wgsl?raw";

export let loadRenderer = async (canvas: HTMLCanvasElement) => {
  let seedSize = 800000;

  let renderFrame = await createRenderer(
    canvas,
    {
      seedSize,
      seedData: makeSeed(seedSize, 10),
      params: loadParams(),
      // computeShader: updateSpritesWGSL,
      // computeShader: computeGravityWgsl,
      computeShader: computeLorenz,
    },
    {
      vertexCount: 1,
      vertexData: loadVertex(),
      indexData: [0, 1, 2, 0, 1, 3, 0, 2, 3, 1, 2, 3],
      vertexBufferLayout: vertexBufferLayout,
      renderShader: spriteWGSL,
      // topology: "line-list",
      bgColor: [0.1, 0.0, 0.2, 1.0],
    }
  );

  return renderFrame;
};

function makeSeed(numParticles: number, scale: number): Float32Array {
  const initialParticleData = new Float32Array(numParticles * 8);
  let offset = 0.0;
  for (let i = 0; i < numParticles; ++i) {
    initialParticleData[8 * i + 0] = 0.4 * (Math.random() - offset) * scale;
    initialParticleData[8 * i + 1] = 0.4 * (Math.random() - offset) * scale;
    initialParticleData[8 * i + 2] = 0.4 * (Math.random() - offset) * scale;
    // initialParticleData[8 * i + 2] = 0 * scale;
    initialParticleData[8 * i + 3] = 0 * scale;
    initialParticleData[8 * i + 4] = 0 * (Math.random() - offset) * scale;
    initialParticleData[8 * i + 5] = 0 * (Math.random() - offset) * scale;
    initialParticleData[8 * i + 6] = 0 * (Math.random() - offset) * scale;
    // initialParticleData[8 * i + 6] = 0 * scale;
    initialParticleData[8 * i + 7] = 0 * scale;
  }

  return initialParticleData;
}

function loadParams(): number[] {
  const simParams = {
    deltaT: 0.04,
    height: 1.2,
    width: 0.06,
    opacity: 0.8,
    rule1Scale: 0.02,
    rule2Scale: 0.05,
    rule3Scale: 0.005,
  };
  return [
    simParams.deltaT,
    simParams.height,
    simParams.width,
    simParams.opacity,
    simParams.rule1Scale,
    simParams.rule2Scale,
    simParams.rule3Scale,
  ];
}

function loadVertex(): number[] {
  // prettier-ignore
  return [
    0, 1, 2, 3
    // -0.06, -0.06, -0.03,
    // 0.06, -0.06, -0.03,
    // 0.0, 0.06, 0,
    // 0.0, -0.06, 0.03,
  ];
}

let vertexBufferLayout: GPUVertexBufferLayout[] = [
  {
    // instanced particles buffer
    arrayStride: 8 * 4,
    stepMode: "instance",
    attributes: [
      { shaderLocation: 0, offset: 0, format: "float32x3" },
      { shaderLocation: 1, offset: 4 * 4, format: "float32x3" },
      { shaderLocation: 2, offset: 7 * 4, format: "float32" },
    ],
  },
  {
    // vertex buffer
    arrayStride: 1 * 4,
    stepMode: "vertex",
    attributes: [{ shaderLocation: 3, offset: 0, format: "float32" }],
  },
];

if (import.meta.hot) {
  import.meta.hot.accept("./globals", (newModule) => {
    // globals reloading
  });
}
