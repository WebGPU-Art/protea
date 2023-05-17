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


fn hue2rgb(f1: f32, f2: f32, hue0: f32) -> f32 {
  var hue = hue0;
  if hue < 0.0 {
    hue += 1.0;
  } else if hue > 1.0 {
    hue -= 1.0;
  }
  var res: f32;
  if (6.0 * hue) < 1.0 {
    res = f1 + (f2 - f1) * 6.0 * hue;
  } else if (2.0 * hue) < 1.0 {
    res = f2;
  } else if (3.0 * hue) < 2.0 {
    res = f1 + (f2 - f1) * ((2.0 / 3.0) - hue) * 6.0;
  } else {
    res = f1;
  }
  return res;
}

fn hsl2rgb(hsl: vec3f) -> vec3f {
  var rgb = vec3f(0.0, 0.0, 0.0);
  if (hsl.y == 0.0) {
    rgb = vec3f(hsl.z); // Luminance
  } else {
    var f2: f32;
    if (hsl.z < 0.5) {
      f2 = hsl.z * (1.0 + hsl.y);
    } else {
      f2 = hsl.z + hsl.y - hsl.y * hsl.z;
    }
    let f1 = 2.0 * hsl.z - f2;
    rgb.r = hue2rgb(f1, f2, hsl.x + (1.0/3.0));
    rgb.g = hue2rgb(f1, f2, hsl.x);
    rgb.b = hue2rgb(f1, f2, hsl.x - (1.0/3.0));
  }
  return rgb;
}

fn hsl(h: f32, s: f32, l: f32) -> vec3f {
  return hsl2rgb(vec3f(h, s, l));
}

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

  let front = 1.2;
  let width = 0.12;

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
  let p0 = vec4((pos + position) * 100.0, 1.0);

  let p = transform_perspective(p0.xyz).point_position;
  let scale: f32 = 0.002;

  output.position = vec4(p[0]*scale, p[1]*scale, p[2]*scale, 1.0);
  output.color = vec4(hsl(fract(distance/100.), 0.8, 0.6), 0.5);
  return output;
}

@fragment
fn frag_main(@location(4) color: vec4<f32>) -> @location(0) vec4<f32> {
  return color;
  // return vec4<f32>(0., 0., 0., 0.3);
}