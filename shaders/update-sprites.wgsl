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

  var c_mass = vec3(0.0);
  var c_vel = vec3(0.0);
  var col_vel = vec3(0.0);
  var c_mass_count = 0u;
  var c_vel_count = 0u;
  var pos: vec3<f32>;
  var vel: vec3<f32>;

  for (var i = 0u; i < arrayLength(&particles_a.particles); i++) {
    // if (i == index) {
    //   continue;
    // }

    pos = vec3<f32>(particles_a.particles[i].pos.xyz);
    vel = vec3<f32>(particles_a.particles[i].vel.xyz);
    if distance(pos, v_pos) < 0.02 {
      c_mass += pos;
      c_mass_count++;
    }
    if distance(pos, v_pos) < 0.05 {
      col_vel -= pos - v_pos;
    }
    if distance(pos, v_pos) < 0.005 {
      c_vel += vel;
      c_vel_count++;
    }
  }
  if c_mass_count > 0u {
    c_mass = (c_mass / vec3(f32(c_mass_count))) - v_pos;
  }
  if c_vel_count > 0u {
    c_vel /= f32(c_vel_count);
  }
  v_vel += (c_mass * 0.02) + (col_vel * 0.05) + (c_vel * 0.005);
  // v_vel = vec3<f32>(0.05,0.0,0.0);

  // clamp velocity for a more pleasing simulation
  v_vel = normalize(v_vel) * clamp(length(v_vel), 0.0, 0.1);
  // kinematic update
  v_pos = v_pos + (v_vel * params.delta_t);
  // Wrap around boundary
  if v_pos.x < -1.0 {
    v_pos.x = 1.0;
  }
  if v_pos.x > 1.0 {
    v_pos.x = -1.0;
  }
  if v_pos.y < -1.0 {
    v_pos.y = 1.0;
  }
  if v_pos.y > 1.0 {
    v_pos.y = -1.0;
  }
  if v_pos.z < -1.0 {
    v_pos.z = 1.0;
  }
  if v_pos.z > 1.0 {
    v_pos.z = -1.0;
  }
  // Write back
  particles_b.particles[index].pos = v_pos;
  particles_b.particles[index].vel = v_vel;
  // particles_b.particles[index].pos = particles_b.particles[index].pos;
  // particles_b.particles[index].vel = particles_b.particles[index].vel;

  // particles_b.particles[index].pos = vec3(0.5, 0.1, 0.2);
  // particles_b.particles[index].pos = vec3(0.2, 0.1, 0.1);
  // particles_b.particles[index].vel = vec3(0.5, 0.1, 0.1);
}
