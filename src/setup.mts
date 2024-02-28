import queryString from "query-string";
import { renderControl, startControlLoop } from "@triadica/touch-control";

import {
  atomDepthTexture,
  atomDevice,
  onControlEvent,
  createDepthTexture,
  resetCanvasSize,
  setupRemoteControl,
} from "./index.mjs";
import { useGamepad, useRemoveContrl } from "./config.mjs";
import { loadGamepadControl } from "./control.mjs";

export async function setupInitials(canvas: HTMLCanvasElement) {
  const adapter = await navigator.gpu.requestAdapter();
  const device = atomDevice.deref() || (await adapter.requestDevice());
  atomDevice.reset(device);

  resetCanvasSize(canvas);

  atomDepthTexture.reset(createDepthTexture());

  window.onresize = () => {
    resetCanvasSize(canvas);
    atomDepthTexture.reset(createDepthTexture());
  };
  renderControl();
  startControlLoop(10, onControlEvent);

  if (useRemoveContrl) {
    setupRemoteControl();
  }

  if (useGamepad) {
    loadGamepadControl();
  }
}
