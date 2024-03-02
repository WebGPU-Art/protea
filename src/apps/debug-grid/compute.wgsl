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

struct SphereConstraint {
  center: vec3<f32>,
  radius: f32,
  inside: bool,
}

fn rand(n: f32) -> f32 { return fract(sin(n) * 43758.5453123); }

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  // var index = GlobalInvocationID.x;
  // let item = particles_a.particles[index];
  // let write_target = &particles_b.particles[index];

  // var v_pos = item.pos;

  // let velocity = item.velocity;
  // let next_pos = item.pos + velocity * params.delta_t;

  // (*write_target).pos = next_pos;
  // (*write_target).velocity = velocity;
}
