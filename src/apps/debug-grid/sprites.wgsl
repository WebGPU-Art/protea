
#import protea::perspective
#import protea::colors

struct Params {
  delta_t: f32,
  length: f32,
  width: f32,
  opacity: f32,
}

@group(0) @binding(1) var<uniform> params: Params;

struct VertexOutput {
  @builtin(position) position: vec4<f32>,
  @location(4) color: vec4<f32>,
}

@vertex
fn vert_main(
  @location(0) position: vec3<f32>,
  @location(1) point_idx: f32,
  @location(2) velocity: vec3<f32>,
  @location(3) _travel: f32,
  @location(4) _v: vec4<f32>,
  @location(5) idx: u32,
) -> VertexOutput {
  var pos: vec3<f32>;
  let rightward: vec3<f32> = uniforms.rightward;
  let upward: vec3<f32> = uniforms.upward;
  let right = normalize(rightward);
  let up = normalize(upward);

  // let front = params.length;
  var width = params.width * 4.;

  if idx == 0u {
    pos = position + right * width;
    // pos += vec3(1.,1.,1.) * 100.0;
  } else if idx == 1u {
    pos = position;
  } else if idx == 2u {
    pos = position + right * width + up * width;
  } else if idx == 3u {
    pos = position + up * width;
  } else {
    pos = position;
  }

  var output: VertexOutput;
  let p0 = vec4(pos * 10.0, 1.0);

  let ret = transform_perspective(p0.xyz);
  let p: vec3<f32> = ret.point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p[0] * scale, p[1] * scale, p[2] * scale, 1.0);
  output.color = vec4(0., 0., 1., 1.);
  // if ret.r > 1. {
  //   output.color = vec4(0.2, 0., 0., 1.);
  // }
  // if ret.side_distance * scale > 8. {
  //   output.color = vec4(1., 1., 0., 1.);
  // }
  if ret.side_distance > ret.front_distance * 0.4 {
    output.color = vec4(1., 1., 0., 1.);
  }
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  return color;
  // return vec4<f32>(1., 0., 0., 1.0);
}