export function randPointInSphere(a: number, shift: number = 2) {
  var u = Math.random();
  var v = Math.random();
  var theta = u * 2.0 * Math.PI;
  var phi = Math.acos(2.0 * v - 1.0);
  var r = Math.cbrt(Math.random() + shift) * a;
  var sinTheta = Math.sin(theta);
  var cosTheta = Math.cos(theta);
  var sinPhi = Math.sin(phi);
  var cosPhi = Math.cos(phi);
  var x = r * sinPhi * cosTheta;
  var y = r * sinPhi * sinTheta;
  var z = r * cosPhi;
  return { x: x, y: y, z: z };
}

export let stringifyCompilationError = (
  error: GPUCompilationMessage,
  code: string,
  delta: number = 0
): string => {
  let lineNum = error.lineNum - delta; // suppose #import at file beginning
  let linePos = error.linePos;
  let lines = code.split("\n");
  let message = lineNum + " " + lines[lineNum - 1];
  message += "\n";
  message +=
    " ".repeat(linePos + lineNum.toString().length) + "^ " + error.message;
  console.error("WGSL Error:\n" + message);
  return "WGSL Error:\n" + message;
};

export let countLines = (s: string) => {
  return s.match(/\n/g).length;
};
