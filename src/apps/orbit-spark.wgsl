
#import protea::perspective
#import protea::colors

struct Particle {
  pos: vec3<f32>,
  ages: f32,
  prev_pos: vec3<f32>,
  distance: f32,
  velocity: vec3<f32>,
  mark: f32
}

struct Params {
  delta_t: f32,
  scale: f32,
  width: f32,
  opacity: f32,
}

struct Particles {
  particles: array<Particle>,
}

@group(0) @binding(1) var<uniform> params: Params;
@group(1) @binding(0)  var<storage, read> pass_in: Particles;
@group(1) @binding(1) var<storage, read_write> pass_out: Particles;

const tau = 10f;
const rou = 28f;

fn rand(n: f32) -> f32 { return fract(sin(n) * 43758.5453123); }

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;

  let inner_idx = f32(index % 24u);
  let group_idx = floor(f32(index) / 24.0);

  if index % 6u != 0u {
    let prev = index - 1u;
    pass_out.particles[index].pos = pass_in.particles[prev].pos;
    // pass_out.particles[index].ages = pass_in.particles[prev].ages;
    pass_out.particles[index].ages = inner_idx;
    pass_out.particles[index].prev_pos = pass_in.particles[prev].prev_pos;
    // pass_out.particles[index].distance = pass_in.particles[prev].distance;
    pass_out.particles[index].distance = group_idx;
    return;
  }

  var v_pos = pass_in.particles[index].pos;

  if length(v_pos) > 20. {
    pass_out.particles[index].pos = vec3<f32>(0., 1.2, 0.);
    pass_out.particles[index].prev_pos = vec3<f32>(-0.1, 1.2, 0.);
    pass_out.particles[index].velocity = pass_in.particles[index].velocity * 0.1 + vec3f(4., 0., 0.);
    pass_out.particles[index].mark = 0.0;
    return;
  }

  let bound = 0.996;

  var mark = pass_in.particles[index].mark;

  if mark <= bound {
    let a0 = rand(rand(rand(v_pos[0]) + v_pos[1]) + v_pos[2] + params.delta_t);
    if a0 > bound {
      pass_out.particles[index].mark = a0;
      mark = a0;
    }
  }

  let next_pos = v_pos + pass_in.particles[index].velocity * params.delta_t;

  if mark > bound {
    pass_out.particles[index].pos = next_pos;
    pass_out.particles[index].ages = inner_idx;
    pass_out.particles[index].prev_pos = v_pos;
    pass_out.particles[index].velocity = pass_in.particles[index].velocity;
    pass_out.particles[index].mark = mark;
    return;
  }

  let d = length(v_pos);
  let acc = -3.2 * normalize(v_pos) / (d * d + 2.2);

  let next_v = pass_in.particles[index].velocity * 0.99 + acc;

  // Write back
  pass_out.particles[index].pos = next_pos;
  pass_out.particles[index].ages = inner_idx;
  pass_out.particles[index].prev_pos = v_pos;
  pass_out.particles[index].velocity = next_v;
  // pass_out.particles[index].distance += ret.distance;
  pass_out.particles[index].distance = group_idx;
  pass_out.particles[index].mark = pass_in.particles[index].mark;
}


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
  @location(4) velocity: vec3<f32>,
  @location(5) _p: f32,
  @location(6) idx: u32,
) -> VertexOutput {
  let position = position0 * 8.;
  let prev_pos = prev_pos0 * 8.;
  var pos: vec3<f32>;
  let v0 = position - prev_pos;
  var prev_position = prev_pos;
  let forward: vec3<f32> = uniforms.forward;
  let right = normalize(cross(v0, forward));

  // let front = params.length;
  var width = params.width * 80.4;

  if ages < 0.01 {
    // prev_position = position;
    width = 0.0;
  }
  // TODO hack
  if distance(position, prev_pos) > 1000.0 {
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
  let scale: f32 = 0.0002;

  output.position = vec4(p * scale, 1.0);
  // let c3: vec3<f32> = hsl(fract(travel/100.), 0.8, fract(0.9 - ages * 0.0002));
  // let c3: vec3<f32> = hsl(0.24, 0.8, 0.7 + 0.3 * sin(travel * 0.2));
  // let c3 = hsl(0.24, 0.99, 0.99 - dim);
  // let c3 = vec3<f32>(0.99, 0.94, 0.2) * (1. - ages * 0.01);
  let c3: vec3<f32> = hsl(fract(travel * 0.000008 + 0.0), 0.998, 0.5 - ages * 0.002);
  output.color = vec4(c3, params.opacity * (1.2 - ages * 0.03));
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  return color;
  // return vec4<f32>(0.7, 0.7, 1., 1.0);
}