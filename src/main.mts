import { setupInitials } from "./index.mjs";

import { loadFireworksRenderer } from "./apps/fireworks.mjs";
import {} from "./apps/attractor-lorenz.mjs";
import {} from "./apps/attractor-aizawa.mjs";
import {} from "./apps/attractor-fourwing.mjs";
import {} from "./apps/fractal.mjs";
import {} from "./apps/collision.mjs";
import {} from "./apps/bounce.mjs";
import {} from "./apps/feday.mjs";
import {} from "./apps/bifurcation.mjs";
import {} from "./apps/ball-spin.mjs";

let instanceRenderer: (t: number, skipComputing: boolean) => void;
let canvas = document.querySelector("#canvas-container") as HTMLCanvasElement;

window.__skipComputing = false;
window.onload = async () => {
  await setupInitials(canvas);

  instanceRenderer = await loadFireworksRenderer(canvas);

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
