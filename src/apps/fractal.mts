import { createRenderer, resetCanvasSize } from "../index.mjs";
import fractalSprite from "../../shaders/fractal-sprite.wgsl?raw";
import fractalCompute from "../../shaders/fractal-compute.wgsl?raw";

export let loadFractalRenderer = async (canvas: HTMLCanvasElement) => {
  let seedSize = 1000000;

  let renderFrame = await createRenderer(
    canvas,
    {
      seedSize,
      seedData: makeSeed(seedSize),
      params: loadParams(),
      computeShader: fractalCompute,
    },
    {
      vertexCount: 1,
      vertexData: loadVertex(),
      indexData: [0, 1, 2, 1, 2, 3],
      vertexBufferLayout: vertexBufferLayout,
      renderShader: fractalSprite,
      // topology: "line-list",
      bgColor: [0.1, 0.0, 0.2, 1.0],
    }
  );

  return renderFrame;
};

const PHI = 0.5 * (Math.sqrt(5) - 1);

let fiboGridN = (n: number, total: number): [number, number, number] => {
  let z = (2 * n - 1) / total - 1;
  let t = Math.sqrt(1 - z * z);
  let t2 = 2 * Math.PI * PHI * n;
  let x = t * Math.cos(t2);
  let y = t * Math.sin(t2);
  return [x, y, z];
};

let fiboGridRange = (total: number) => {
  let out: [number, number, number][] = [];
  for (let i = 0; i < total; ++i) {
    out.push(fiboGridN(i, total));
  }
  return out;
};

function makeSeed(numParticles: number): Float32Array {
  const buf = new Float32Array(numParticles * 8);

  let counted = 0;
  let scale = 0.2;
  let v_scale = 2.5;

  for (let i = 0; i < numParticles; ++i) {
    let b = 8 * counted;
    let [x, y, z] = fiboGridN(i, numParticles);
    buf[b + 0] = x * scale;
    buf[b + 1] = y * scale;
    buf[b + 2] = z * scale;
    buf[b + 3] = 0.0006;
    buf[b + 4] = 1;
    buf[b + 5] = 0;
    buf[b + 6] = 0;
    buf[b + 7] = 0;
    counted++;
  }

  return buf;
}

function loadParams(): number[] {
  return [
    0.04, // deltaT
    0.06, // height
    0.004, // width
    0.99, // opacity
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
    arrayStride: 8 * 4,
    stepMode: "instance",
    attributes: [
      { shaderLocation: 0, offset: 0, format: "float32x3" },
      { shaderLocation: 1, offset: 4 * 3, format: "float32" },
      { shaderLocation: 2, offset: 4 * 4, format: "float32" },
      { shaderLocation: 3, offset: 4 * 5, format: "float32" },
      { shaderLocation: 4, offset: 4 * 6, format: "float32" },
      { shaderLocation: 5, offset: 4 * 7, format: "float32" },
    ],
  },
  {
    // vertex buffer
    arrayStride: 1 * 4,
    stepMode: "vertex",
    attributes: [{ shaderLocation: 6, offset: 0, format: "uint32" }],
  },
];
