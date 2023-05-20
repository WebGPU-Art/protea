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


struct SprottResult {
  position: vec3f,
  velocity: vec3f,
  distance: f32,
}

fn sprott(p: vec3f, dt: f32) -> SprottResult {
  const a = 2.07;
  const b = 1.79;
  let x = p.x;
  let y = p.y;
  let z = p.z;
  let dx = y + a*x*y + x*z;
  let dy = 1.0 - b*x*x + y*z;
  let dz = x - x*x - y * y;
  let d = vec3<f32>(dx, dy, dz) * dt;
  return SprottResult(
    p + d,
    vec3(dx,dy,dz),
    length(d) * 10.1
  );
}

/// https://www.dynamicmath.xyz/strange-attractors/
fn four_wing(p: vec3f, dt: f32) -> SprottResult {
  const a = 0.2;
  const b = 0.01;
  const c = -0.4;
  let x = p.x;
  let y = p.y;
  let z = p.z;
  let dx = a * x + y * z;
  let dy = b * x + c*y - x*z;
  let dz = - z - x*y;
  let d = vec3<f32>(dx, dy, dz) * dt;
  return SprottResult(
    p + d,
    vec3(dx,dy,dz),
    length(d) * 8.8
  );
}


fn rand(n: f32) -> f32 { return fract(sin(n) * 43758.5453123); }

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;

  var v_pos = particles_a.particles[index].pos;
  var v_vel = particles_a.particles[index].vel;

  let ret = four_wing(v_pos, params.delta_t * 0.01 * (20. + 2. * rand(f32(index))));
  // let ret = sprott(v_pos, 0.005);

  // Write back
  particles_b.particles[index].pos = ret.position;
  particles_b.particles[index].vel = ret.velocity;
  particles_b.particles[index].distance += ret.distance;

}
