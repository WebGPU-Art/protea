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

@group(0) @binding(0) var<uniform> uniforms: UBO;

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

struct VertexOutput {
  @builtin(position) position: vec4<f32>,
  @location(4) color: vec4<f32>,
}

@vertex
fn vert_main(
  @location(0) a_particle_pos: vec3<f32>,
  @location(1) a_particle_vel: vec3<f32>,
  @location(2) a_pos: vec3<f32>
) -> VertexOutput {
  let angle = -atan2(a_particle_vel.x, a_particle_vel.y);
  let pos = vec3(
    (a_pos.x * cos(angle)) - (a_pos.y * sin(angle)),
    (a_pos.x * sin(angle)) + (a_pos.y * cos(angle)),
    a_pos.z * 1.0,
  );

  var output: VertexOutput;
  let p0 = vec4((pos + a_particle_pos) * 1000.0, 1.0);

  let p = transform_perspective(p0.xyz).point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p[0]*scale, p[1]*scale, p[2]*scale, 1.0);
  output.color = vec4(
    1.0 - sin(angle + 1.0) - a_particle_vel.y,
    pos.x * 100.0 - a_particle_vel.y + 0.1,
    a_particle_vel.x + cos(angle + 0.5),
    1.0);
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  // return color;
  return vec4<f32>(0.7, 0.7, 0.7, 1.0);
}