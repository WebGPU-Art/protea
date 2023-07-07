import { createRenderer, resetCanvasSize } from "./index.mjs";
import spriteWGSL from "../shaders/sprite.wgsl?raw";
import updateSpritesWGSL from "../shaders/update-sprites.wgsl?raw";
import computeGravityWgsl from "../shaders/compute-gravity.wgsl?raw";
import computeLorenz from "../shaders/compute-lorenz.wgsl?raw";
import computeFireworks from "../shaders/compute-fireworks.wgsl?raw";

function getPoint() {
  var u = Math.random();
  var v = Math.random();
  var theta = u * 2.0 * Math.PI;
  var phi = Math.acos(2.0 * v - 1.0);
  var r = Math.cbrt(Math.random() + 4.0);
  var sinTheta = Math.sin(theta);
  var cosTheta = Math.cos(theta);
  var sinPhi = Math.sin(phi);
  var cosPhi = Math.cos(phi);
  var x = r * sinPhi * cosTheta;
  var y = r * sinPhi * sinTheta;
  var z = r * cosPhi;
  return { x: x, y: y, z: z };
}

export let loadRenderer = async (canvas: HTMLCanvasElement) => {
  let seedSize = 2000000;

  let renderFrame = await createRenderer(
    canvas,
    {
      seedSize,
      seedData: makeSeed(seedSize, 0),
      params: loadParams(),
      // computeShader: updateSpritesWGSL,
      // computeShader: computeGravityWgsl,
      computeShader: computeFireworks,
    },
    {
      vertexCount: 1,
      vertexData: loadVertex(),
      indexData: [0, 1, 2, 1, 2, 3],
      vertexBufferLayout: vertexBufferLayout,
      renderShader: spriteWGSL,
      // topology: "line-list",
      bgColor: [0.1, 0.0, 0.2, 1.0],
    }
  );

  return renderFrame;
};

function rand_middle(n: number) {
  return n * (Math.random() - 0.5);
}

function makeSeed(numParticles: number, scale: number): Float32Array {
  const buf = new Float32Array(numParticles * 12);
  let offset = 0.5;
  let base = 0;
  for (let i = 0; i < numParticles; ++i) {
    let p = getPoint();
    let q = getPoint();
    let b = 12 * i;
    buf[b + 0] = p.x * scale;
    buf[b + 1] = p.y * scale;
    buf[b + 2] = p.z * scale;
    buf[b + 3] = 0; // ages
    buf[b + 4] = 10;
    buf[b + 5] = 10;
    buf[b + 6] = 10;
    buf[b + 7] = rand_middle(50000); // distance
    buf[b + 8] = q.x * 100; // velocity
    buf[b + 9] = 40 + q.y * 100;
    buf[b + 10] = q.z * 100;
    buf[b + 11] = 0;
  }

  return buf;
}

function loadParams(): number[] {
  const simParams = {
    deltaT: 0.004,
    height: 0.6,
    width: 0.2,
    opacity: 0.8,
    rule1Scale: 0.02,
    rule2Scale: 0.05,
    rule3Scale: 0.005,
  };
  return [
    simParams.deltaT,
    simParams.height,
    simParams.width,
    simParams.opacity,
    simParams.rule1Scale,
    simParams.rule2Scale,
    simParams.rule3Scale,
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

if (import.meta.hot) {
  import.meta.hot.accept("./globals", (newModule) => {
    // globals reloading
  });
}
