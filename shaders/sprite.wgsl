struct UBO {
  cone_back_scale: f32,
  viewport_ratio: f32,
  look_distance: f32,
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
    vec3(x_next, y_next / uniforms.viewport_ratio, z_next),
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
  @location(1) velocity: vec3<f32>,
  @location(2) distance: f32,
  @location(3) idx: f32,
) -> VertexOutput {
  var pos: vec3<f32>;
  let up = vec3(0., 1., 0.);
  let v0 = normalize(velocity);
  let right = cross(v0, up);

  let front = params.length;
  let width = params.width;

  if (idx < 1f) {
    pos += v0 * front;
    let forward = cross(right, v0);
    pos += forward * width;
    // pos += vec3(1.,1.,1.) * 100.0;
  } else if (idx < 2f) {
    pos += v0 * front;
    let forward = cross(right, v0);
    pos -= forward * width;
  } else if (idx < 3f) {
    pos += right * width;
  } else if (idx < 4f ) {
    pos -= right * width;
  }

  var output: VertexOutput;
  let p0 = vec4((pos + position * 40.0) * 100.0, 1.0);

  let p = transform_perspective(p0.xyz).point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p[0]*scale, p[1]*scale, p[2]*scale, 1.0);
  let c3: vec3<f32> = hsl(fract(distance/100.), 0.8, 0.6);
  output.color = vec4(c3, params.opacity);
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  return color;
  // return vec4<f32>(0., 0., 0., 0.3);
}