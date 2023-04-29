/** a simpler type for Dispatch */
export type FnDispatch = (op: string, data: any) => void;

/** 3D point */
export type V3 = [number, number, number];

/** 2D point */
export type V2 = [number, number];

export interface LagopusAttribute {
  field: string;
  /** Lagopus has only very limited support for f32 and u32 */
  format: GPUVertexFormat;
}
