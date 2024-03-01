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

fn iterate(p: vec3<f32>) -> vec3<f32> {
  let x = p[0];
  let y = p[1];
  let z = p[2];
  return vec3(
    sin(x * x - y * y + .536 - z * 0.5),
    cos(2. * x * y + .575 + z * 0.5), z * 0.992
  );
}

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;
  let item = particles_a.particles[index];
  let write_target = &particles_b.particles[index];

  let constraints = array<SphereConstraint, 3>(
    SphereConstraint(vec3<f32>(0.0, 0.0, 0.0), 100.0, true),
    SphereConstraint(vec3<f32>(0.0, 100.0, 0.0), 180.0, true),
    SphereConstraint(vec3<f32>(0.0, -150.0, 0.0), 20.0, false)
  );

  var v_pos = item.pos;

  let next = iterate(v_pos * 0.01) * 101.;
  (*write_target).pos = vec3<f32>(next.x, next.y, next.z);
}
