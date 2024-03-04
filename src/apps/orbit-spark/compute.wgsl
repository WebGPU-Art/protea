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
@binding(1) @group(0) var<storage, read> pass_in: Particles;
@binding(2) @group(0) var<storage, read_write> pass_out: Particles;

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
