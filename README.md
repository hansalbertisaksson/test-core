# test-core

The shared core of the Build Kit. Every project mounts it read-only at `/.core` as a git submodule, so all projects build from the same house rules, design tokens, skills and checks.

## Add it to Claude once

In Claude Code (the Code tab in the desktop app, or `claude` in a terminal):

```
/plugin marketplace add hansalbertisaksson/test-core
/plugin install buildkit@buildkit
```

Then just say "I need a prototype for …". Claude creates the project, switches the live link on and asks a few kickoff questions. The first time it may ask you to log in to GitHub once.

## Or by hand

Start a new project from [template-prototype](https://github.com/hansalbertisaksson/template-prototype). You never edit this repo from inside a project. Changes to the core are made here and reach every project on its next update.

## What's inside

| Folder | What it holds |
| --- | --- |
| `AGENTS.md` | House rules that Claude, GitHub Copilot and other agents read |
| `design/` | Design tokens (`tokens.json`) exported to CSS variables (`tokens.css`) |
| `skills/` | Step-by-step skills, one folder per skill with a `SKILL.md` |
| `hooks/checks/` | Plain shell checks (secrets, personal data, file size, raw colours) |
| `hooks/profiles/` | Which checks block and which only warn, per profile |
| `hooks/adapters/` | Git pre-commit, plus Claude hooks for kickoff, locking and checks |
| `.github/workflows/` | Reusable CI that runs the checks and deploys to GitHub Pages |
| `docs-template/` | The starting knowledge files for a new project |
| `kit/` | The "How this prototype is built" page every project publishes at `/kit/` |

## Profiles

Only `prototype` is in use so far. `internal` and `client` are sketched in `hooks/profiles/` and get stricter as the risk goes up.

## The rule of thumb

Hard rules live in CI, because CI runs no matter which tool or person made the change. Local hooks are a convenience that catch problems earlier.

## Changing tokens

Edit `design/tokens.json`, then run `node scripts/build-tokens.mjs` to regenerate `design/tokens.css`. Commit both.
