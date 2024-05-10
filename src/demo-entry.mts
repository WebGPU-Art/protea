import { setupInitials } from "./index.mjs";

import { loadRenderer } from "./apps/fireworks.mjs";
import {} from "./apps/attractor-lorenz.mjs";
import {} from "./apps/attractor-aizawa.mjs";
import {} from "./apps/attractor-fourwing.mjs";
import {} from "./apps/fractal.mjs";
import {} from "./apps/collision.mjs";
import {} from "./apps/bounce.mjs";
import {} from "./apps/bounce-trail.mjs";
import {} from "./apps/feday.mjs";
import {} from "./apps/bifurcation.mjs";
import {} from "./apps/ball-spin.mjs";
import {} from "./apps/lifegame.mjs";
import {} from "./apps/lifegame-trail.mjs";
import {} from "./apps/orbit-spark.mjs";
import {} from "./apps/attractor-chen.mjs";
import {} from "./apps/attractor-sprott.mjs";
import {} from "./apps/attractor-lorenz83.mjs";
import {} from "./apps/orbits.mjs";
import {} from "./apps/lamps.mjs";
import {} from "./apps/debug-grid.mjs";
import {} from "./apps/attractor-den-tsucs.mjs";
import {} from "./apps/attractor-bouali.mjs";
import {} from "./apps/orbits-2.mjs";
import {} from "./apps/attractor-halvorsen.mjs";
import * as cliffordd from "./apps/clifford.mjs";
import * as dequanli from "./apps/attractor-dequanli.mjs";
import * as daras from "./apps/attractor-dadras.mjs";
import * as burkeShaw from "./apps/attractor-burke-shaw.mjs";

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
