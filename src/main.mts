import { onControlEvent } from "./control.mjs";
import { renderControl, startControlLoop } from "@triadica/touch-control";
import { createDepthTexture } from "./buffer.mjs";
import { atomDepthTexture, atomDevice } from "./globals.mjs";
import { createRenderer, resetCanvasSize } from "./render.mjs";

window.onload = async () => {
  if (navigator.gpu == null) {
    alert("WebGPU is required to run this sample.");
  }

  const adapter = await navigator.gpu.requestAdapter();
  const device = await adapter.requestDevice();

  atomDevice.reset(device);

  let canvas = document.querySelector("#canvas-container") as HTMLCanvasElement;
  renderControl();
  startControlLoop(10, onControlEvent);
  resetCanvasSize(canvas);

  atomDepthTexture.reset(createDepthTexture());

  let renderFrame = await createRenderer(
    canvas,
    makeSeed,
    loadParams,
    loadVertex
  );

  let t = 0;
  let renderer = () => {
    t++;
    setTimeout(() => {
      requestAnimationFrame(renderer);
    }, 20);
    renderFrame(t);
  };

  renderer();
  window["rrr"] = renderer;

  window.onresize = () => {
    resetCanvasSize(canvas);
    atomDepthTexture.reset(createDepthTexture());
  };
};

function makeSeed(): {
  size: number;
  data: Float32Array;
} {
  const numParticles = 400;
  const initialParticleData = new Float32Array(numParticles * 8);
  for (let i = 0; i < numParticles; ++i) {
    initialParticleData[6 * i + 0] = 2 * (Math.random() - 0.5);
    initialParticleData[6 * i + 1] = 2 * (Math.random() - 0.5);
    // initialParticleData[6 * i + 0] = 0.0;
    // initialParticleData[6 * i + 1] = 0.0;
    initialParticleData[6 * i + 2] = 0;
    initialParticleData[6 * i + 3] = 0;
    // initialParticleData[6 * i + 2] = 2 * (Math.random() - 0.5);
    initialParticleData[6 * i + 4] = 2 * (Math.random() - 0.5) * 0.1;
    initialParticleData[6 * i + 5] = 2 * (Math.random() - 0.5) * 0.1;
    // initialParticleData[6 * i + 4] = 0.0;
    // initialParticleData[6 * i + 5] = 0.0;
    // initialParticleData[6 * i + 6] = 2 * (Math.random() - 0.5) * 0.1;
    initialParticleData[6 * i + 6] = 0;
    initialParticleData[6 * i + 7] = 0;
  }

  return {
    size: numParticles,
    data: initialParticleData,
  };
}

function loadParams(): number[] {
  const simParams = {
    deltaT: 0.04,
    rule1Distance: 0.1,
    rule2Distance: 0.025,
    rule3Distance: 0.025,
    rule1Scale: 0.02,
    rule2Scale: 0.05,
    rule3Scale: 0.005,
  };
  return [
    simParams.deltaT,
    simParams.rule1Distance,
    simParams.rule2Distance,
    simParams.rule3Distance,
    simParams.rule1Scale,
    simParams.rule2Scale,
    simParams.rule3Scale,
  ];
}

function loadVertex(): number[] {
  return [-0.01, -0.02, 0.01, -0.02, 0.0, 0.02];
}

declare global {
  /** dirty hook for extracting error messages */
  var __lagopusHandleCompilationInfo: (
    info: GPUCompilationInfo,
    code: string
  ) => void;

  // to be triggered from command
  var rrr: () => void;
}
