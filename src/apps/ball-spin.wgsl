
#import protea::perspective
#import protea::colors

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

@group(0) @binding(1) var<uniform> params: Params;
@group(1) @binding(0) var<storage, read> particles_a: Particles;
@group(1) @binding(1) var<storage, read_write> particles_b: Particles;

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

  let constraints = array<SphereConstraint, 1>(
    SphereConstraint(vec3<f32>(0.0, 0.0, 0.0), 200.0, true),
    // SphereConstraint(vec3<f32>(100.0 * sqrt(3.), -200.0, 0.0), 200., false),
    // SphereConstraint(vec3<f32>(-100.0 * sqrt(3.), -200.0, 0.0), 200., false),
    // SphereConstraint(vec3<f32>(0.0, -200.0, 100.0 * sqrt(3.)), 200., false),
    // SphereConstraint(vec3<f32>(0.0, -200.0, -100.0 * sqrt(3.)), 200., false),
  );

  var v_pos = item.pos;
  let decay = 2.0;

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
  (*write_target).velocity = velocity + vec3<f32>(0., -0., 0.);
}


struct VertexOutput {
  @builtin(position) position: vec4<f32>,
  @location(4) color: vec4<f32>,
}

@vertex
fn vert_main(
  @location(0) position: vec3<f32>,
  @location(1) point_idx: f32,
  @location(2) velocity: vec3<f32>,
  @location(3) _travel: f32,
  @location(4) _v: vec4<f32>,
  @location(5) idx: u32,
) -> VertexOutput {
  var pos: vec3<f32>;
  let rightward: vec3<f32> = uniforms.rightward;
  let upward: vec3<f32> = uniforms.upward;
  let right = normalize(rightward);
  let up = normalize(upward);

  // let front = params.length;
  var width = params.width * 2.0;

  if idx == 0u {
    pos = position + right * width;
    // pos += vec3(1.,1.,1.) * 100.0;
  } else if idx == 1u {
    pos = position;
  } else if idx == 2u {
    pos = position + right * width + up * width;
  } else if idx == 3u {
    pos = position + up * width;
  } else {
    pos = position;
  }

  var output: VertexOutput;
  let p0 = vec4(pos * 10.0, 1.0);

  let p: vec3<f32> = transform_perspective(p0.xyz).point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p[0] * scale, p[1] * scale, p[2] * scale, 1.0);
  let c3: vec3<f32> = hsl(fract(point_idx / 2000000.) + 0.6, 0.8, max(0.1, 0.9 - 0.2));
  output.color = vec4(c3, params.opacity);
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  return color;
  // return vec4<f32>(1., 0., 0., 1.0);
}