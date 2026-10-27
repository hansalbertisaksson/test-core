# test-core

The shared core of the Build Kit. Every project mounts it read-only at `/.core` as a git submodule, so all projects build from the same house rules, skills and checks. Prototypes are React apps built with [shadcn/ui](https://ui.shadcn.com) components.

## Add it to Claude once

In Claude Code (the Code tab in the desktop app, or `claude` in a terminal):

```
/plugin marketplace add hansalbertisaksson/test-core
/plugin install buildkit@buildkit
```

To get updates, turn on auto-update once: `/plugin`, Marketplaces, buildkit, Enable auto-update.

Then just say "I need a prototype for …". Claude creates the project, switches the live link on and asks a few kickoff questions. The first time it may ask you to log in to GitHub once.

## Or by hand

Start a new project from [template-prototype](https://github.com/hansalbertisaksson/template-prototype). You never edit this repo from inside a project. Changes to the core are made here and reach every project on its next update.

## What's inside

| Folder | What it holds |
| --- | --- |
| `AGENTS.md` | House rules that Claude, GitHub Copilot and other agents read |
| `skills/` | Step-by-step skills, one folder per skill with a `SKILL.md` |
| `hooks/checks/` | Plain shell checks (secrets, personal data, file size, raw colours, shadcn components) |
| `hooks/profiles/` | Which checks block and which only warn, per profile |
| `hooks/adapters/` | Git pre-commit, plus Claude hooks for kickoff, locking and checks |
| `.github/workflows/` | Reusable CI: `prototype.yml` publishes to GitHub Pages, `client.yml` checks and builds pinned client projects |
| `docs-template/` | The starting knowledge files for a new project |
| `kit/` | The "How this prototype is built" page every project publishes at `/kit/` |

## Profiles

`prototype` is for quick drafts with a public live link, see [template-prototype](https://github.com/hansalbertisaksson/template-prototype). `client` is for real deliveries, see `template-client`: every check blocks (including type errors, vulnerable dependencies and licences), `main` changes only through reviewed pull requests, the core version is pinned, and CI keeps the build as a download instead of publishing it. `internal` is for tools the agency uses itself, see `template-internal`: the same flow as a prototype, with a live link and the latest core, but type errors, vulnerable dependencies and design system drift block.

## The rule of thumb

Hard rules live in CI, because CI runs no matter which tool or person made the change. Local hooks are a convenience that catch problems earlier.

## The look

Prototypes use shadcn/ui's neutral theme, so they look like a draft and not like a finished brand. Each project changes its look in `src/index.css`. The `use-shadcn` skill holds the rules.
