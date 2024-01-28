
#import protea::perspective
#import protea::colors

struct Params {
  delta_t: f32,
  scale: f32,
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
  @location(0) position0: vec3<f32>,
  @location(1) ages: f32,
  @location(2) prev_pos0: vec3<f32>,
  @location(3) travel: f32,
  @location(4) idx: u32,
) -> VertexOutput {
  let position = position0 * 8.;
  let prev_pos = prev_pos0 * 8.;
  var pos: vec3<f32>;
  let v0 = position - prev_pos;
  var prev_position = prev_pos;
  let forward: vec3<f32> = uniforms.forward;
  let right = normalize(cross(v0, forward));

  // let front = params.length;
  var width = params.width * 8.;

  if ages < 0.01 {
    // prev_position = position;
    width = 0.0;
  }
  // TODO hack
  if distance(position, prev_pos) > 12.2 {
    width = 0.0;
  }

  if idx == 0u {
    pos = position + right * width;
    // pos += vec3(1.,1.,1.) * 100.0;
  } else if idx == 1u {
    pos = position - right * width;
  } else if idx == 2u {
    pos = prev_position + right * width;
  } else if idx == 3u {
    pos = prev_position - right * width;
  } else {
    pos = position;
  }

  var output: VertexOutput;
  let p0 = vec4(pos * params.scale, 1.0);

  let p: vec3<f32> = transform_perspective(p0.xyz).point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p * scale, 1.0);
  // let c3: vec3<f32> = hsl(fract(travel/100.), 0.8, fract(0.9 - ages * 0.0002));
  // let c3: vec3<f32> = hsl(0.24, 0.8, 0.7 + 0.3 * sin(travel * 0.2));
  // let c3 = hsl(0.24, 0.99, 0.99 - dim);
  // let c3 = vec3<f32>(0.99, 0.94, 0.2) * (1. - ages * 0.01);
  let c3: vec3<f32> = hsl(fract(travel * 0.000008 + 0.0), 0.998, 0.5 - ages * 0.002);
  output.color = vec4(c3, params.opacity * (1.2 - ages * 0.04));
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  return color;
  // return vec4<f32>(0.7, 0.7, 1., 1.0);
}