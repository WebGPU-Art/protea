let controllers: Record<number, Gamepad> = {};

let looper: any;

export type GameAxes = {
  leftX: number;
  leftY: number;
  rightX: number;
  rightY: number;
};

export type GameButtons = {
  face1: GamepadButton;
  face2: GamepadButton;
  face3: GamepadButton;
  face4: GamepadButton;
  l1: GamepadButton;
  r1: GamepadButton;
  l2: GamepadButton;
  r2: GamepadButton;
  select: GamepadButton;
  start: GamepadButton;
  l3: GamepadButton;
  r3: GamepadButton;
  up: GamepadButton;
  down: GamepadButton;
  left: GamepadButton;
  right: GamepadButton;
};

let handler = (axes: GameAxes, buttons: GameButtons) => {
  console.log("default...");
};

export let setupGamepadControl = (
  f: (axes: GameAxes, buttons: GameButtons) => void
) => {
  handler = f;
  window.addEventListener("gamepadconnected", connecthandler);
  window.addEventListener("gamepaddisconnected", disconnecthandler);
};

let connecthandler = (e: GamepadEvent) => {
  console.log("Gamepad", e);

  controllers[e.gamepad.index] = e.gamepad;
  gameLoop();
};

let disconnecthandler = (e: GamepadEvent) => {
  delete controllers[e.gamepad.index];
  cancelAnimationFrame(looper);
};

let gameLoop = () => {
  const gamepads = navigator.getGamepads();
  let gp = gamepads[0];
  let [
    face1,
    face2,
    face3,
    face4,
    l1,
    r1,
    l2,
    r2,
    select,
    start,
    l3,
    r3,
    up,
    down,
    left,
    right,
  ] = gp.buttons;
  let [leftX, leftY, rightX, rightY] = gp.axes;

  handler(
    {
      leftX,
      leftY,
      rightX,
      rightY,
    },
    {
      // face1,
      // face2,
      // face3,
      // face4,
      l1,
      r1,
      l2,
      r2,
      // select,
      // start,
      // l3,
      // r3,
      up,
      down,
      left,
      right,
    } as GameButtons
  );

  looper = setTimeout(gameLoop, 10);
};
