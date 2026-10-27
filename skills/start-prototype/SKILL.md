---
name: start-prototype
description: Start a brand new prototype from nothing to a live link. Use when someone says they need a prototype, a demo, a mockup or a quick site for a client, an idea or a pitch, and there is no project folder for it yet.
---

# Start a new prototype

The person should never have to touch GitHub, a terminal or a settings page. You do the setup, they answer a few questions and get a live link.

## 1. Agree on a name

Ask one question: what is it, and for whom? Then suggest a short repo name in lowercase with dashes, like `coffee-club-prototype`, and ask if it's fine.

The repo will be **public** so it can have a live link. If the client or the project is confidential, suggest a code name instead of the client's name, and say why in one sentence.

## 2. Create it

Run the script that sits next to this file:

```bash
bash "<this skill's folder>/new-prototype.sh" <name>
```

It creates the repo from the template, copies it to `~/GitHub/<name>`, fetches the shared core, waits for the first build and switches the live link on. It takes one to two minutes. Tell the person it's working on it.

If it stops:

- **GitHub CLI not installed:** ask the person if you may run `brew install gh`, then continue.
- **Not logged in:** ask the person to type `! gh auth login` here, choose GitHub.com, HTTPS and "Login with a web browser". It takes a minute and only happens once. Then run the script again.
- **Name taken:** suggest another name.
- Anything else: show the line that starts with `STOPPED` in plain words.

## 3. Kick off

When the script prints `READY`:

1. Run `CLAUDE_PROJECT_DIR=<folder> <folder>/scripts/session-start.sh`. It starts the preview at http://localhost:8000 and prints the next instruction.
2. Tell the person, in two lines: the live link, and the preview link.
3. From now on work inside `<folder>`. Read `<folder>/.core/AGENTS.md` and follow the `kickoff` skill: ask the questions one at a time and write `<folder>/docs/brief.md`.
4. Then build with the `build-prototype` skill, and rebuild the preview after changes with `<folder>/.core/scripts/build-site.sh`.
5. When the person is happy, follow `ship-prototype`: commit and push from `<folder>`. It's live about a minute later.

## 4. Next time

Tell the person once: to continue another day, open a new Claude Code session in `~/GitHub/<name>`. There the project's own hooks also run, so the checks happen after every edit.
