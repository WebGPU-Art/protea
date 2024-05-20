
#import protea::perspective
#import protea::colors

struct Particle {
  pos: vec4<f32>,
  prev_pos: vec4<f32>,
  // distance: f32,
}

struct Params {
  delta_t: f32,
  zoom: f32,
  width: f32,
  opacity: f32,
}

struct Particles {
  particles: array<Particle>,
}

@group(0) @binding(1) var<uniform> params: Params;
@group(1) @binding(0) var<storage, read> particles_a: Particles;
@group(1) @binding(1) var<storage, read_write> particles_b: Particles;

struct BoualiResult {
  position: vec4f,

  distance: f32,
}


fn bouali(p: vec4f, dt: f32) -> BoualiResult {
  let x = p.x;
  let y = p.y;
  let z = p.z;
  let v = p.w;

  let dx = 3. * x * (1. - y) - 0.1 * z;
  let dy = - y * (1. - x * x);
  let dz = - 0.02 * v;
  let dv = 0.01 * z;
  let d = vec4<f32>(dx, dy, dz, dv) * dt;
  return BoualiResult(
    p + d,
    length(d) * 2.1
  );
}

fn rand(n: f32) -> f32 { return fract(sin(n) * 43758.5453123); }

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;

  var v_pos = particles_a.particles[index].pos;
  // let dd = floor(f32(index) / 80.0);

  let unit = 40000u;

  let inner_idx = f32(index % unit);
  let group_idx = floor(f32(index) / f32(unit));

  if index % unit != 0u {
    let prev = index - 1u;
    particles_b.particles[index].pos = particles_a.particles[prev].pos;
    // particles_b.particles[index].ages = particles_a.particles[prev].ages;
    // particles_b.particles[index].distance = inner_idx;
    particles_b.particles[index].prev_pos = particles_a.particles[prev].prev_pos;
    // particles_b.particles[index].distance = particles_a.particles[prev].distance;
    // particles_b.particles[index].distance = group_idx;
    return;
  }

  let ret = bouali(v_pos, params.delta_t * 0.01);

  // Write back
  particles_b.particles[index].pos = ret.position;
  // particles_b.particles[index].distance = inner_idx;
  particles_b.particles[index].prev_pos = v_pos;
  // particles_b.particles[index].distance += ret.distance;
  // particles_b.particles[index].distance = group_idx;
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
  let zoom: f32 = 0.002;
  var output: VertexOutput;

  let position = position0 ;
  let prev_pos = prev_pos0 ;

  // let front = params.length;
  var width = params.width * 1.;

  let center_ret = transform_perspective(position);

  let outside = center_ret.side_distance > center_ret.front_distance * 0.8;
  if outside {
    width *= 0.0;
    output.position = vec4(center_ret.point_position.xyz * zoom, 1.0);
    return output;
  }


  var pos: vec3<f32>;
  let v0 = position - prev_pos;
  var prev_position = prev_pos;
  let forward: vec3<f32> = uniforms.forward;
  let right = normalize(cross(v0, forward));


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

  let p0 = vec4(pos * params.zoom, 1.0);

  let p: vec3<f32> = transform_perspective(p0.xyz).point_position;

  output.position = vec4(p * zoom, 1.0);
  let c3: vec3<f32> = hsl(fract(travel * 0.000005), 0.998, 0.5 - ages * 0.002);
  output.color = vec4(c3, params.opacity * (1.2 - ages * 0.04));
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  return color;
  // return vec4<f32>(0.7, 0.7, 1., 1.0);
}