struct Particle {
  position: vec4<f32>,
  q4_value: vec4<f32>,
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

const tau = 10f;
const rou = 28f;

fn quaternion_multiply(a: vec4<f32>, b: vec4<f32>) -> vec4<f32> {
  return vec4<f32>(
    a.w * b.x + a.x * b.w + a.y * b.z - a.z * b.y,
    a.w * b.y - a.x * b.z + a.y * b.w + a.z * b.x,
    a.w * b.z + a.x * b.y - a.y * b.x + a.z * b.w,
    a.w * b.w - a.x * b.x - a.y * b.y - a.z * b.z
  );
}

fn rand(n: f32) -> f32 { return fract(sin(n) * 43758.5453123); }

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;

  // var v_pos = particles_a.particles[index].position;
  let q4_value = particles_a.particles[index].q4_value;
  let offset = vec4<f32>(0.0, 0.0, 0.0, 0.999);
  let next = quaternion_multiply(q4_value, q4_value) - offset;
  particles_b.particles[index].q4_value = next;
}
