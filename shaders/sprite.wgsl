struct UBO {
  cone_back_scale: f32,
  viewport_ratio: f32,
  look_distance: f32,
  scale: f32,
  forward: vec3f,
  // direction up overhead, better unit vector
  upward: vec3f,
  rightward: vec3f,
  camera_position: vec3f,
};


struct SimParams {
  delta_t: f32,
  length: f32,
  width: f32,
  opacity: f32,
  rule1_scale: f32,
  rule2_scale: f32,
  rule3_scale: f32,
}

@group(0) @binding(0) var<uniform> uniforms: UBO;
@group(1) @binding(0) var<uniform> params: SimParams;

// perspective

struct PointResult {
  point_position: vec3f,
  r: f32,
  s: f32,
};

fn transform_perspective(p: vec3f) -> PointResult {
  let forward = uniforms.forward;
  let upward = uniforms.upward;
  let rightward = uniforms.rightward;
  let look_distance = uniforms.look_distance;
  let camera_position = uniforms.camera_position;

  let moved_point: vec3f = p - camera_position;

  let s: f32 = uniforms.cone_back_scale;

  let r: f32 = dot(moved_point, forward) / look_distance;

  // if (r < (s * -0.9)) {
  //   // make it disappear with depth test since it's probably behind the camera
  //   return PointResult(vec3(0.0, 0.0, 10000.), r, s);
  // }

  let screen_scale: f32 = (s + 1.0) / (r + s);
  let y_next: f32 = dot(moved_point, upward) * screen_scale;
  let x_next: f32 = dot(moved_point, rightward) * screen_scale;
  let z_next: f32 = r;

  return PointResult(
    vec3(x_next, y_next / uniforms.viewport_ratio, z_next) * uniforms.scale,
    r, s
  );
}

//!{{colors}}

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
  let right = normalize(cross(v0, uniforms.forward));

  // let front = params.length;
  var width = params.width * 1.4;

  if (ages < 0.01) {
    // prev_position = position;
    width = 0.0;
  }
  // TODO hack
  if (distance(position, prev_pos) > 1000.0) {
    width = 0.0;
  }

  if (idx == 0u) {
    pos = position + right * width;
    // pos += vec3(1.,1.,1.) * 100.0;
  } else if (idx == 1u) {
    pos = position - right * width;
  } else if (idx == 2u) {
    pos = prev_position + right * width;
  } else if (idx == 3u) {
    pos = prev_position - right * width;
  } else {
    pos = position;
  }

  var output: VertexOutput;
  let p0 = vec4(pos * 10.0, 1.0);

  let p = transform_perspective(p0.xyz).point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p[0]*scale, p[1]*scale, p[2]*scale, 1.0);
  let c3: vec3<f32> = hsl(fract(travel/1000.), 0.8, max(0.1, 0.9 - ages * 0.2));
  output.color = vec4(c3, params.opacity);
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  return color;
  // return vec4<f32>(1., 0., 0., 1.0);
}