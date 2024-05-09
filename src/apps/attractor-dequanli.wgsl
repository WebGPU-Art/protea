
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

struct AttractorResult {
  position: vec3f,
  velocity: vec3f,
  distance: f32,
}

/// https://gist.github.com/gcalmettes/b470179e1707700463d236525a0c3613#file-index-html-L202
fn dequan_li(p: vec3f, dt: f32) -> AttractorResult {
  let a = 40.0;
  let c = 11. / 6.;
  let d = 0.16;
  let e = 0.65;
  let k = 55.;
  let f = 20.;

  var x = p.x;
  var y = p.y;
  var z = p.z;

  let dx = a * (y - x) + d * x * z;
  x += dx * dt; // modification order is influential
  let dy = k * x + f * y - x * z;
  y += dy * dt;
  let dz = c * z + x * y - e * x * x;
  z += dz * dt;
  let dv = vec3<f32>(dx, dy, dz) * dt;
  return AttractorResult(
    vec3(x, y, z),
    vec3(dx, dy, dz),
    length(dv) * 2.1
  );
}

fn rand(n: f32) -> f32 { return fract(sin(n) * 43758.5453123); }

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;

  var v_pos = particles_a.particles[index].pos;
  // let dd = floor(f32(index) / 80.0);

  let inner_idx = f32(index % 20u);
  let group_idx = floor(f32(index) / 20.0);

  if index % 20u != 0u {
    let prev = index - 1u;
    particles_b.particles[index].pos = particles_a.particles[prev].pos;
    // particles_b.particles[index].ages = particles_a.particles[prev].ages;
    particles_b.particles[index].ages = inner_idx;
    particles_b.particles[index].prev_pos = particles_a.particles[prev].prev_pos;
    // particles_b.particles[index].distance = particles_a.particles[prev].distance;
    particles_b.particles[index].distance = group_idx;
    return;
  }

  let ret = dequan_li(v_pos, params.delta_t * 0.0001 * (20. + 10. * rand(f32(index))));

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
  var width = params.width * 40.;

  // if ages < 0.01 {
  //   // prev_position = position;
  //   width = 0.0;
  // }
  // // TODO hack
  // if distance(position, prev_pos) > 12.2 {
  //   width = 0.0;
  // }

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

  let p: vec3<f32> = transform_perspective(p0.xyz * 0.4).point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p * scale, 1.0);
  // let c3: vec3<f32> = hsl(fract(travel/100.), 0.8, fract(0.9 - ages * 0.0002));
  // let c3: vec3<f32> = hsl(0.24, 0.8, 0.7 + 0.3 * sin(travel * 0.2));
  // let c3 = hsl(0.24, 0.99, 0.99 - dim);
  // let c3 = vec3<f32>(0.99, 0.94, 0.2) * (1. - ages * 0.01);
  let c3: vec3<f32> = hsl(fract(travel * 0.000003 + 0.0), 0.998, 0.7 - ages * 0.002);
  output.color = vec4(c3, params.opacity * (1.2 - ages * 0.002));
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  return color;
  // return vec4<f32>(0.7, 0.7, 1., 1.0);
}