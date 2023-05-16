struct Particle {
  pos: vec3<f32>,
  vel: vec3<f32>,
  distance: f32,
}

struct SimParams {
  delta_t: f32,
  rule1_distance: f32,
  rule2_distance: f32,
  rule3_distance: f32,
  rule1_scale: f32,
  rule2_scale: f32,
  rule3_scale: f32,
}

struct Particles {
  particles: array<Particle>,
}

@binding(0) @group(0) var<uniform> params: SimParams;
@binding(1) @group(0) var<storage, read> particles_a: Particles;
@binding(2) @group(0) var<storage, read_write> particles_b: Particles;

const tau = 10f;
const rou = 28f;

struct LorenzResult {
  position: vec3f,
  velocity: vec3f,
  distance: f32,
}

fn lorenz(p: vec3f, dt: f32) -> LorenzResult {
  let beta = 8.0 / 3.0;
  let dx = tau * (p.y - p.x);
  let dy = p.x * (rou - p.z) - p.y;
  let dz = p.x * p.y - beta * p.z;
  let d = vec3<f32>(dx, dy, dz) * dt;
  return LorenzResult(
    p + d,
    vec3(dx,dy,dz),
    length(d) * 2.1
  );
}

fn rand(n: f32) -> f32 { return fract(sin(n) * 43758.5453123); }

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;

  var v_pos = particles_a.particles[index].pos;
  var v_vel = particles_a.particles[index].vel;

  let ret = lorenz(v_pos, params.delta_t * 0.02 * (2. + 4. * rand(f32(index))));

  // Write back
  particles_b.particles[index].pos = ret.position;
  particles_b.particles[index].vel = ret.velocity;
  particles_b.particles[index].distance += ret.distance;

}
