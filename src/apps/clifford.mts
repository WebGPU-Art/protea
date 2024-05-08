import { createRenderer } from "../index.mjs";
import computeOrbits from "./clifford.wgsl?raw";
import { fiboGridN } from "../math.mjs";

export let loadRenderer = async (canvas: HTMLCanvasElement) => {
  let seedSize = 4194240;
  //  4194304

  let renderFrame = await createRenderer(
    canvas,
    {
      seedSize,
      seedData: makeSeed(seedSize, 0),
      getParams: () => [
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

function makeSeed(numParticles: number, _s: number): Float32Array {
  const unit = 8;
  const buf = new Float32Array(numParticles * unit);
  // let scale = 200 * (Math.random() * 0.5 + 0.5);
  let scale_base = 2;
  // let p = [-0.4, 0.6] as [number, number];
  // p = [Math.random(), Math.random()];
  for (let i = 0; i < numParticles; ++i) {
    let p = fiboGridN(i, numParticles).slice(0, 2) as [number, number];

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
