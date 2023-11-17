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

struct Stroke {
  p0: vec3<f32>,
  p1: vec3<f32>,
}

fn rand(n: f32) -> f32 { return fract(sin(n) * 43758.5453123); }

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;
  let item = particles_a.particles[index];
  let write_target = &particles_b.particles[index];

  let constraints = array<SphereConstraint, 5>(
    SphereConstraint(vec3<f32>(0.0, 50.0, 0.0), 150.0, true),
    SphereConstraint(vec3<f32>(100.0 * sqrt(3.), -100.0, 0.0), 40., false),
    SphereConstraint(vec3<f32>(-100.0 * sqrt(3.), -100.0, 0.0), 40., false),
    SphereConstraint(vec3<f32>(0.0, -100.0, 100.0 * sqrt(3.)), 40., false),
    SphereConstraint(vec3<f32>(0.0, -100.0, -100.0 * sqrt(3.)), 40., false),
  );

  let xu = 10.0;
  let yu = 15.0;

  let strokes = array<Stroke, 15>(
        // D
    Stroke(vec3<f32>(-1. * xu, 1. * yu, 0.), vec3<f32>(1. * xu, 0. * yu, 0.0)),
    Stroke(vec3<f32>(-1. * xu, -1. * yu, 0.), vec3<f32>(1. * xu, 0. * yu, 0.0)),
    Stroke(vec3<f32>(-1. * xu, 1. * yu, 0.), vec3<f32>(-1. * xu, -1. * yu, 0.0)),
        // A
    Stroke(vec3<f32>(2. * xu, 1. * yu, 0.), vec3<f32>(3. * xu, -1. * yu, 0.0)),
    Stroke(vec3<f32>(2. * xu, 1. * yu, 0.), vec3<f32>(1. * xu, -1. * yu, 0.0)),
    Stroke(vec3<f32>(3. * xu, -1. * yu, 0.), vec3<f32>(1. * xu, -1. * yu, 0.0)),
        // E
    Stroke(vec3<f32>(-1. * xu, 1. * yu, 0.), vec3<f32>(-3. * xu, 0. * yu, 0.0)),
    Stroke(vec3<f32>(-1. * xu, -1. * yu, 0.), vec3<f32>(-3. * xu, 0. * yu, 0.0)),
    Stroke(vec3<f32>(-5. * xu, 0. * yu, 0.), vec3<f32>(-1. * xu, 0. * yu, 0.0)),
        // F i
    Stroke(vec3<f32>(-3. * xu, 1. * yu, 0.), vec3<f32>(-5. * xu, 1. * yu, 0.0)),
    Stroke(vec3<f32>(-5. * xu, 1. * yu, 0.), vec3<f32>(-5. * xu, -1. * yu, 0.0)),
    Stroke(vec3<f32>(4. * xu, 0. * yu, 0.), vec3<f32>(4. * xu, -1. * yu, 0.0)),
        // Y
    Stroke(vec3<f32>(4. * xu, 0. * yu, 0.), vec3<f32>(5. * xu, 1. * yu, 0.0)),
    Stroke(vec3<f32>(4. * xu, 0. * yu, 0.), vec3<f32>(3. * xu, 1. * yu, 0.0)),
    Stroke(vec3<f32>(5. * xu, 1. * yu, 0.), vec3<f32>(3. * xu, 1. * yu, 0.0)),
  );

  var v_pos = item.pos;
  let decay = 2.0;

  var velocity = item.velocity;
  let next_pos = item.pos + velocity * params.delta_t;
  var slow_down = false;

  for (var i = 0u; i < 15u; i = i + 1u) {
    let pair = strokes[i];
    let p0 = pair.p0;
    let p1 = pair.p1;
        /// direction pointing up
    let perp_direction = cross(item.pos - p0, p1 - p0);
        /// direction pointing from line to particle
    let side_direction = normalize(cross(p1 - p0, perp_direction));
        /// distance to infinite line
    let near_distance = dot(item.pos - p0, side_direction);

    let near_point = item.pos - near_distance * side_direction;

    var close = 1000.0;
    if dot(p1 - near_point, p0 - near_point) < 0.0 {
      close = near_distance;
    } else {
      close = min(length(item.pos - p0), length(item.pos - p1));
    }

    if close < 1.0 {
      velocity = vec3<f32>(0.0, 0.0, 0.0);
            break;
    }
    if close < 40.0 {
      velocity = velocity - side_direction * 40.1 / pow(close, 2.);
    }
  }

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
  if slow_down {
    (*write_target).velocity = velocity;
  } else {
    (*write_target).velocity = velocity + vec3<f32>(0., -2., 0.);
  }
}