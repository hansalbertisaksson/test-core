---
name: use-design-tokens
description: Style anything visual with the shared design tokens. Use whenever writing or changing CSS, colours, fonts, spacing or layout.
---

# Use the design tokens

The design system lives in `.core/design/`. `tokens.css` holds the values as CSS variables, and `base.css` styles plain elements and the building blocks below.

The look follows doberman.co. Type does the work: one grotesk, uppercase for navigation and labels, huge centred display lines, large sentence-case body text, image grids with hairline gutters. No boxes, shadows or filled buttons. Black by default; `class="theme-light"` on `<body>` gives the white case-study look. Yellow, violet and blush appear only as image or tile colour, never as UI chrome. Hover and the current page are shown in italics.

## Building blocks in base.css

- `.site-nav`: fixed top bar, items spread edge to edge, a `<small>` gives the grey second line under the first item. Mark the current page with `.is-current`.
- `.site-corner`: fixed uppercase text, bottom left.
- `.display-section` with `.display`: a full-height section with one huge centred line, the way pages open.
- `.page`: the content wrapper with the page margin.
- `.split`: uppercase label on the left, large text from the middle.
- `.tiles` (3 columns) or `.tiles.four`, each `.tile` with a `.tile-media` and an uppercase `.tile-caption` that gets an arrow.
- `.title`, `.lede`, `.label`, `.muted` for text, `.pill` for tags and buttons, `.arrow-link`, `.rule`.

## Rules

- Colours: only `var(--color-*)`. Never write a hex, rgb or hsl value in project CSS or HTML.
- Fonts: only `var(--font-sans)`, `var(--font-display)` and `var(--font-mono)`. Never add font files: Gerstner-Programm is licensed and used only where it's installed.
- Letter spacing: `var(--tracking-tight|normal|wide)`.
- Font sizes: `var(--size-xs)` up to `var(--size-3xl)`.
- Spacing: `var(--space-1)` up to `var(--space-16)`. Do not invent in-between values.
- Corners: `var(--radius-sm|md|lg|pill)`. They are square on purpose. Only use `pill` for small round marks.
- Reuse the building blocks above before writing new components. Don't add cards with borders or filled buttons, they are not part of this look.

## When a token is missing

Use the closest existing token, then tell the person which token seems to be missing and why. The design system owner decides whether it is added to the core. Never add tokens inside `.core/`.

## The check

`raw-colors` flags hard-coded colours in `site/`. In the prototype profile it warns. In stricter profiles it blocks.
