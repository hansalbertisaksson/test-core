// Turns design/tokens.json into design/tokens.css as CSS custom properties.
import { readFileSync, writeFileSync } from "node:fs";

const tokens = JSON.parse(readFileSync(new URL("../design/tokens.json", import.meta.url)));
const lines = [];
for (const [group, values] of Object.entries(tokens)) {
  for (const [name, value] of Object.entries(values)) {
    lines.push(`  --${group}-${name}: ${value};`);
  }
}
const css = `/* Generated from tokens.json by scripts/build-tokens.mjs. Do not edit by hand. */\n:root {\n${lines.join("\n")}\n}\n`;
writeFileSync(new URL("../design/tokens.css", import.meta.url), css);
console.log(`Wrote ${lines.length} tokens to design/tokens.css`);
