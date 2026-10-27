---
name: ship-prototype
description: Publish a Build Kit prototype and share its live link. Use when asked to deploy, publish, ship or share the prototype.
---

# Ship the prototype

1. Run `.core/hooks/checks/run.sh`. Nothing may block.
2. Commit with a short message that says what changed for the person looking at it.
3. Push to `main`. CI runs the same checks, builds `site/` together with the shared design files and publishes it to GitHub Pages.
4. The live link is `https://<owner>.github.io/<repo>/`. The repo README shows it too.
5. Share the link together with one sentence on what to look at and what kind of feedback you want.

If CI fails, open the failed run in the Actions tab, read which check blocked and fix the cause. Never disable a check to get it green.

## First time only

If the very first deploy succeeds but the link shows a 404, open the repo's Settings, then Pages, and choose "Deploy from a branch" with the branch `gh-pages` and the folder `/ (root)`. It stays that way afterwards.
