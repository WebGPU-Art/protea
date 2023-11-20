import { createRenderer } from "../index.mjs";
import spriteShader from "../../shaders/bifurcation-sprites.wgsl?raw";
import computeShader from "../../shaders/bifurcation-compute.wgsl?raw";
import { rand_middle } from "../util.mjs";

export let loadBifurcationRenderer = async (canvas: HTMLCanvasElement) => {
  let seedSize = 2700000;

  let renderFrame = await createRenderer(
    canvas,
    {
      seedSize,
      seedData: makeSeed(seedSize, 0),
      params: loadParams(),
      // computeShader: updateSpritesWGSL,
      // computeShader: computeGravityWgsl,
      computeShader: computeShader,
    },
    {
      vertexCount: 1,
      vertexData: loadVertex(),
      indexData: [0, 1, 2, 1, 2, 3],
      vertexBufferLayout: vertexBufferLayout,
      renderShader: spriteShader,
      // topology: "line-list",
      bgColor: [0.1, 0.0, 0.2, 1.0],
    }
  );

  return renderFrame;
};

function makeSeed(numParticles: number, _s: number): Float32Array {
  const buf = new Float32Array(numParticles * 12);
  const scale = 800;
  for (let i = 0; i < numParticles; ++i) {
    let b = 4 * i;
    buf[b + 0] = rand_middle(scale);
    buf[b + 1] = rand_middle(scale);
    buf[b + 2] = rand_middle(scale);
    buf[b + 3] = i; // index
  }

  return buf;
}

function loadParams(): number[] {
  return [
    0.004, // deltaT
    0.6, // height
    0.2, // width
    0.8, // opacity
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
    arrayStride: 12 * 4,
    stepMode: "instance",
    attributes: [
      { shaderLocation: 0, offset: 0, format: "float32x3" },
      { shaderLocation: 1, offset: 3 * 4, format: "float32" },
    ],
  },
  {
    // vertex buffer
    arrayStride: 1 * 4,
    stepMode: "vertex",
    attributes: [{ shaderLocation: 2, offset: 0, format: "uint32" }],
  },
];
