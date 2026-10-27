---
name: use-design-tokens
description: Style anything visual with the shared design tokens. Use whenever writing or changing CSS, colours, fonts, spacing or layout.
---

# Use the design tokens

The design system lives in `.core/design/`. `tokens.css` holds the values as CSS variables, and `base.css` styles plain elements and the building blocks below.

The look is Doberman's design language, not a copy of doberman.co. Don't recreate the website's navigation, corner texts or case-study naming. Type does the work: one grotesk at one weight, one huge centred uppercase display line, sentence case everywhere else, calm grids. No boxes, shadows or filled buttons. Black by default; `class="theme-light"` on `<body>` gives the white case-study look. Yellow, violet and blush appear only as image or tile colour, never as UI chrome. Hover and the current page are shown in italics.

## The type system

- Scale: major third (1.25) from a 1rem body: `--size-sm` 0.8, `md` 1, `lg` 1.25, `xl` 1.56, `2xl` 1.95, `3xl` 2.44, `4xl` 3.82, `display` up to 7.45rem. From `xl` up the sizes are fluid, one step smaller on phones, so they need no media queries.
- Leading goes with its size, always as a pair: `font-size: var(--size-lg); line-height: var(--leading-lg);`. It tightens as size grows (1.5 for body, 0.95 for display).
- Rhythm: one body line (`--space-unit`, 1.5rem) is the unit. Space is in lines: `--space-xs` 1/4, `sm` 1/2, `md` 1, `lg` 2, `xl` 3, `2xl` 4, `3xl` 6. Heading to its text `sm`, paragraph to paragraph `md`, block to block `lg`, section to section `2xl` (`.page` already does this).
- Measure: body text max `--measure-body` (65ch), lead text max `--measure-lead` (40ch).
- Numbers in tables, dates and meta use tabular figures (`table`, `time` and `.num` get them).

## Where caps are allowed

Only two places: the `.display` line, and `.label` (small eyebrows above a title, table heads, meta keys). `.label` already sets `--size-sm` and `--tracking-caps`; never set caps without that tracking. Navigation, headings, captions, buttons, pills, table cells and list items are sentence case. Never use `text-transform: uppercase` anywhere else. Text from data (slugs like `file-size`) gets a capital first letter with `::first-letter`, not caps.

## Which class for which level

| Level | Use | Size |
| --- | --- | --- |
| Display, opens the page | `.display` inside `.display-section` | display, caps |
| Page title | `.title` | 4xl |
| Section heading | `h2` as first child of `.split`, or `.heading` | 3xl |
| Sub-heading | `h3` / `.subheading` | lg |
| Lead text | `.lede`, or a `p` directly in `.split` | xl |
| Body | plain `p`, `li`; add `.body` for the measure | md |
| Small / meta | `.small`; captions use `.tile-caption` (md) | sm |
| Label | `.label` | sm, caps |

## Building blocks in base.css

- `.site-nav`: top bar, project name left, a `.site-nav-links` group right, sentence case. Mark the current page with `.is-current`.
- `.display-section` with `.display`: a full-height section with one huge centred line, the way pages open. One per page.
- `.page`: the content wrapper with the page margin; its sections sit four lines apart.
- `.split`: section heading on the left, text from the middle, sharing a first baseline. Put a `.lede` first in the right column; anything after it starts two lines lower. Stacks on phones.
- `.tiles` (3 columns) or `.tiles.four`, each `.tile` with a `.tile-media` and a sentence-case `.tile-caption`.
- `.pill` / `.button` for tags and buttons (outlined, small, sentence case), `.arrow-link`, `.rule`, `.muted`.

## Rules

- Colours: only `var(--color-*)`. Never write a hex, rgb or hsl value in project CSS or HTML.
- Fonts: only `var(--font-sans)`, `var(--font-display)` and `var(--font-mono)`, at weight 400. Never add font files: Gerstner-Programm is licensed and used only where it's installed.
- Font sizes: only the `--size-*` steps, each with its matching `--leading-*`. No in-between sizes.
- Letter spacing: `var(--tracking-caps)` for caps labels, `var(--tracking-tight)` for `xl` and up, `var(--tracking-display)` only on the display line, otherwise none.
- Spacing: only the `--space-*` line steps (plus `--space-page` and `--space-edge` for page margins). Do not invent in-between values.
- Corners: `var(--radius-sm|md|lg|pill)`. They are square on purpose. Only use `pill` for small round marks.
- Reuse the building blocks above before writing new components. Don't add cards with borders or filled buttons, they are not part of this look.

## When a token is missing

Use the closest existing token, then tell the person which token seems to be missing and why. The design system owner decides whether it is added to the core. Never add tokens inside `.core/`.

## The check

`raw-colors` flags hard-coded colours in `site/`. In the prototype profile it warns. In stricter profiles it blocks.
