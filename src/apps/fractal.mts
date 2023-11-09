import { createRenderer, resetCanvasSize } from "../index.mjs";
import fractalSprite from "../../shaders/fractal-sprite.wgsl?raw";
import fractalCompute from "../../shaders/fractal-compute.wgsl?raw";

let limit = 160;

export let loadFractalRenderer = async (canvas: HTMLCanvasElement) => {
  let seedSize = Math.pow(limit, 3);

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

function rand_middle(n: number) {
  return n * (Math.random() - 0.5);
}

function makeSeed(numParticles: number): Float32Array {
  const buf = new Float32Array(numParticles * 8);

  let counted = 0;
  let scale = 0.8;
  let v_scale = 2.5;

  for (let xi = 0; xi < limit; ++xi) {
    for (let yi = 0; yi < limit; ++yi) {
      for (let zi = 0; zi < limit; ++zi) {
        if (counted >= numParticles) {
          break;
        }
        let b = 8 * counted;
        let xr = xi / limit - 0.5;
        let yr = yi / limit - 0.5;
        let zr = zi / limit - 0.5;
        buf[b + 0] = xr * scale;
        buf[b + 1] = yr * scale;
        buf[b + 2] = zr * scale;
        buf[b + 3] = 0;
        buf[b + 4] = 0.2;
        buf[b + 5] = yr * v_scale;
        buf[b + 6] = zr * v_scale;
        buf[b + 7] = xr * v_scale;
        counted++;
      }
    }
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
      { shaderLocation: 0, offset: 0, format: "float32x4" },
      { shaderLocation: 1, offset: 4 * 4, format: "float32x4" },
    ],
  },
  {
    // vertex buffer
    arrayStride: 1 * 4,
    stepMode: "vertex",
    attributes: [{ shaderLocation: 2, offset: 0, format: "uint32" }],
  },
];
