import { setupGamepadControl } from "./gamepad";
import {
  moveViewerBy,
  rotateGlanceBy,
  spinGlanceBy,
  changeScaleBy,
  atomViewerScale,
} from "./perspective.mjs";
import { ControlStates } from "@triadica/touch-control";
import { threshold } from "./config.mjs";

/** 2D point */
export type V2 = [number, number];

export let onControlEvent = (
  elapsed: number,
  states: ControlStates,
  delta: ControlStates
) => {
  let lMove = states.leftMove.map(refineStrength) as V2;
  let rMove = states.rightMove.map(refineStrength) as V2;
  let rDelta = delta.rightMove;
  let lDelta = delta.leftMove;
  let leftA = states.leftA;
  let rightA = states.rightA || states.shift;
  let rightB = states.rightB;
  let leftB = states.leftB;
  if (lMove[1] !== 0) {
    moveViewerBy(0, 0, -2 * elapsed * lMove[1]);
  }
  if (lMove[0] !== 0) {
    rotateGlanceBy(-0.05 * elapsed * lMove[0], 0);
  }
  if (!rightA && !rightB && !isZero(rMove)) {
    moveViewerBy(2 * elapsed * rMove[0], 2 * elapsed * rMove[1], 0);
  }
  if (rightA && !rightB && rMove[1] !== 0) {
    rotateGlanceBy(0, 0.05 * elapsed * rMove[1]);
  }
  if (rightA && !rightB && rMove[0] !== 0) {
    spinGlanceBy(-0.05 * elapsed * rMove[0]);
  }
  if (!rightA && rightB && rMove[0] !== 0) {
    changeScaleBy(0.01 * elapsed * rMove[0]);
  }

  if (!isZero(lMove) || !isZero(rMove)) {
    // TODO RENDER
  }
};

let isZero = (v: V2): boolean => {
  return v[0] === 0 && v[1] === 0;
};

let refineStrength = (x: number): number => {
  return x * Math.sqrt(Math.abs(x * 0.02));
};

/** function to catch shader compilation errors */
export function registerShaderResult(
  f: (e: GPUCompilationInfo, code: string) => void
) {
  window.__lagopusHandleCompilationInfo = f;
}

let someValue = (x: number) => {
  return Math.abs(x) > threshold ? x : 0;
};

export let loadGamepadControl = () => {
  console.log("loading gamepad control");
  setupGamepadControl((axes, buttons) => {
    let scale = atomViewerScale.deref();
    let ss = 1 / scale;
    // left/right, up/down, front/back
    moveViewerBy(
      someValue(axes.rightX) * 10 * ss,
      -someValue(axes.rightY) * 10 * ss,
      someValue(axes.leftY) * 10 * ss
    );
    rotateGlanceBy(
      -0.1 * someValue(axes.leftX),
      0.05 * (buttons.up.value - buttons.down.value)
    );

    spinGlanceBy(0.1 * (buttons.right.value - buttons.left.value));

    if (buttons.l2.value > 0.5) {
      changeScaleBy(0.01);
    }
    if (buttons.r2.value > 0.5) {
      changeScaleBy(-0.01);
    }

    registerShaderResult((e, code) => {
      if (e.messages.length) {
        console.error(e);
      }
    });
  });
};
