---
name: build-prototype
description: Build or change a page in a Build Kit prototype. Use when asked to make, sketch or change anything that will be shown in the browser.
---

# Build a prototype page

1. Read `docs/brief.md`. If it is not filled in yet, run the `kickoff` skill first.
2. The app is React with Vite, Tailwind and shadcn/ui. `src/App.tsx` is the start page. Put more pages in `src/pages/<Name>.tsx` and switch between them with simple state or `#hash` links. Add a router only if the brief needs real URLs.
3. Build every component with shadcn/ui and style with the theme. Follow the `use-shadcn` skill.
4. Keep it one simple draft: fake data in a `src/data.ts` file, no backend, no login that really works.
5. Use fake sample content. No real names, emails or other personal data.
6. Preview at http://localhost:8000. Opening the project in Claude Code starts it, or run `npm run dev`. It updates as you save.
7. Run `npm run typecheck` and `.core/hooks/checks/run.sh`, and fix anything that blocks.
8. Add a line to `docs/decisions.md` for any choice a designer would want to know about.
