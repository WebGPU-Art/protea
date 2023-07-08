import { setupInitials } from "./index.mjs";

import { loadRenderer } from "./app.mjs";

let instanceRenderer: (t: number, skipComputing: boolean) => void;
let canvas = document.querySelector("#canvas-container") as HTMLCanvasElement;

window.__skipComputing = false;
window.onload = async () => {
  await setupInitials(canvas);

  instanceRenderer = await loadRenderer(canvas);

  let t = 0;
  let renderer = () => {
    t++;
    // setTimeout(() => {
    requestAnimationFrame(renderer);
    // }, 20);
    instanceRenderer(t, __skipComputing);
  };

  renderer();
};

if (import.meta.hot) {
  import.meta.hot.accept("./app", async (newModule) => {
    if (newModule) {
      // newModule is undefined when SyntaxError happened
      instanceRenderer = await newModule.loadRenderer(canvas);
      window.__skipComputing = false;
    }
  });
}
