---
name: build-prototype
description: Build or change a page in a Build Kit prototype. Use when asked to make, sketch or change anything that will be shown in the browser.
---

# Build a prototype page

1. Read `docs/brief.md`. If it is not filled in yet, run the `kickoff` skill first.
2. Work only in `site/`. `site/index.html` is the start page. Add more pages as `site/<name>.html` and link them from the start page.
3. Every page loads the shared design files first:

   ```html
   <link rel="stylesheet" href="core/tokens.css">
   <link rel="stylesheet" href="core/base.css">
   <link rel="stylesheet" href="styles.css">
   ```

   The build copies `.core/design/` to `site/core/` in the published site, so these paths work both locally and live.
4. Put project styles in `site/styles.css` and follow the `use-design-tokens` skill.
5. Use plain HTML, CSS and small amounts of JavaScript. Add a framework only if the brief asks for one.
6. Use fake sample content. No real names, emails or other personal data.
7. Preview with `./scripts/start.sh` and open http://localhost:8000.
8. Run `.core/hooks/checks/run.sh` and fix anything that blocks.
9. Add a line to `docs/decisions.md` for any choice a designer would want to know about.
