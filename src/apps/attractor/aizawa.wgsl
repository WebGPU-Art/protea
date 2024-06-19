
#import protea::perspective
#import protea::colors

struct Particle {
  pos: vec3<f32>,
  ages: f32,
  prev_pos: vec3<f32>,
  distance: f32,
}

struct Params {
  delta_t: f32,
  scale: f32,
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

struct LorenzResult {
  position: vec3f,
  velocity: vec3f,
  distance: f32,
}

/// ok
fn aizawa(p: vec3f, dt: f32) -> LorenzResult {
  let a = 0.95;
  let b = 0.7;
  let c = 0.6;
  let d0 = 3.5;
  let e = 0.25;
  let f = 0.1;

  let x = p.x;
  let y = p.y;
  let z = p.z;

  let dx = (z - b) * x - d0 * y;
  let dy = d0 * x + (z - b) * y;
  let dz = c + a * z - pow(z, 3.0) / 3.0 - (x * x + y * y) * (1. + e * z) + f * z * pow(x, 3.0);

  var d = vec3<f32>(dx, dy, dz) * dt * 0.8;
  // let dl = length(d);
  // if (dl > 0.2) {
  //   d = d / dl * 0.2;
  // } else if (dl < 0.01) {
  //   d = d / dl * 0.01;
  // }
  let next = p + d;
  // if (length(next) > 100.0) {
  //   next = vec3(0.1);
  // }
  return LorenzResult(
    next,
    vec3(dx, dy, dz),
    length(d) * 8.8
  );
}


fn rand(n: f32) -> f32 { return fract(sin(n) * 43758.5453123); }

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;

  var v_pos = particles_a.particles[index].pos;
  // let dd = floor(f32(index) / 80.0);

  let inner_idx = f32(index % 24u);
  let group_idx = floor(f32(index) / 24.0);

  if index % 24u != 0u {
    let prev = index - 1u;
    particles_b.particles[index].pos = particles_a.particles[prev].pos;
    // particles_b.particles[index].ages = particles_a.particles[prev].ages;
    particles_b.particles[index].ages = inner_idx;
    particles_b.particles[index].prev_pos = particles_a.particles[prev].prev_pos;
    // particles_b.particles[index].distance = particles_a.particles[prev].distance;
    particles_b.particles[index].distance = group_idx;
    return;
  }

  // let ret = lorenz(v_pos, params.delta_t * 0.01 * (2. + 2. * rand(f32(index))));
  // let ret = four_wing(v_pos, params.delta_t * 0.01 * (20. + 2. * rand(f32(index))));
  let ret = aizawa(v_pos, params.delta_t * 0.001 * (12. + 4. * rand(f32(index))));

  // let ret = lorenz(v_pos, params.delta_t * 0.2);
  // let ret = chen(v_pos, params.delta_t * 0.8);

  // Write back
  particles_b.particles[index].pos = ret.position;
  particles_b.particles[index].ages = inner_idx;
  particles_b.particles[index].prev_pos = v_pos;
  // particles_b.particles[index].distance += ret.distance;
  particles_b.particles[index].distance = group_idx;
}

struct VertexOutput {
  @builtin(position) position: vec4<f32>,
  @location(4) color: vec4<f32>,
}

@vertex
fn vert_main(
  @location(0) position0: vec3<f32>,
  @location(1) ages: f32,
  @location(2) prev_pos0: vec3<f32>,
  @location(3) travel: f32,
  @location(4) idx: u32,
) -> VertexOutput {
  let position = position0 * 8.;
  let prev_pos = prev_pos0 * 8.;
  var pos: vec3<f32>;
  let v0 = position - prev_pos;
  var prev_position = prev_pos;
  let forward: vec3<f32> = uniforms.forward;
  let right = normalize(cross(v0, forward));

  // let front = params.length;
  var width = params.width * 8.;

  if ages < 0.01 {
    // prev_position = position;
    width = 0.0;
  }
  // TODO hack
  if distance(position, prev_pos) > 12.2 {
    width = 0.0;
  }

  if idx == 0u {
    pos = position + right * width;
    // pos += vec3(1.,1.,1.) * 100.0;
  } else if idx == 1u {
    pos = position - right * width;
  } else if idx == 2u {
    pos = prev_position + right * width;
  } else if idx == 3u {
    pos = prev_position - right * width;
  } else {
    pos = position;
  }

  var output: VertexOutput;
  let p0 = vec4(pos * params.scale, 1.0);

  let p: vec3<f32> = transform_perspective(p0.xyz).point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p * scale, 1.0);
  // let c3: vec3<f32> = hsl(fract(travel/100.), 0.8, fract(0.9 - ages * 0.0002));
  // let c3: vec3<f32> = hsl(0.24, 0.8, 0.7 + 0.3 * sin(travel * 0.2));
  // let c3 = hsl(0.24, 0.99, 0.99 - dim);
  // let c3 = vec3<f32>(0.99, 0.94, 0.2) * (1. - ages * 0.01);
  let c3: vec3<f32> = hsl(fract(travel * 0.000008 + 0.0), 0.998, 0.5 - ages * 0.002);
  output.color = vec4(c3, params.opacity * (1.2 - ages * 0.04));
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  return color;
  // return vec4<f32>(0.7, 0.7, 1., 1.0);
}