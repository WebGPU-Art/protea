import { Atom } from "@triadica/touch-control";

export var atomDevice: Atom<GPUDevice> = new Atom(null);
export var atomContext: Atom<GPUCanvasContext> = new Atom(null);

/** TODO depth texture is shared by now, not sure which is better */
export var atomDepthTexture: Atom<GPUTexture> = new Atom(null);

export var atomBufferNeedClear: Atom<boolean> = new Atom(true);

export var atomClearColor: Atom<{
  r: number;
  g: number;
  b: number;
  a: number;
}> = new Atom(undefined);

export function wLog<T extends any>(message: string, a: T): T {
  console.warn(message, a);
  return a;
}
