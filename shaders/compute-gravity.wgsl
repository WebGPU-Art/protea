struct Particle {
  pos: vec3<f32>,
  vel: vec3<f32>,
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

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;

  var v_pos = particles_a.particles[index].pos;
  var v_vel = particles_a.particles[index].vel;

  let l = length(v_pos);

  var pull = -v_pos / (l * l);
  if (l < 0.3) {
    pull = vec3<f32>(0.0, 0.0, 0.0);
  }
  v_vel += 1.0 * pull;

  var total = arrayLength(&particles_a.particles);
  let r = 1.0 / f32(total);
  for (var i = 0u; i < total; i++) {
    if (i == index) {
      continue;
    }

    let pos = particles_a.particles[i].pos;
    let vel = particles_a.particles[i].vel;
    // let pull_a = min(pos - v_pos, vec3<f32>(1000.0, 1000.0, 1000.0));
    let pull_a = vec3<f32>(pos - v_pos);
    let d = round(max(100000000.0, length(pull_a)));
    let vel_a = pull_a / (d * d * d);
    v_vel += vel_a * 100. * r;
    // v_vel += vec3<f32>(1.1, 1.1, 1.1) * 0.001;
  }

  let pos_next = v_pos + v_vel * 10.0 * r;

  // Write back
  particles_b.particles[index].pos = pos_next;
  particles_b.particles[index].vel = v_vel;
  // particles_b.particles[index].pos = particles_a.particles[index].pos;
  // particles_b.particles[index].vel = particles_a.particles[index].vel;

}
