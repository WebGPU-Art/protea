import { createRenderer } from "../index.mjs";
import computeShader from "./rule30.wgsl?raw";
import { rand_middle } from "../math.mjs";
import * as config from "../config.mjs";

export let loadRenderer = async (canvas: HTMLCanvasElement) => {
  let gridSize = 300;

  let renderFrame = await createRenderer(
    canvas,
    {
      skipComputing: config.skipComputing,
      seedSize: gridSize * gridSize,
      seedData: makeSeed(gridSize, 0),
      getParams: (dt) => [
        dt * 0.004, // deltaT
        0.6, // height
        0.2, // width
        // change every 3 seconds
        Math.round(0.333 * new Date().getSeconds()),
      ],
      computeShader: computeShader,
    },
    {
      vertexCount: 1,
      vertexData: [0, 1, 2, 3, 4, 5],
      indexData: [0, 1, 2, 0, 2, 3, 0, 3, 4, 0, 4, 5],
      vertexBufferLayout: vertexBufferLayout,
      // topology: "line-list",
      bgColor: [0.1, 0.0, 0.2, 1.0],
    }
  );

  return renderFrame;
};

let rule: [
  /** 00 */ number,
  /** 01 */ number,
  /** 10 */ number,
  /** 11 */ number
] = [1, 0, 0, 1];

/**
 * turn a and b into 2 bits than into a number,
 * then read result from rule
 */
let calcByRule = (a: 0 | 1, b: 0 | 1) => {
  // check invalid input
  if (a > 1 || b > 1) {
    return 0;
  }
  let ret = rule[a * 2 + b];
  // console.log(a, b, "=>", ret);
  return ret;
};

function makeSeed(gridSize: number, _s: number): Float32Array {
  const buf = new Float32Array(gridSize * gridSize * 4);

  for (let y = 0; y < gridSize; ++y) {
    for (let x = 0; x < gridSize; ++x) {
      let b = 4 * (y * gridSize + x);
      buf[b + 0] = x;
      buf[b + 1] = y;
      buf[b + 2] = 0;
      buf[b + 3] = x + y < 10 ? 1 : 0;
    }
  }

  // read value from buf as 2d list at x y
  let getXy = (x: number, y: number) => {
    if (x < 0 || y < 0) {
      return undefined;
    }
    return buf[4 * (y * gridSize + x) + 3];
  };

  for (let bound = 0; bound < gridSize * 2; bound++) {
    let displayBuffer = "";

    for (let x = 0; x <= bound; ++x) {
      let y = bound - x;
      if (x < gridSize && y < gridSize) {
        let vA = getXy(x - 1, y) as 0 | 1;
        if (vA == null) {
          // vA = bound % 7 === 0 ? 1 : 0;
          vA = Math.random() > 0.5 ? 1 : 0;
        }
        let vB = getXy(x, y - 1) as 0 | 1;
        if (vB == null) {
          // vB = bound % 11 === 0 ? 1 : 0;
          vB = Math.random() > 0.5 ? 1 : 0;
        }
        let v = calcByRule(vA, vB);
        displayBuffer = `${displayBuffer}${v || "_"}`;
        buf[4 * (y * gridSize + x) + 3] = v;
      }
    }
    // console.log(bound + " % " + displayBuffer);
  }

  // console.log(buf);

  return buf;
}

let vertexBufferLayout: GPUVertexBufferLayout[] = [
  {
    // instanced particles buffer
    arrayStride: 4 * 4,
    stepMode: "instance",
    attributes: [
      { shaderLocation: 0, offset: 0, format: "float32" },
      { shaderLocation: 1, offset: 1 * 4, format: "float32" },
      { shaderLocation: 2, offset: 2 * 4, format: "uint32" },
      { shaderLocation: 3, offset: 3 * 4, format: "uint32" },
    ],
  },
  {
    // vertex buffer
    arrayStride: 1 * 4,
    stepMode: "vertex",
    attributes: [{ shaderLocation: 4, offset: 0, format: "uint32" }],
  },
];
