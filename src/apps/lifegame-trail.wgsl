
#import protea::perspective
#import protea::colors


struct Particle {
  pos: vec3<f32>,
  idx: f32,
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

const unit_size = 160u;

fn safe_index(cursor: u32, max_idx: u32, x: i32, y: i32, z: i32) -> u32 {
  let unit = i32(unit_size);
  let x_offset = x * unit * unit;
  let y_offset = y * unit;
  let z_offset = z;
  let total = i32(cursor) + x_offset + y_offset + z_offset;
  // if not in bounds, return current
  if total < 0 || total >= i32(max_idx) {
    return cursor;
  } else {
    return u32(total);
  }
}

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;
  let item = particles_a.particles[index];
  let write_target = &particles_b.particles[index];

  let max_idx = arrayLength(&particles_a.particles);

  if index >= max_idx - unit_size * unit_size {
    let v_0_n1_n1 = particles_a.particles[safe_index(index, max_idx, 0, -1, -1)].idx;
    let v_0_n1_0 = particles_a.particles[safe_index(index, max_idx, 0, -1, 0)].idx;
    let v_0_n1_1 = particles_a.particles[safe_index(index, max_idx, 0, -1, 1)].idx;
    let v_0_0_n1 = particles_a.particles[safe_index(index, max_idx, 0, 0, -1)].idx;
    let v_0_0_0 = particles_a.particles[index].idx;
    let v_0_0_1 = particles_a.particles[safe_index(index, max_idx, 0, 0, 1)].idx;
    let v_0_1_n1 = particles_a.particles[safe_index(index, max_idx, 0, 1, -1)].idx;
    let v_0_1_0 = particles_a.particles[safe_index(index, max_idx, 0, 1, 0)].idx;
    let v_0_1_1 = particles_a.particles[safe_index(index, max_idx, 0, 1, 1)].idx;

    let counted = v_0_n1_n1 + v_0_n1_0 + v_0_n1_1 + v_0_0_n1 + v_0_0_1 + v_0_1_n1 + v_0_1_0 + v_0_1_1;
    var next = v_0_0_0;
    if v_0_0_0 > 0.5 {
      if counted < 1.5 {
        next = 0.0;
      } else if counted < 3.5 {
        next = v_0_0_0;
      } else {
        next = 0.0;
      }
    } else {
      if counted > 2.5 && counted < 3.5 {
        next = 1.0;
      }
    }

    (*write_target).idx = next;
  } else {
    (*write_target).idx = particles_a.particles[index + unit_size * unit_size].idx;
  }
}

struct VertexOutput {
  @builtin(position) position: vec4<f32>,
  @location(4) color: vec4<f32>,
}

@vertex
fn vert_main(
  @location(0) position: vec3<f32>,
  @location(1) point_idx: f32,
  @location(2) idx: u32,
) -> VertexOutput {
  var pos: vec3<f32>;
  let rightward: vec3<f32> = uniforms.rightward;
  let upward: vec3<f32> = uniforms.upward;
  let right = normalize(rightward);
  let up = normalize(upward);

  // let front = params.length;
  var width = params.width * 0.1 + point_idx * 2.0;

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
  let c3: vec3<f32> = hsl(fract(point_idx / 20.) + 0.6, 0.8, max(0.1, 0.9 - 0.2));
  output.color = vec4(c3, params.opacity);
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  // return color;
  return vec4<f32>(1., 1., 1., 0.5);
}