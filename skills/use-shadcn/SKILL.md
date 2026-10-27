---
name: use-shadcn
description: Build every component with shadcn/ui and style with the theme. Use whenever adding or changing a component, a layout, colours, type or spacing.
---

# Use shadcn/ui

Prototypes use [shadcn/ui](https://ui.shadcn.com) for every component, styled with Tailwind and one theme. It looks neutral on purpose: a prototype shows the idea, and designers give it a look later by changing the theme, not the components.

1. Check `src/components/ui/` for the component you need. The template comes with button, card, badge, input, label, textarea, select, checkbox, switch, tabs, dialog, avatar, table, progress, separator and skeleton.
2. If it's missing, add it with `npx shadcn@latest add <name>` (for example `npx shadcn@latest add dropdown-menu sheet`). Look at the full list on ui.shadcn.com before building anything by hand.
3. Compose pages from these components. For whole sections such as a login, a dashboard or a sidebar, start from a shadcn block (`npx shadcn@latest add login-03`) and adapt it.
4. Import from `@/components/ui/<name>`. Icons come from `lucide-react`.
5. Style with Tailwind classes and the theme colours only: `bg-background`, `text-foreground`, `bg-primary`, `text-primary-foreground`, `bg-muted`, `text-muted-foreground`, `border`, `bg-card`, `text-destructive` and the other names in `src/index.css`.
6. Change the look in one place: the CSS variables in `src/index.css`. Record the change in `docs/decisions.md`.

## Rules

- Never write a plain `<button>`, `<input>`, `<select>`, `<textarea>`, `<dialog>` or `<table>` in a page. Use `Button`, `Input`, `Select`, `Textarea`, `Dialog` and `Table`.
- Never hand-make something shadcn has (cards, tabs, menus, sheets, toasts, tooltips). Add it instead.
- Prefer a component's own variants (`variant="outline"`, `size="sm"`) over extra classes.
- Never hard-code a colour: no hex, rgb, hsl or oklch values and no Tailwind palette classes like `bg-blue-500` or `text-zinc-600`. Use the theme names above.
- Use Tailwind's own spacing, type and radius steps (`p-6`, `gap-4`, `text-sm`, `rounded-lg`). No arbitrary values like `p-[13px]`.
- Leave the files in `src/components/ui/` as shadcn made them, unless a change is needed for the whole prototype. Then note it in `docs/decisions.md`.
- Layout: a centred column (`mx-auto max-w-5xl px-6`), generous spacing between sections, and responsive grids (`grid gap-4 sm:grid-cols-3`). It must work on a phone.
- Don't add fonts, other component libraries or CSS frameworks.

## The checks

`ui-components` flags plain buttons, inputs and other elements that should be shadcn components. `raw-colors` flags hard-coded colours. In the prototype profile both warn. In stricter profiles they block.
