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

  let rem = index % 400u;
  if rem != 0u {
    (*write_target).pos = particles_a.particles[index - 1u].pos;
    return;
  }

  let constraints = array<SphereConstraint, 1>(
    SphereConstraint(vec3<f32>(0.0, 500.0, 0.0), 600.0, true),
    // SphereConstraint(vec3<f32>(0.0, -100.0, 0.0), 80., false),
    // SphereConstraint(vec3<f32>(100.0 * sqrt(3.), -200.0, 0.0), 200., false),
    // SphereConstraint(vec3<f32>(-100.0 * sqrt(3.), -200.0, 0.0), 200., false),
    // SphereConstraint(vec3<f32>(0.0, -200.0, 100.0 * sqrt(3.)), 200., false),
    // SphereConstraint(vec3<f32>(0.0, -200.0, -100.0 * sqrt(3.)), 200., false),
  );

  var v_pos = item.pos;
  let decay = 1.8;

  let velocity = item.velocity;
  let next_pos = item.pos + velocity * params.delta_t;

  for (var i = 0u; i < 1u; i = i + 1u) {
    let constraint = constraints[i];
    let center = constraint.center;
    let radius = constraint.radius;
    let inside = constraint.inside;

    let next_base = next_pos - center;
    let next_distance = length(next_base);
    let direction = normalize(next_base);

    if inside {
      if length(next_distance) >= radius {
        let change_velocity = dot(direction, velocity) * direction;
        let next_velocity = velocity - decay * change_velocity;
        (*write_target).velocity = next_velocity;
        (*write_target).pos = v_pos + next_velocity * params.delta_t;
        return;
      }
    } else {
      if length(next_distance) <= radius {
        let change_velocity = dot(direction, velocity) * direction;
        let next_velocity = velocity - decay * change_velocity;
        (*write_target).velocity = next_velocity;
        (*write_target).pos = v_pos + next_velocity * params.delta_t;
        return;
      }
    }
  }
  (*write_target).pos = next_pos;
  (*write_target).velocity = velocity + vec3<f32>(0., -2., 0.);
}
