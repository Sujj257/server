export const trueTypeOf = (obj) =>
  Object.prototype.toString.call(obj).slice(8, -1).toLowerCase();

export const nulltransform = (value: string, returnInt: boolean): any =>
  value == 'null' ? null : returnInt ? parseInt(value) : value;
