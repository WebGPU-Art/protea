import { atomDevice } from "./globals.mjs";

// 👋 Helper function for creating GPUBuffer(s) out of Typed Arrays
export const createBuffer = (
  arr: Float32Array | Uint32Array,
  usage: number
) => {
  // 📏 Align to 4 bytes (thanks @chrimsonite)
  let desc = {
    size: (arr.byteLength + 3) & ~3,
    // size: 64,
    usage,
    mappedAtCreation: true,
  };
  let device = atomDevice.deref();
  let buffer = device.createBuffer(desc);

  const writeArray =
    arr instanceof Uint32Array
      ? new Uint32Array(buffer.getMappedRange())
      : new Float32Array(buffer.getMappedRange());
  writeArray.set(arr);
  buffer.unmap();
  return buffer;
};

export const createDepthTexture = () => {
  let device = atomDevice.deref();
  let width = window.innerWidth * devicePixelRatio;
  let height = window.innerHeight * devicePixelRatio;
  const depthTexture = device.createTexture({
    size: [width, height],
    // format: "depth24plus",
    // usage: GPUTextureUsage.RENDER_ATTACHMENT,
    dimension: "2d",
    format: "depth24plus-stencil8",
    usage: GPUTextureUsage.RENDER_ATTACHMENT | GPUTextureUsage.COPY_SRC,
    // sampleCount: atomBloomEnabled.deref() ? undefined : 4,
  });
  return depthTexture;
};
