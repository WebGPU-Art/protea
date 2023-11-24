export const PHI = 0.5 * (Math.sqrt(5) - 1);

export let fiboGridN = (n: number, total: number): [number, number, number] => {
  let z = (2 * n - 1) / total - 1;
  let t = Math.sqrt(1 - z * z);
  let t2 = 2 * Math.PI * PHI * n;
  let x = t * Math.cos(t2);
  let y = t * Math.sin(t2);
  return [x, y, z];
};

export let rand_middle = (n: number) => {
  return n * (Math.random() - 0.5);
};
