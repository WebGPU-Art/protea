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

const beta = 0.25;


// https://sequelaencollection.home.blog/3d-chaotic-attractors/
// -0.875, -0.173,  0.307, -0.436,  0.598,
//  0.003, -0.039,  0.96,  -0.84,   0.885,
//  0.774,  0.281, -0.015,  0.585,  0.442,
// -0.18,  -0.535, -0.151, -0.971, -0.48,
//  0.777,  0.418,  0.185,  0.006,  0.45,
// -0.066,  0.498,  0.142, -0.246, -0.939
const a0 =  -0.875; const a1 =  -0.173; const a2 =   0.307; const a3 =  -0.436; const a4 =   0.598;
const a5 =   0.003; const a6 =  -0.039; const a7 =   0.96;  const a8 =  -0.84;  const a9 =   0.885;
const a10 =  0.774; const a11 =  0.281; const a12 = -0.015; const a13 =  0.585; const a14 =  0.442;
const a15 = -0.18;  const a16 = -0.535; const a17 = -0.151; const a18 = -0.971; const a19 = -0.48;
const a20 =  0.777; const a21 =  0.418; const a22 =  0.185; const a23 =  0.006; const a24 =  0.45;
const a25 = -0.066; const a26 =  0.498; const a27 =  0.142; const a28 = -0.246; const a29 = -0.939;

fn iterate_fn(p: vec3f) -> vec3f {
  let x = p.x;
  let y = p.y;
  let z = p.z;

  let xy = x * y;
  let xz = x * z;
  let yz = y * z;
  let xx = x * x;
  let yy = y * y;
  let zz = z * z;

  let dx = a0 + a1 * x + a2 * y + a3 * z + a4 * xy + a5 * xz + a6 * yz + a7 * xx + a8 * yy + a9 * zz;
  let dy = a10 + a11 * x + a12 * y + a13 * z + a14 * xy + a15 * xz + a16 * yz + a17 * xx + a18 * yy + a19 * zz;
  let dz = a20 + a21 * x + a22 * y + a23 * z + a24 * xy + a25 * xz + a26 * yz + a27 * xx + a28 * yy + a29 * zz;
  let d = vec3<f32>(dx, dy, dz);
  return d;
}
// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;
  let item = particles_a.particles[index];
  let write_target = &particles_b.particles[index];

  let pos = iterate_fn(item.pos.xyz);
  (*write_target).pos = pos;
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
  var width = params.width * 1.0;

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
  let p0 = vec4(pos * 2000.0, 1.0);

  let p: vec3<f32> = transform_perspective(p0.xyz).point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p[0] * scale, p[1] * scale - 1., p[2] * scale, 1.0);
  let c3: vec3<f32> = hsl(fract(point_idx / 2000000.) + 0.6, 0.8, max(0.1, 0.9 - 0.2));
  output.color = vec4(c3, params.opacity);
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  // return color;
  return vec4<f32>(1., 1., 0., 1.0);
}