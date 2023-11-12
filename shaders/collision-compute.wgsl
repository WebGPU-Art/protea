struct Particle {
  pos: vec3<f32>,
  idx: f32,
  velocity: vec3<f32>,
  _distance: f32,
  _prev_pos: vec4<f32>,
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

@binding(0) @group(0) var<uniform> params: Params;
@binding(1) @group(0) var<storage, read> particles_a: Particles;
@binding(2) @group(0) var<storage, read_write> particles_b: Particles;



fn rand(n: f32) -> f32 { return fract(sin(n) * 43758.5453123); }

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;
  let item = particles_a.particles[index];
  let write_target = &particles_b.particles[index];

  var v_pos = item.pos;

  var velocity = item.velocity;
  velocity += vec3<f32>(0.0, -9.8, 0.0) * params.delta_t;

  let outter_radius = 100.;
  if length(v_pos) >= outter_radius {

    let outer_direction = normalize(v_pos);
    let outer_velocity = dot(outer_direction, velocity) * outer_direction;
    let next_velocity = velocity - 2. * outer_velocity;

    (*write_target).velocity = next_velocity;
    (*write_target).pos = v_pos + next_velocity * params.delta_t;

    return;
  } else {

    let disturb_base = vec3(0., -80.0, 0.0);
    let inner_radius = 0.;
    let bunce_base = item.pos - disturb_base;
    if length(bunce_base) <= inner_radius {
      let bunce_direction = normalize(bunce_base);
      let bunce_velocity = dot(bunce_direction, velocity) * bunce_direction;
      let next_velocity = velocity - 2. * bunce_velocity;

      (*write_target).velocity = next_velocity;
      (*write_target).pos = v_pos + next_velocity * params.delta_t;
    } else {

      (*write_target).velocity = velocity;
      let next_pos = item.pos + velocity * params.delta_t;
      (*write_target).pos = next_pos;
    }
  }
}
