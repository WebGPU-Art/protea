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
import { stringifyCompilationError } from "./util.mjs";

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
  f: (e: GPUCompilationInfo, code: string, n: number) => void
) {
  window.__lagopusHandleCompilationInfo = f;
}

let someValue = (x: number) => {
  return Math.abs(x) > threshold ? x : 0;
};

/** false, to move,
 *  true, to rotate as left arrow */
let rightAxeForRotation = false;

export let loadGamepadControl = () => {
  console.log("loading gamepad control");
  setupGamepadControl((axes, buttons) => {
    if (rightAxeForRotation && buttons.l3.value > 0.5) {
      console.info("Gamepad mode: stable viewer");
      rightAxeForRotation = false;
    }
    if (!rightAxeForRotation && buttons.r3.value > 0.5) {
      console.info("Gamepad mode: faster fly");
      rightAxeForRotation = true;
    }
    let scale = atomViewerScale.deref();
    let speedy = buttons.l1.value > 0.5 || buttons.r1.value > 0.5 ? 8 : 1;
    let faster = speedy > 4 ? 4 : 1;
    let ss = speedy / scale;

    if (rightAxeForRotation) {
      // swap usages of arrow buttons and right axes
      moveViewerBy(
        someValue(buttons.right.value - buttons.left.value) * 10 * ss,
        someValue(buttons.up.value - buttons.down.value) * 10 * ss,
        someValue(axes.leftY) * 10 * ss
      );
      rotateGlanceBy(
        -0.05 * faster * someValue(axes.rightX),
        -0.05 * faster * someValue(axes.rightY)
      );

      spinGlanceBy(0.1 * faster * someValue(axes.leftX));
    } else {
      // left/right, up/down, front/back
      moveViewerBy(
        someValue(axes.rightX) * 10 * ss,
        -someValue(axes.rightY) * 10 * ss,
        someValue(axes.leftY) * 10 * ss
      );
      rotateGlanceBy(
        -0.05 * faster * someValue(axes.leftX),
        0.05 * faster * someValue(buttons.up.value - buttons.down.value)
      );

      spinGlanceBy(
        0.1 * faster * someValue(buttons.right.value - buttons.left.value)
      );
    }
    if (buttons.l2.value > 0.5) {
      changeScaleBy(0.01 * speedy);
    }
    if (buttons.r2.value > 0.5) {
      changeScaleBy(-0.01 * speedy);
    }
  });
};

export let listenShaderError = (f: (s: string) => void) => {
  registerShaderResult((e, code, delta) => {
    if (e.messages.length) {
      console.error(e);
      f(stringifyCompilationError(e.messages[0], code, delta));
    } else {
      f(null);
    }
  });
};
