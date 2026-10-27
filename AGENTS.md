# House rules

These rules apply to every project built on this core. They are read by Claude, GitHub Copilot and any other agent that follows AGENTS.md. The project's own `AGENTS.md` adds to these and wins where the two differ.

## How we build

1. Start from the brief in `docs/brief.md`. If it says it is not filled in yet, run the `kickoff` skill first: ask its questions one at a time and write the answers there before building anything.
2. Build from the design system. Use the CSS variables in `.core/design/tokens.css` for colour, type, spacing and radius. Never hard-code a colour or font. If a token is missing, say so and use the closest one.
3. A prototype is a rough first draft for designers to take further. Keep it simple, readable and easy to change. Plain HTML, CSS and a little JavaScript are enough unless the brief says otherwise.
4. Put everything that ships in `site/`. That folder is what gets published.
5. Record any decision worth remembering in `docs/decisions.md`, with one line on why.

## What you never do

- Never edit anything inside `.core/`. It is shared and read-only. Suggest the change instead.
- Never commit secrets, API keys, tokens or passwords. Use environment variables and say which ones are needed.
- Never use real personal data such as names, emails, phone numbers or personal identity numbers. Use clearly fake sample data.
- Never add tracking, analytics or third-party scripts without it being written in the brief.
- Never turn off or work around a check. If a check fails, fix the cause or explain why it is wrong.

## Checks

Run `.core/hooks/checks/run.sh` to check the project. The same checks run in git pre-commit, after Claude edits a file, and in CI. CI is the one that counts.

## Skills

Skills live in `.core/skills/`. Use them when the task matches:

- `start-prototype` for creating a brand new prototype, from nothing to a live link
- `kickoff` for starting a new prototype and writing the brief
- `build-prototype` for building or changing a page
- `use-design-tokens` for anything visual
- `ship-prototype` for publishing and sharing the live link
