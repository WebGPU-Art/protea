struct Particle {
  pos: vec3<f32>,
  idx: f32,
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

const beta = 0.25;

fn bifurcation(a: f32, x: f32, y: f32) -> vec2<f32> {
  // x ← a – y(β x + (1 – β) y)
  let x2 = a - y * (beta * x + (1.0 - beta) * y);
  // y ←x + y²/100
  let y2 = x + y * y / 100.0;

  return vec2<f32>(x2, y2);
}

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;
  let item = particles_a.particles[index];
  let write_target = &particles_b.particles[index];

  let a = item.pos.y * 0.01;
  let x = item.pos.x * 0.02;
  let y = item.pos.z * 0.02;

  let pos = bifurcation(a, x, y);
  (*write_target).pos.x = pos.x * 50.0;
  (*write_target).pos.z = pos.y * 50.0;
}
