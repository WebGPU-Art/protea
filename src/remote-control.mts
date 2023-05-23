import queryString from "query-string";
import { onControlEvent } from "./control.mjs";

let connected = false;

export let setupRemoteControl = () => {
  const parsed = queryString.parse(location.search);
  let host = (parsed["control-host"] as string) || "localhost";
  let port = parseInt((parsed["control-port"] as string) || "6200");
  let ws = new WebSocket(`ws://${host}:${port}`);

  ws.onopen = (event) => {
    connected = true;
    console.info("Remote Control connected, happy viewing!");
  };

  ws.onclose = (event) => {
    connected = false;
    console.warn("Lost connection to remote control");
  };

  ws.onerror = (error) => {
    console.error("socket error", error);
  };

  ws.onmessage = (event) => {
    let s = event.data;
    let op = JSON.parse(s);
    if (op.action === "control") {
      onControlEvent(op.elapsed, op.states, op.delta);
    }
  };
};
