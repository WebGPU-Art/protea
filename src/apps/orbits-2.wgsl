
#import protea::perspective
#import protea::colors

struct Particle {
  pos: vec3<f32>,
  times: f32,
  pos0: vec3<f32>,
  times2: f32,
  // p1: f32,
  // p2: f32,
  // p3: f32,
  // p4: f32,
}

struct Params {
  delta_t: f32,
  height: f32,
  width: f32,
  opacity: f32,
}

struct Particles {
  particles: array<Particle>,
}

@group(0) @binding(1) var<uniform> params: Params;
@group(1) @binding(0) var<storage, read> pass_in: Particles;
@group(1) @binding(1) var<storage, read_write> pass_out: Particles;

fn rand(n: f32) -> f32 { return fract(sin(n) * 43758.5453123); }

fn pick_param(n: u32) -> vec2f {
  switch n {
    case 0u: {
      return vec2f(3.7, 4.25);
    }
    case 1u: {
      return vec2f(3.667, 3.934);
    }
    case 2u: {
      return vec2f(3.536, 5.575);
    }
    case 3u: {
      return vec2f(5.655, 5.16);
    }
    case 4u: {
      return vec2f(5.937, 5.482);
    }
    case 5u: {
      return vec2f(2.3, 2.72);
    }
    case 6u: {
      return vec2f(5.46, 4.55);
    }
    case 7u: {
      return vec2f(3.65, 4.58);
    }
    case 8u: {
      return vec2f(2.65, 1.58);
    }
    case 9u: {
      return vec2f(-2.65, -.8);
    }
    case 10u: {
      return vec2f(4., -1.5);
    }
    case 11u {
      return vec2f(2.72, 0.65);
    }
    case 12u {
      return vec2f(0.1, 0.6);
    }
    case 13u {
      return vec2f(2.79, 4.64);
    }
    case 14u {
      return vec2f(.66, 1.9);
    }
    default: {
      return vec2f(1.158, 1.93);
    }
  }
}

fn iterate(p: vec3<f32>, n: u32) -> vec3<f32> {
  let x = p[0];
  let y = p[1];
  let z = p[2];

  var vv = pick_param(n);
  let next_x = sin(x * x - y * y + vv.x);
  let next_y = cos(2. * x * y + vv.y);
  return vec3(next_y, next_x, z);
}

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;
  let item = pass_in.particles[index];

  let duration = 100.;
  let try_idx = u32(item.times2 / duration) % 15u;

  let next = iterate(item.pos, try_idx);
  if item.times < duration {
    pass_out.particles[index].pos.x = next.x;
    pass_out.particles[index].pos.y = next.y;
    pass_out.particles[index].pos.z = item.pos.z;
    pass_out.particles[index].times = item.times + 1.;
    pass_out.particles[index].times2 = item.times2 + 1.;
  } else {
    pass_out.particles[index].pos.x = item.pos0.x;
    pass_out.particles[index].pos.y = item.pos0.y;
    pass_out.particles[index].times = 0.;
    pass_out.particles[index].times2 = item.times2 + 1.;
    // pass_out.particles[index].pos = item.pos;
  }
}

struct VertexOutput {
  @builtin(position) position: vec4<f32>,
  @location(4) color: vec4<f32>,
}

@vertex
fn vert_main(
  @location(0) position0: vec3<f32>,
  @location(1) point_idx: f32,
  @location(2) velocity: vec3<f32>,
  @location(3) times: f32,
  @location(4) idx: u32,
) -> VertexOutput {
  let position = position0 * 100.;
  var pos: vec3<f32>;
  let rightward: vec3<f32> = uniforms.rightward;
  let upward: vec3<f32> = uniforms.upward;
  let right = normalize(rightward);
  let up = normalize(upward);

  // let front = params.length;
  var width = params.width * 0.4;

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
  pos.z = 0.0;

  var output: VertexOutput;
  let p0 = vec4(pos * 10.0, 1.0);

  let p: vec3<f32> = transform_perspective(p0.xyz).point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p[0] * scale, p[1] * scale, p[2] * scale, 1.0);
  let c3: vec3<f32> = hsl(fract(point_idx / 4000000.), 0.8, max(0.1, 0.9 - 0.2));
  output.color = vec4(c3, params.opacity);
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  return color;
  // return vec4<f32>(1., 0., 0., 1.0);
}