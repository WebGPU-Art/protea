import { createRenderer } from "../index.mjs";
import computeCollision from "./lamps.wgsl?raw";
import { fiboGridN } from "../math.mjs";

export let loadRenderer = async (canvas: HTMLCanvasElement) => {
  let seedSize = 30000;

  let renderFrame = await createRenderer(
    canvas,
    {
      seedSize,
      seedData: makeSeed(seedSize, 0),
      getParams: (dt) => [
        dt * 0.2, // deltaT
        0.6, // height
        0.2, // width
        0.8, // opacity
      ],
      computeShader: computeCollision,
    },
    {
      vertexCount: 1,
      vertexData: [
        0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
        // up
        12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23,
      ],
      indexData: [
        // face 1
        0, 1, 12, 1, 12, 13,
        // face 2
        1, 2, 13, 2, 13, 14,
        // face 3
        2, 3, 14, 3, 14, 15,
        // face 4
        3, 4, 15, 4, 15, 16,
        // face 5
        4, 5, 16, 5, 16, 17,
        // face 6
        5, 6, 17, 6, 17, 18,
        // face 7
        6, 7, 18, 7, 18, 19,
        // face 8
        7, 8, 19, 8, 19, 20,
        // face 9
        8, 9, 20, 9, 20, 21,
        // face 10
        9, 10, 21, 10, 21, 22,
        // face 11
        10, 11, 22, 11, 22, 23,
        // face 12
        11, 0, 23, 0, 23, 12,
        // top cover 1
        12, 13, 14,
        // top cover 2
        12, 14, 15,
        // top cover 3
        12, 15, 16,
        // top cover 4
        12, 16, 17,
        // top cover 5
        12, 17, 18,
        // top cover 6
        12, 18, 19,
        // top cover 7
        12, 19, 20,
        // top cover 8
        12, 20, 21,
        // top cover 9
        12, 21, 22,
        // top cover 10
        12, 22, 23,
      ],
      vertexBufferLayout: vertexBufferLayout,
      // topology: "line-list",
      bgColor: [0.0, 0.0, 0.0, 1.0],
    }
  );

  return renderFrame;
};

function makeSeed(numParticles: number, _s: number): Float32Array {
  const buf = new Float32Array(numParticles * 12);
  // let scale = 200 * (Math.random() * 0.5 + 0.5);
  let scale = 600;
  let radius = 80000;
  for (let i = 0; i < numParticles; ++i) {
    let p = [
      radius * (Math.random() - 0.5),
      0.2 * radius * (Math.random() - 0.5),
      radius * (Math.random() - 0.5),
    ];
    let v = [
      scale * (Math.random() - 0.5),
      scale * (Math.random() - 0.5),
      scale * (Math.random() - 0.5),
    ];
    // let q = randPointInSphere(100);
    let b = 12 * i;
    buf[b + 0] = p[0];
    buf[b + 1] = p[1];
    buf[b + 2] = p[2];
    buf[b + 3] = i; // index
    buf[b + 4] = v[0];
    buf[b + 5] = v[1];
    buf[b + 6] = v[2];
    buf[b + 7] = 0;
    buf[b + 8] = 0;
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
