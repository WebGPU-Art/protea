import { onControlEvent } from "./control.mjs";
import { renderControl, startControlLoop } from "@triadica/touch-control";
import { createDepthTexture } from "./buffer.mjs";
import { atomDepthTexture, atomDevice } from "./globals.mjs";
import { createRenderer } from "./render.mjs";

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

  let renderFrame = await createRenderer(canvas as HTMLCanvasElement);

  let t = 0;
  let renderer = () => {
    ++t;
    setTimeout(() => {
      requestAnimationFrame(renderer);
    }, 200);
    renderFrame(t);
  };

  renderer();

  window.onresize = () => {
    resetCanvasSize(canvas);
    atomDepthTexture.reset(createDepthTexture());
  };
};

export function resetCanvasSize(canvas: HTMLCanvasElement) {
  // canvas height not accurate on Android Pad, use innerHeight
  canvas.style.height = `${window.innerHeight}px`;
  canvas.style.width = `${window.innerWidth}px`;
  canvas.height = window.innerHeight * devicePixelRatio;
  canvas.width = window.innerWidth * devicePixelRatio;
}

declare global {
  /** dirty hook for extracting error messages */
  var __lagopusHandleCompilationInfo: (
    info: GPUCompilationInfo,
    code: string
  ) => void;
}
