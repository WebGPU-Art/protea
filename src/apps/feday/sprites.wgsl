
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
  var width = params.width * 0.8;

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

  let p: vec3<f32> = transform_perspective(p0.xyz).point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p[0] * scale, p[1] * scale, p[2] * scale, 1.0);
  let c3: vec3<f32> = hsl(fract(point_idx / 800000. + 0.5) + 0.6, 0.9, 0.7);
  output.color = vec4(c3, 0.8);
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  return color;
  // return vec4<f32>(1., 0., 0., 1.0);
}