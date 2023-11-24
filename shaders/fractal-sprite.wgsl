
#import protea::perspective
#import protea::colors

struct Params {
  delta_t: f32,
  length: f32,
  width: f32,
  opacity: f32,
}

@group(1) @binding(0) var<uniform> params: Params;


struct VertexOutput {
  @builtin(position) position: vec4<f32>,
  // inward
  @location(1) step_length: f32,
}

@vertex
fn vert_main(
  @location(0) position0: vec3<f32>,
  @location(1) step_length: f32,
  @location(2) idx: u32,
) -> VertexOutput {
  let position = position0.xyz * 8.;
  var pos: vec3<f32>;

  let rightward: vec3<f32> = uniforms.rightward;
  let upward: vec3<f32> = uniforms.upward;
  let right = normalize(rightward);
  let up = normalize(upward);

  // let front = params.length;
  var width = 0.0003;

  if idx == 0u {
    pos = position + right * width - up * width;
    // pos += vec3(1.,1.,1.) * 100.0;
  } else if idx == 1u {
    pos = position - right * width - up * width;
  } else if idx == 2u {
    pos = position + right * width + up * width;
  } else if idx == 3u {
    pos = position - right * width + up * width;
  } else {
    pos = position;
  }

  var output: VertexOutput;
  let p0 = vec4(pos * 1000.0, 1.0);

  let p: vec3<f32> = transform_perspective(p0.xyz).point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p * scale, 1.0);
  output.step_length = step_length;
  return output;
}

@fragment
fn frag_main(vtx_out: VertexOutput) -> @location(0) vec4<f32> {
  if vtx_out.step_length < 0. {
    return vec4<f32>(0.99, 0.6, 0.3, 0.99);
  } else {
    return vec4<f32>(0.6, 0.6, 0.99, 0.99);
  }
}