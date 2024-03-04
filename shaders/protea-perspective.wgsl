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

@group(0) @binding(0) var<uniform> uniforms: UBO;


struct PointResult {
  point_position: vec3f,
  r: f32,
  front_distance: f32,
  side_distance: f32
};

fn transform_perspective(p: vec3f) -> PointResult {
  let forward = uniforms.forward;
  let upward = uniforms.upward;
  let rightward = uniforms.rightward;
  let look_distance = uniforms.look_distance;
  let camera_position = uniforms.camera_position;

  let relative_to_camera: vec3f = p - camera_position;

  let s: f32 = uniforms.cone_back_scale;

  let front_distance = dot(relative_to_camera, forward);
  let right_distance = dot(relative_to_camera, rightward);
  let up_distance = dot(relative_to_camera, upward);

  let side_distance: f32 = sqrt(right_distance * right_distance + up_distance * up_distance);

  let r: f32 = front_distance / look_distance;

  // if r < (s * -0.9) {
  //   // make it disappear with depth test since it's probably behind the camera
  //   return PointResult(vec3(0.0, 0.0, 10000.), r, s, 0.);
  // }

  let screen_scale: f32 = (s + 1.0) / (r + s);
  let y_next: f32 = up_distance * screen_scale;
  let x_next: f32 = right_distance * screen_scale;
  let z_next: f32 = r;

  return PointResult(
    vec3(x_next, y_next / uniforms.viewport_ratio, z_next) * uniforms.scale,
    r,
    front_distance + look_distance * s,
    side_distance
  );
}
