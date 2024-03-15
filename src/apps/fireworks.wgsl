
#import protea::perspective
#import protea::colors

struct Particle {
  pos: vec3<f32>,
  ages: f32,
  prev_pos: vec3<f32>,
  distance: f32,
  velocity: vec3<f32>,
  _pad: f32
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


struct ComputeResult {
  position: vec3f,
  velocity: vec3f,
  distance: f32,
}


/// https://www.dynamicmath.xyz/strange-attractors/
fn compute_move(p: vec3f, vol: vec3f, dt: f32) -> ComputeResult {
  let path = vol * dt;
  // let path = vec3(0., 0.01, 0.);;
  var next = p + path * 1.1;
  let vol_next = vol + vec3(0., -40.1, 0.) * dt;
  // next = clamp(next, vec3(-10000., -10000., -10000.0), vec3(10000., 10000., 10000.));
  return ComputeResult(
    next,
    vol_next,
    length(path)
  );
}



fn rand(n: f32) -> f32 { return fract(sin(n) * 43758.5453123); }

// https://github.com/austinEng/Project6-Vulkan-Flocking/blob/master/data/shaders/computeparticles/particle.comp
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
  var index = GlobalInvocationID.x;

  var v_pos = particles_a.particles[index].pos;
  let vol = particles_a.particles[index].velocity;
  // let vol = vec3(0.0, 20.1, 0.0);

  let level_1 = 400u;
  let level_2 = 40u;
  if index % level_1 != 0u {
    // inherit from previous poit
    let prev = index - 1u;
    particles_b.particles[index].pos = particles_a.particles[prev].pos;
    particles_b.particles[index].ages = particles_a.particles[prev].ages;
    particles_b.particles[index].prev_pos = particles_a.particles[prev].prev_pos;
    particles_b.particles[index].distance = particles_a.particles[prev].distance;
    particles_b.particles[index].velocity = particles_a.particles[prev].velocity;
    return;
  }

  let small_index = index / level_1;

  let age_limit = 3.0;

  if small_index % level_2 != 0u {
    // pick a common base point or (small_index / level_2)
    let common_divider = small_index / level_2;
    let common_index = common_divider * level_2 * level_1;
    let common_particle = particles_a.particles[common_index];

    if common_particle.ages < age_limit {
      particles_b.particles[index].pos = common_particle.pos;
      particles_b.particles[index].prev_pos = common_particle.prev_pos;
      if common_particle.ages + 0.01 >= age_limit {
        particles_b.particles[index].velocity = particles_a.particles[index].velocity * 0.4;
      }
      return;
    } else {
      let ret = compute_move(v_pos, vol, params.delta_t * 0.2 * (0. + 4. * rand(f32(index))));

      particles_b.particles[index].pos = ret.position;
      particles_b.particles[index].velocity = ret.velocity;
      particles_b.particles[index].prev_pos = v_pos;
      particles_b.particles[index].ages += 0.01;
      particles_b.particles[index].distance += ret.distance;
      return;
    }
  }

  if particles_a.particles[index].ages < age_limit {
    let ret = compute_move(v_pos, vol, params.delta_t * 0.2 * (0. + 4. * rand(f32(index))));
    // Write back
    particles_b.particles[index].pos = ret.position;
    particles_b.particles[index].velocity = ret.velocity;
    particles_b.particles[index].prev_pos = v_pos;
    particles_b.particles[index].ages += 0.01;
    particles_b.particles[index].distance += ret.distance;
  } else {
    particles_b.particles[index].ages += 0.01;
  }
}


struct VertexOutput {
  @builtin(position) position: vec4<f32>,
  @location(4) color: vec4<f32>,
}

@vertex
fn vert_main(
  @location(0) position: vec3<f32>,
  @location(1) ages: f32,
  @location(2) prev_pos: vec3<f32>,
  @location(3) travel: f32,
  @location(4) _v: vec3<f32>,
  @location(5) _p: f32,
  @location(6) idx: u32,
) -> VertexOutput {
  var pos: vec3<f32>;
  let v0 = position - prev_pos;
  var prev_position = prev_pos;

  let forward: vec3<f32> = uniforms.forward;
  let right = normalize(cross(v0, forward));

  // let front = params.length;
  var width = params.width * 1.4;

  if ages < 0.01 {
    // prev_position = position;
    width = 0.0;
  }
  // TODO hack
  if distance(position, prev_pos) > 1000.0 {
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
  let p0 = vec4(pos * 10.0, 1.0);

  let p: vec3<f32> = transform_perspective(p0.xyz).point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p[0] * scale, p[1] * scale, p[2] * scale, 1.0);
  let c3: vec3<f32> = hsl(fract(travel / 1000.), 0.8, max(0.1, 0.9 - ages * 0.2));
  output.color = vec4(c3, params.opacity);
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  return color;
  // return vec4<f32>(1., 0., 0., 1.0);
}