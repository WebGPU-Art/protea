import isMobilejs from "ismobilejs";
import queryString from "query-string";

export let isMobile = isMobilejs(window.navigator).any; // TODO test

const parsed = queryString.parse(location.search);

export let useGamepad = parsed["gamepad"];

export let threshold = parseFloat((parsed["threshold"] as string) || "0.016");

export let useRemoteControl = parsed["remote-control"];

export let interval = parseFloat((parsed["interval"] as string) || "20");
