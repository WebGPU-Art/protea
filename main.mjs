import { main_$x_ } from "./js-out/app.main.mjs";

main_$x_();

if (import.meta.hot) {
  import.meta.hot.accept("./js-out/app.main.mjs", (main) => {
    if (main.reload_$x_) {
      main.reload_$x_();
    } else {
      throw new Error("Cannot apply hot update to main");
    }
  });
}
