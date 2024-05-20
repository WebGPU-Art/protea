import { createRenderer } from "../index.mjs";
import computeCollision from "./debug-grid.wgsl?raw";
import { fiboGridN } from "../math.mjs";

export let loadRenderer = async (canvas: HTMLCanvasElement) => {
  let seedSize = 2000000;

  let renderFrame = await createRenderer(
    canvas,
    {
      seedSize,
      seedData: makeSeed(seedSize, 0),
      getParams: (dt) => [
        dt * 0.004, // deltaT
        0.6, // height
        0.2, // width
        0.8, // opacity
      ],
      computeShader: computeCollision,
    },
    {
      vertexCount: 1,
      vertexData: [0, 1, 2, 3],
      indexData: [0, 1, 2, 1, 2, 3],
      vertexBufferLayout: vertexBufferLayout,
      // topology: "line-list",
      bgColor: [0.1, 0.0, 0.2, 1.0],
    }
  );

  return renderFrame;
};

function makeSeed(numParticles: number, _s: number): Float32Array {
  const buf = new Float32Array(numParticles * 12);
  // let scale = 200 * (Math.random() * 0.5 + 0.5);
  let scale_base = 10;
  let i = 0;
  let each = Math.floor(Math.pow(numParticles, 1 / 3));
  for (let x = 0; x < each; x++) {
    for (let y = 0; y < each; y++) {
      for (let z = 0; z < each; z++) {
        let scale = scale_base + 0.0 * i;
        let p = [x - 0.5 * each, y - 0.5 * each, z - 0.5 * each];
        // let q = randPointInSphere(100);
        let b = 12 * i;
        buf[b + 0] = p[0] * scale;
        buf[b + 1] = p[1] * scale;
        buf[b + 2] = p[2] * scale;
        buf[b + 3] = i; // index
        buf[b + 4] = p[0] * scale;
        buf[b + 5] = p[1] * scale;
        buf[b + 6] = p[2] * scale;
        buf[b + 7] = 0;
        buf[b + 8] = 0;
        buf[b + 9] = 0;
        buf[b + 10] = 0;
        buf[b + 11] = 0;
        i += 1;
      }
    }
  }
  for (let i = 0; i < numParticles; ++i) {}

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
