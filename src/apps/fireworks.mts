import { createRenderer } from "../index.mjs";
import fireworksCompute from "./fireworks.wgsl?raw";
import { randPointInSphere } from "../util.mjs";
import { rand_middle } from "../math.mjs";

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
      computeShader: fireworksCompute,
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

function makeSeed(numParticles: number, scale: number): Float32Array {
  const buf = new Float32Array(numParticles * 12);
  let offset = 0.5;
  let base = 0;
  for (let i = 0; i < numParticles; ++i) {
    let p = randPointInSphere(scale);
    let q = randPointInSphere(100);
    let b = 12 * i;
    buf[b + 0] = p.x;
    buf[b + 1] = p.y;
    buf[b + 2] = p.z;
    buf[b + 3] = 0; // ages
    buf[b + 4] = 10;
    buf[b + 5] = 10;
    buf[b + 6] = 10;
    buf[b + 7] = rand_middle(50000); // distance
    buf[b + 8] = q.x; // velocity
    buf[b + 9] = 40 + q.y;
    buf[b + 10] = q.z;
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
