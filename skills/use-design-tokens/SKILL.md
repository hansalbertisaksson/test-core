---
name: use-design-tokens
description: Style anything visual with the shared design tokens. Use whenever writing or changing CSS, colours, fonts, spacing or layout.
---

# Use the design tokens

The design system lives in `.core/design/`. `tokens.css` holds the values as CSS variables, and `base.css` styles plain elements plus a few helpers (`.container`, `.button`, `.card`, `.label`, `.muted`).

The look follows doberman.co: black background, white text, uppercase grotesk headings with tight tracking, square corners and yellow (`--color-accent`) as the one signal colour. Violet, blush and red are for rare highlights. Keep layouts sparse and typographic, with lots of black.

## Rules

- Colours: only `var(--color-*)`. Never write a hex, rgb or hsl value in project CSS or HTML.
- Fonts: only `var(--font-sans)`, `var(--font-display)` and `var(--font-mono)`. Never add font files: Gerstner-Programm is licensed and used only where it's installed.
- Letter spacing: `var(--tracking-tight|normal|wide)`.
- Font sizes: `var(--size-xs)` up to `var(--size-3xl)`.
- Spacing: `var(--space-1)` up to `var(--space-16)`. Do not invent in-between values.
- Corners: `var(--radius-sm|md|lg|pill)`. They are square on purpose. Only use `pill` for small round marks.
- Reuse `.button`, `.card` and `.container` before writing new components.

## When a token is missing

Use the closest existing token, then tell the person which token seems to be missing and why. The design system owner decides whether it is added to the core. Never add tokens inside `.core/`.

## The check

`raw-colors` flags hard-coded colours in `site/`. In the prototype profile it warns. In stricter profiles it blocks.
