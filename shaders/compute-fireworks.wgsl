struct Particle {
  pos: vec3<f32>,
  ages: f32,
  prev_pos: vec3<f32>,
  distance: f32,
  velocity: vec3<f32>,
  _pad: f32
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


struct ComputeResult {
  position: vec3f,
  velocity: vec3f,
  distance: f32,
}


/// https://www.dynamicmath.xyz/strange-attractors/
fn compute_move(p: vec3f, vol: vec3f, dt: f32) -> ComputeResult {
  let path = vol * dt;
  // let path = vec3(0., 0.01, 0.);;
  var next = p + path * 1.1;
  let vol_next = vol + vec3(0., -40.1, 0.) * dt;
  // next = clamp(next, vec3(-10000., -10000., -10000.0), vec3(10000., 10000., 10000.));
  return ComputeResult(
    next,
    vol_next,
    length(path)
  );
}



fn rand(n: f32) -> f32 { return fract(sin(n) * 43758.5453123); }

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;

  var v_pos = particles_a.particles[index].pos;
  let vol = particles_a.particles[index].velocity;
  // let vol = vec3(0.0, 20.1, 0.0);

  if (index % 32u != 0u) {
    let prev = index - 1u;
    particles_b.particles[index].pos = particles_a.particles[prev].pos;
    particles_b.particles[index].ages = particles_a.particles[prev].ages;
    particles_b.particles[index].prev_pos = particles_a.particles[prev].prev_pos;
    particles_b.particles[index].distance = particles_a.particles[prev].distance;
    particles_b.particles[index].velocity = particles_a.particles[prev].velocity;
    return;
  }
  let ret = compute_move(v_pos, vol, params.delta_t * 1.1 * (0.1 + 2. * rand(f32(index))));

  // Write back
  particles_b.particles[index].pos = ret.position;
  particles_b.particles[index].velocity = ret.velocity;
  particles_b.particles[index].prev_pos = v_pos;
  particles_b.particles[index].ages += 1.0;
  particles_b.particles[index].distance += ret.distance;

}
