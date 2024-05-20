import { createRenderer } from "../../index.mjs";
import attractorCompute from "./dequanli.wgsl?raw";
import { fiboGridN, rand_middle } from "../../math.mjs";

export let loadRenderer = async (canvas: HTMLCanvasElement) => {
  // let seedSize = 2000000;
  let seedSize = 2000000;

  let renderFrame = await createRenderer(
    canvas,
    {
      seedSize,
      seedData: makeSeed(seedSize, 0),
      getParams: (dt) => {
        return [
          dt * 0.04, // deltaT
          20.0, // scale
          0.008, // width
          0.99, // opacity
        ];
      },
      computeShader: attractorCompute,
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

let randPoint: [number, number, number] = [0, 0, 0];
let area = 80;

function makeSeed(numParticles: number, scale: number): Float32Array {
  const buf = new Float32Array(numParticles * 8);

  for (let i = 0; i < numParticles; ++i) {
    if (i % 20 == 0) {
      // let p = fiboGridN(i, numParticles);
      randPoint = [
        1.5 + rand_middle(area),
        3.2 + rand_middle(area),
        0.4 + rand_middle(area),
      ];
    }
    // console.log(randPoint);
    let b = 8 * i;
    buf[b + 0] = randPoint[0];
    buf[b + 1] = randPoint[1];
    buf[b + 2] = randPoint[2];
    buf[b + 3] = i / 20; // ages
    buf[b + 4] = randPoint[0];
    buf[b + 5] = randPoint[1];
    buf[b + 6] = randPoint[2];
    buf[b + 7] = 0; // distance
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
