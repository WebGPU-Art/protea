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


struct Params {
  delta_t: f32,
  length: f32,
  width: f32,
  opacity: f32,
}

@group(0) @binding(0) var<uniform> uniforms: UBO;
@group(1) @binding(0) var<uniform> params: Params;

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
  // inward
  @location(1) inward: f32,
}

@vertex
fn vert_main(
  @location(0) position0: vec3<f32>,
  @location(1) step_length: f32,
  @location(2) inward: f32,
  @location(3) p1: f32,
  @location(4) p2: f32,
  @location(5) p3: f32,
  @location(6) idx: u32,
) -> VertexOutput {
  let position = position0.xyz * 8.;
  var pos: vec3<f32>;
  let right = normalize(uniforms.rightward);
  let up = normalize(uniforms.upward);

  // let front = params.length;
  var width = 0.001;

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

  let p = transform_perspective(p0.xyz).point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p * scale, 1.0);
  output.inward = inward;
  return output;
}

@fragment
fn frag_main(vtx_out: VertexOutput) -> @location(0) vec4<f32> {
  if vtx_out.inward > 0.5 {
    return vec4<f32>(0.99, 0.6, 0.3, 0.8);
  } else {
    return vec4<f32>(0.6, 0.6, 0.99, 0.8);
  }
}