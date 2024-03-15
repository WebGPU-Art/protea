/// <reference types="vite/client" />

declare module "*.wgsl" {
  const value: string;
  export default value;
}

declare module "*.wgsl?raw" {
  const value: string;
  export default value;
}

declare var __skipComputing: boolean;

/** dirty hook for extracting error messages */
declare var __lagopusHandleCompilationInfo: (
  info: GPUCompilationInfo,
  code: string,
  diffLines: number
) => void;

declare var __hotUpdateParams: (partial: number[]) => void;
