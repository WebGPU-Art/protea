import { createRenderer } from "../index.mjs";
import computeShader from "./lifegame.wgsl?raw";

export let loadRenderer = async (canvas: HTMLCanvasElement) => {
  let seedSize = 160;

  let renderFrame = await createRenderer(
    canvas,
    {
      seedSize: seedSize * seedSize * seedSize,
      seedData: makeSeed(seedSize, 0),
      params: [
        0.004, // deltaT
        0.6, // height
        0.2, // width
        0.8, // opacity
      ],
      computeShader: computeShader,
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

let scale = 8;

function makeSeed(size: number, _s: number): Float32Array {
  const buf = new Float32Array(size * size * size * 4);
  for (let i = 0; i < size; ++i) {
    for (let j = 0; j < size; ++j) {
      for (let k = 0; k < size; ++k) {
        // let scale = scale_base + 0.0 * i;
        let b = (i * size * size + j * size + k) * 4;
        // console.log("b", b, i, j, k);
        buf[b + 0] = (i - 0.5 * size) * scale;
        buf[b + 1] = (j - 0.5 * size) * scale;
        buf[b + 2] = (k - 0.5 * size) * scale;
        buf[b + 3] = Math.random() * 100;
      }
    }
  }

  return buf;
}

let vertexBufferLayout: GPUVertexBufferLayout[] = [
  {
    // instanced particles buffer
    arrayStride: 4 * 4,
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
