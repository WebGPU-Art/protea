import { createRenderer } from "../index.mjs";
import computeOrbits from "./orbits-2.wgsl?raw";
import { fiboGridN } from "../math.mjs";

export let loadRenderer = async (canvas: HTMLCanvasElement) => {
  let seedSize = 4194240;
  //  4194304

  let renderFrame = await createRenderer(
    canvas,
    {
      seedSize,
      seedData: makeSeed(seedSize, 0),
      params: [
        0.004, // deltaT
        0.6, // height
        0.2, // width
        0.8, // opacity
      ],
      // computeShader: updateSpritesWGSL,
      // computeShader: computeGravityWgsl,
      computeShader: computeOrbits,
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

// let vv: [number, number] = [5.46, 4.55];
// // vv = [0.848, 4.783];
// // vv = [1.158, 1.93];
// // vv = [3.667, 3.934];
// // vv = [3.536, 5.575];
// // vv = [5.655, 5.16];
// // vv = [5.937, 5.482];
// // vv = [2.3, 2.72];
// // vv = [5.46, 4.55];
// // vv = [3.65, 4.58];
// // vv = [0.02, 1.07];
// vv = [5.68, 5.02];

// let iterate = (p: [number, number]): [number, number] => {
//   let x = p[0];
//   let y = p[1];
//   let next_x = Math.sin(x * x - y * y + vv[0]);
//   let next_y = Math.cos(2 * x * y + vv[1]);
//   return [next_x, next_y];
// };

function makeSeed(numParticles: number, _s: number): Float32Array {
  const unit = 8;
  const buf = new Float32Array(numParticles * unit);
  // let scale = 200 * (Math.random() * 0.5 + 0.5);
  let scale_base = 1;
  // let p = [-0.4, 0.6] as [number, number];
  // p = [Math.random(), Math.random()];
  for (let i = 0; i < numParticles; ++i) {
    // let q = randPointInSphere(100);
    let p = fiboGridN(i, numParticles).slice(0, 2) as [number, number];
    // for (let j = 0; j < 20; ++j) {
    //   p = iterate(p);
    // }
    let b = unit * i;
    // buf[b + 0] = p[0] * scale;
    // buf[b + 1] = p[1] * scale;
    buf[b + 0] = p[0] * scale_base;
    buf[b + 1] = p[1] * scale_base;
    buf[b + 2] = Math.random();
    buf[b + 3] = 0; // times
    buf[b + 4] = p[0] * scale_base;
    buf[b + 5] = p[1] * scale_base;
    buf[b + 6] = Math.random();
    buf[b + 7] = 0; // times
    // p = iterate(p);
  }

  return buf;
}

let vertexBufferLayout: GPUVertexBufferLayout[] = [
  {
    // instanced particles buffer
    arrayStride: 8 * 4,
    stepMode: "instance",
    attributes: [
      { shaderLocation: 0, offset: 0, format: "float32x3" },
      { shaderLocation: 1, offset: 3 * 4, format: "float32" },
      { shaderLocation: 2, offset: 4 * 4, format: "float32x3" },
      { shaderLocation: 3, offset: 7 * 4, format: "float32" },
    ],
  },
  {
    // vertex buffer
    arrayStride: 1 * 4,
    stepMode: "vertex",
    attributes: [{ shaderLocation: 4, offset: 0, format: "uint32" }],
  },
];
