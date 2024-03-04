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
  var index = GlobalInvocationID.x;
  let item = particles_a.particles[index];
  let write_target = &particles_b.particles[index];


  var v_pos = item.pos;

  let velocity = item.velocity;
  let next_pos = item.pos + velocity * params.delta_t;
  var next_velocity = velocity;


  let len = arrayLength(&particles_a.particles);
  // simulate gravity of each other particle
  for (var i = 0u; i < len; i = i + 1u) {
    if i == index {
      continue;
    }
    let p = particles_a.particles[i];
    let distance = length(p.pos - next_pos);
    if distance > 400. {
      continue;
    }
    let force = (p.pos - next_pos) / min(1.0, (distance * distance * distance));
    next_velocity = next_velocity + 0.01 * force * params.delta_t;
  }

  if length(next_velocity) > 100.0 {
    next_velocity *= 0.98;
  }

  (*write_target).pos = next_pos;
  (*write_target).velocity = next_velocity;
}
