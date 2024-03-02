
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

const PI: f32 = 3.141592653589793238462643383279502884197;

@vertex
fn vert_main(
  @location(0) position: vec3<f32>,
  @location(1) point_idx: f32,
  @location(2) velocity: vec3<f32>,
  @location(3) _travel: f32,
  @location(4) _v: vec4<f32>,
  @location(5) idx: u32,
) -> VertexOutput {
  var output: VertexOutput;
  let scale: f32 = 0.002;

  // let rightward: vec3<f32> = uniforms.rightward;
  // let upward: vec3<f32> = uniforms.upward;
  // let right = normalize(rightward);
  // let up = normalize(upward);


  let center_ret = transform_perspective(position);

  var width = params.width * 10.;

  let outside = center_ret.side_distance > center_ret.front_distance * 0.8;
  if outside {
    width *= 0.0;
    output.position = vec4(center_ret.point_position.xyz * scale, 1.0);
    return output;
  }

  let arc0 = PI / 6.;
  let r1 = 36. * width;
  let r2 = 28. * width;
  let h = 88. * width;

  var lightness = 0.5;
  var pos: vec3<f32> = position;

  if idx < 12u {
    let a = f32(idx) * arc0;
    pos = position + vec3f(cos(a) * r1, 0., sin(a) * r1);

    // pos += vec3(1.,1.,1.) * 100.0;
  } else {
    let a = f32(idx - 12u) * arc0;
    pos = position + vec3f(cos(a) * r2, h, sin(a) * r2);
    lightness = 0.8;
    // pos += vec3(1.,1.,1.) * 100.0;
  }


  let ret = transform_perspective(pos.xyz);

  // one in front and one in back
  // if (ret.r - 1.) * (center_ret.r - 1.) < 0. {
  //   output.position = vec4(0.0, -1000.0, 0.0, 0.0);
  //   output.color.w = 0.;
  //   return output;
  // }

  output.position = vec4(ret.point_position.xyz * scale, 1.0);
  var opacity = min(1., 1.0 - 0.1 * sqrt(0.1 + abs(ret.r * 3.0)));

  // if ret.r < 1. {
  //   opacity = 0.0;
  // }

  lightness *= opacity;

  let c3: vec3<f32> = hsl(fract(point_idx / 400.), 0.8, lightness);
  output.color = vec4(c3, 0.9);

  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  return color;
  // return vec4<f32>(1., 0., 0., 1.0);
}