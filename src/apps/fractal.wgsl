
#import protea::perspective
#import protea::colors


struct Particle {
  position: vec3<f32>,
  step_length: f32,
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

fn escaped(p: vec4<f32>) -> bool {
  var p1 = p;
  let offset = vec4<f32>(0.34, 0.0, 0.0, 0.66);
  for (var idx = 0u; idx < 800u; idx++) {
    p1 = quaternion_multiply(p1, p1) - offset;
    let l = length(p1);
    if l > 100.0 {
      return true;
    }
  }
  return false;
}

// fn rand(n: f32) -> f32 { return fract(sin(n) * 43758.5453123); }

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;

  let item = particles_a.particles[index];
  let v = item.position * 9.0;
  let decay = 0.1;

  let next_buffer = &particles_b.particles[index];
  let c = item.position != (*next_buffer).position;

  if item.step_length > 0.0000000001 {
    let q4_value = vec4(v.x, 0.00001, v.z, v.y);

    let go_inside = normalize(-item.position);
    if item.step_length > 0. {
      if escaped(q4_value) {
        let next = item.position + go_inside * item.step_length;
        (*next_buffer).position = next;
      } else {
        (*next_buffer).step_length = -item.step_length * decay;
      }
    } else {
      if escaped(q4_value) {
        (*next_buffer).step_length = -item.step_length * decay;
      } else {
        let next = item.position + go_inside * item.step_length;
        (*next_buffer).position = next;
      }
    }
  } else {
    (*next_buffer).step_length = item.step_length;
    (*next_buffer).position = item.position;
  }
}

// const eps = 0.0000000000001;

// fn point_equal(a: vec3<f32>, b: vec3<f32>) -> bool {
//   return abs(a.x - b.x) < eps && abs(a.y - b.y) < eps && abs(a.z - b.z) < eps;
// }


struct VertexOutput {
  @builtin(position) position: vec4<f32>,
  // inward
  @location(1) step_length: f32,
}

@vertex
fn vert_main(
  @location(0) position0: vec3<f32>,
  @location(1) step_length: f32,
  @location(2) idx: u32,
) -> VertexOutput {
  let position = position0.xyz * 8.;
  var pos: vec3<f32>;

  let rightward: vec3<f32> = uniforms.rightward;
  let upward: vec3<f32> = uniforms.upward;
  let right = normalize(rightward);
  let up = normalize(upward);

  // let front = params.length;
  var width = 0.0003;

  if idx == 0u {
    pos = position + right * width - up * width;
    // pos += vec3(1.,1.,1.) * 100.0;
  } else if idx == 1u {
    pos = position - right * width - up * width;
  } else if idx == 2u {
    pos = position + right * width + up * width;
  } else if idx == 3u {
    pos = position - right * width + up * width;
  } else {
    pos = position;
  }

  var output: VertexOutput;
  let p0 = vec4(pos * 1000.0, 1.0);

  let p: vec3<f32> = transform_perspective(p0.xyz).point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p * scale, 1.0);
  output.step_length = step_length;
  return output;
}

@fragment
fn frag_main(vtx_out: VertexOutput) -> @location(0) vec4<f32> {
  if vtx_out.step_length < 0. {
    return vec4<f32>(0.99, 0.6, 0.3, 0.99);
  } else {
    return vec4<f32>(0.6, 0.6, 0.99, 0.99);
  }
}