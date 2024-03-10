import { createRenderer } from "../index.mjs";
import computeSpark from "./orbit-spark.wgsl?raw";
import { fiboGridN, fiboGridN_snd, rand_middle } from "../math.mjs";

export let loadRenderer = async (canvas: HTMLCanvasElement) => {
  let seedSize = 400000;

  let renderFrame = await createRenderer(
    canvas,
    {
      seedSize,
      seedData: makeSeed(seedSize, 0),
      params: [
        0.04, // deltaT
        600.0, // scale
        0.001, // width
        0.99, // opacity
      ],
      computeShader: computeSpark,
    },
    {
      vertexCount: 1,
      vertexData: [0, 1, 2, 3],
      indexData: [0, 1, 2, 1, 2, 3],
      vertexBufferLayout: vertexBufferLayout,
      renderShader: computeSpark,
      // topology: "line-list",
      bgColor: [0.1, 0.0, 0.2, 1.0],
    }
  );

  return renderFrame;
};

let randPoint: [number, number, number] = [0, 0, 0];
let area = 1.0;

function makeSeed(numParticles: number, scale: number): Float32Array {
  const buf = new Float32Array(numParticles * 12);

  for (let i = 0; i < numParticles; ++i) {
    if (i % 24 == 0) {
      let p = [
        Math.random() * 0.2,
        0.4 + Math.random() * 0.2,
        Math.random() * 0.2,
      ] as [number, number, number];
      randPoint = p;
    }

    let b = 12 * i;
    buf[b + 0] = randPoint[0];
    buf[b + 1] = randPoint[1];
    buf[b + 2] = randPoint[2];
    buf[b + 3] = rand_middle(0.8); // ages
    buf[b + 4] = randPoint[0];
    buf[b + 5] = randPoint[1];
    buf[b + 6] = randPoint[2];
    buf[b + 7] = 0; // distance
    buf[b + 8] = 2.0 + rand_middle(1.0);
    buf[b + 9] = 0;
    buf[b + 10] = 0;
    buf[b + 11] = 0;
  }

  return buf;
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
      { shaderLocation: 4, offset: 8 * 4, format: "float32x3" },
      { shaderLocation: 5, offset: 11 * 4, format: "float32" },
    ],
  },
  {
    // vertex buffer
    arrayStride: 1 * 4,
    stepMode: "vertex",
    attributes: [{ shaderLocation: 6, offset: 0, format: "uint32" }],
  },
];
