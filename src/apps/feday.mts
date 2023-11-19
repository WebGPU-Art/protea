import { createRenderer } from "../index.mjs";
import spriteShader from "../../shaders/feday-sprites.wgsl?raw";
import computeShader from "../../shaders/feday-compute.wgsl?raw";
import { randPointInSphere, rand_middle } from "../util.mjs";
import { fiboGridN } from "../math.mjs";

export let loadFedayRenderer = async (canvas: HTMLCanvasElement) => {
  let seedSize = 800000;

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
  // let scale = 200 * (Math.random() * 0.5 + 0.5);
  let scale_base = 240;
  for (let i = 0; i < numParticles; ++i) {
    let scale = scale_base + 0.0 * i;
    let p = fiboGridN(i, numParticles);
    // let q = randPointInSphere(100);
    let b = 12 * i;
    buf[b + 0] = -60;
    buf[b + 1] = 0;
    buf[b + 2] = 0.0001;
    buf[b + 3] = i; // index
    buf[b + 4] = p[0] * scale;
    buf[b + 5] = p[1] * scale;
    buf[b + 6] = p[2] * scale;
    buf[b + 7] = 0;
    buf[b + 8] = 0;
    buf[b + 9] = 0;
    buf[b + 10] = 0;
    buf[b + 11] = 0;
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
      { shaderLocation: 2, offset: 4 * 4, format: "float32x3" },
      { shaderLocation: 3, offset: 7 * 4, format: "float32" },
      { shaderLocation: 4, offset: 8 * 4, format: "float32x4" },
    ],
  },
  {
    // vertex buffer
    arrayStride: 1 * 4,
    stepMode: "vertex",
    attributes: [{ shaderLocation: 5, offset: 0, format: "uint32" }],
  },
];
