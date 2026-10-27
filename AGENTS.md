# House rules

These rules apply to every project built on this core. They are read by Claude, GitHub Copilot and any other agent that follows AGENTS.md. The project's own `AGENTS.md` adds to these and wins where the two differ.

## How we build

1. Start from the brief in `docs/brief.md`. If it says it is not filled in yet, run the `kickoff` skill first: ask its questions one at a time and write the answers there before building anything.
2. Build every component with shadcn/ui. Use what is in `src/components/ui/`, add missing ones with `npx shadcn@latest add <name>`, and never hand-make a button, input, card or dialog. Style with Tailwind and the theme colours (`bg-primary`, `text-muted-foreground`), never hard-coded colours. Follow the `use-shadcn` skill.
3. A prototype is a rough first draft for designers to take further. Keep it simple, readable and easy to change: React, Vite, Tailwind and shadcn/ui, nothing more unless the brief asks for it.
4. The app lives in `src/`. The build publishes it, so whatever is in `src/` is what people see.
5. Record any decision worth remembering in `docs/decisions.md`, with one line on why.

## What you never do

- Never edit anything inside `.core/`. It is shared and read-only. Suggest the change instead.
- Never commit secrets, API keys, tokens or passwords. Use environment variables and say which ones are needed.
- Never use real personal data such as names, emails, phone numbers or personal identity numbers. Use clearly fake sample data.
- Never add tracking, analytics or third-party scripts without it being written in the brief.
- Never turn off or work around a check. If a check fails, fix the cause or explain why it is wrong.

## Internal tools

When `.buildkit` says `profile=internal`, the tool is for the agency itself. Type errors, vulnerable dependencies and design drift block. Its live link is public, so it uses fake data until it has private hosting.

## Client projects

When `.buildkit` says `profile=client`, these apply on top:

- Every check blocks. Never move a project to a weaker profile.
- Change `main` only through a pull request that a person reviews. Never merge or approve yourself.
- The core version is pinned. Update it on purpose with `./scripts/update-core.sh`, in its own pull request.
- Client data and credentials never go in the repo, not even as samples. Use fake data and the client's own secret store.

## Checks

Run `.core/hooks/checks/run.sh` to check the project. The same checks run in git pre-commit, after Claude edits a file, and in CI. CI is the one that counts.

## Skills

Skills live in `.core/skills/`. Use them when the task matches:

- `start-prototype` for creating a brand new prototype, from nothing to a live link
- `kickoff` for starting a new prototype and writing the brief
- `build-prototype` for building or changing a page
- `use-shadcn` for any component, layout or styling
- `ship-prototype` for publishing and sharing the live link
- `start-client` for setting up a new client project
- `ship-client` for handing over a client change as a pull request
