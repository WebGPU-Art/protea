import queryString from "query-string";
import { onControlEvent } from "./control.mjs";
import { renderControl, startControlLoop } from "@triadica/touch-control";
import { createDepthTexture } from "./buffer.mjs";
import { atomDepthTexture, atomDevice } from "./globals.mjs";
import { resetCanvasSize } from "./render.mjs";
import { loadRenderer } from "./app.mjs";
import { setupRemoteControl } from "./remote-control.mjs";

let instanceRenderer: (t: number) => void;

window.onload = async () => {
  if (navigator.gpu == null) {
    alert("WebGPU is required to run this sample.");
  }

  const adapter = await navigator.gpu.requestAdapter();
  const device = atomDevice.deref() || (await adapter.requestDevice());
  let canvas = document.querySelector("#canvas-container") as HTMLCanvasElement;

  atomDevice.reset(device);
  resetCanvasSize(canvas);

  atomDepthTexture.reset(createDepthTexture());

  renderControl();
  startControlLoop(10, onControlEvent);

  instanceRenderer = await loadRenderer(canvas);

  let t = 0;
  let renderer = () => {
    t++;
    setTimeout(() => {
      requestAnimationFrame(renderer);
    }, 20);
    instanceRenderer(t);
  };

  renderer();
  window["rrr"] = renderer;

  window.onresize = () => {
    resetCanvasSize(canvas);
    atomDepthTexture.reset(createDepthTexture());
  };

  const parsed = queryString.parse(location.search);

  if (parsed["remote-control"]) {
    setupRemoteControl();
  }
};

declare global {
  /** dirty hook for extracting error messages */
  var __lagopusHandleCompilationInfo: (
    info: GPUCompilationInfo,
    code: string
  ) => void;

  var __hotUpdateParams: (partial: number[]) => void;

  // to be triggered from command
  var rrr: () => void;
}

if (import.meta.hot) {
  import.meta.hot.accept("./app", async (newModule) => {
    if (newModule) {
      // newModule is undefined when SyntaxError happened
      // console.log("updated: count is now ");
      let canvas = document.querySelector(
        "#canvas-container"
      ) as HTMLCanvasElement;
      instanceRenderer = await newModule.loadRenderer(canvas);
    }
  });
}
