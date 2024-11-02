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

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  // var index = GlobalInvocationID.x;
  // let item = particles_a.particles[index];
  // let write_target = &particles_b.particles[index];

  // let a = item.pos.y * 0.01;
  // let x = item.pos.x * 0.02;
  // let y = item.pos.z * 0.02;

  // let pos = bifurcation(a, x, y);
  // (*write_target).pos.x = pos.x * 50.0;
  // (*write_target).pos.z = pos.y * 50.0;
}


struct VertexOutput {
  @builtin(position) position: vec4<f32>,
  @location(4) color: vec4<f32>,
}

const sqrt3 = 1.7320508075688772;

@vertex
fn vert_main(
  @location(0) x: f32,
  @location(1) y: f32,
  @location(2) _z: u32,
  @location(3) value: u32,
  @location(4) idx: u32,
) -> VertexOutput {

  var pos: vec3<f32>;
  let rightward: vec3<f32> = uniforms.rightward;
  let upward: vec3<f32> = uniforms.upward;
  let right = normalize(rightward);
  let up = normalize(upward);

  let x_axis = 0.5 * rightward - sqrt3 * 0.5 * upward;
  let y_axis = - 0.5 * rightward - sqrt3 * 0.5 * upward;

  let position = (f32(x) * x_axis + f32(y) * y_axis) * 2. + vec3<f32>(0., 400., 0.);

  // let front = params.length;
  var width = params.width * 5.8;

  // vertices in hexagon
  if idx == 0u {
    pos = position + vec3f(0., width * 1., 0.);
    // pos += vec3(1.,1.,1.) * 100.0;
  } else if idx == 1u {
    pos = position + vec3f(sqrt3 * 0.5 * width, width * 0.5, 0.);
  } else if idx == 2u {
    pos = position + vec3f(sqrt3 * 0.5 * width, -width * 0.5, 0.);
  } else if idx == 3u {
    pos = position + vec3f(0., -width * 1., 0.);
  } else if idx == 4u {
    pos = position + vec3f(-sqrt3 * 0.5 * width, -width * 0.5, 0.);
  } else if idx == 5u {
    pos = position + vec3f(-sqrt3 * 0.5 * width, width * 0.5, 0.);
  }

  var output: VertexOutput;
  let p0 = vec4(pos * 10.0, 1.0);

  let p: vec3<f32> = transform_perspective(p0.xyz).point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p[0] * scale, p[1] * scale - 1., p[2] * scale, 1.0);
  // let c3: vec3<f32> = hsl(fract(point_idx / 2000000.) + 0.6, 0.8, max(0.1, 0.9 - 0.2));
  let dark = 0.5;
  let bright = dark + 0.08;
  var c3 = vec3<f32>(dark, dark, dark);
  if value >= 1u {
    c3 = vec3<f32>(bright, bright, bright);
  }
  output.color = vec4(c3, params.opacity);
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  return color;
  // return vec4<f32>(1., 1., 0., 1.0);
}