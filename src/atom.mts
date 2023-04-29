/**
 * trying to simultate a Clojure Atom
 */
export class Atom<T> {
  value: T;
  listeners: { [name: string]: Array<(prev: T, next: T) => void> } = {};
  constructor(value: T) {
    this.value = value;
  }
  deref(): T {
    return this.value;
  }
  reset(value: T) {
    let prev = this.value;
    this.value = value;
    this.triggerListeners(prev, value);
  }
  swap(f: (value: T) => T) {
    let prev = this.value;
    this.value = f(this.value);
    this.triggerListeners(prev, this.value);
  }
  addWatch(name: string, f: (prev: T, next: T) => void) {
    if (this.listeners[name] == null) {
      this.listeners[name] = [];
    }
    this.listeners[name].push(f);
  }
  removeWatch(name: string) {
    if (this.listeners[name] != null) {
      delete this.listeners[name];
    }
  }
  private triggerListeners(prev: T, next: T) {
    for (let name in this.listeners) {
      this.listeners[name].forEach((f) => f(prev, next));
    }
  }
}
