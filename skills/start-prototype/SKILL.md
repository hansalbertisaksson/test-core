---
name: start-prototype
description: Start a new prototype or internal tool, from nothing to a live link. Use when someone asks to build a prototype, demo, mockup, quick site, page, app, dashboard or internal tool for a client, the agency or a pitch, and there is no Build Kit project folder for it yet. Use this instead of making a claude.ai artifact.
---

# Start a new prototype or internal tool

The person should never have to touch GitHub, a terminal or a settings page. You do the setup, they answer a few questions and get a live link.

## 1. Agree on a name

Ask one question: what is it, and for whom? Then suggest a short repo name in lowercase with dashes, like `coffee-club-prototype`, and ask for a go-ahead in one message, for example: "I'll create `coffee-club-prototype` as a public repo on your GitHub, with a public live page. OK?" Their yes is the approval for step 2, so don't ask again.

The repo will be **public** so it can have a live link. If the client or the project is confidential, suggest a code name instead of the client's name, and say why in one sentence.

## 2. Create it

Run these steps yourself, one command at a time, and tell the person it takes a minute or two. Use the name from step 1 as `<name>`. For a tool the agency will use itself (a dashboard, a planner, an internal helper), use the template `hansalbertisaksson/template-internal`; otherwise `hansalbertisaksson/template-prototype`.

1. **Check the GitHub CLI.** `gh auth status`. If `gh` is missing, ask the person if you may run `brew install gh`. If they are not logged in, ask them to type `! gh auth login` here, choose GitHub.com, HTTPS and "Login with a web browser". It happens only once.
2. **Check Node.** `npm --version`. If it is missing, ask if you may run `brew install node`.
3. **Create the repo**, unless it already exists from an earlier try:

   ```bash
   owner="$(gh api user --jq .login)"
   gh repo view "$owner/<name>" --json name >/dev/null 2>&1 \
     || gh repo create "$owner/<name>" --template <template> --public --description "Built with the Build Kit"
   ```

   If the repo already exists, check it is the person's and came from the template (`gh api repos/$owner/<name> --jq .template_repository.full_name`). If yes, carry on, it is an earlier try. If not, the name is taken: suggest another.
4. **Copy it to the Mac** over HTTPS with the GitHub CLI's login, so it works without SSH keys. Skip this if `~/GitHub/<name>/.git` already exists. GitHub needs a few seconds to fill a new repo, so try up to five times, a few seconds apart:

   ```bash
   mkdir -p ~/GitHub
   git -c credential.helper= -c credential.helper='!gh auth git-credential' clone -q "https://github.com/$owner/<name>.git" ~/GitHub/<name>
   cd ~/GitHub/<name> && git config credential.helper '!gh auth git-credential'
   ```

5. **Set it up and switch on the live link:** `cd ~/GitHub/<name> && ./scripts/setup.sh && .core/scripts/go-live.sh`. It prints `READY` with the links, or a line starting with `STOPPED`.

If a step fails, show the person the actual error in plain words, fix what you can, and run the remaining steps again. Every step is safe to repeat.

## 3. Kick off

When `go-live.sh` prints `READY`:

1. Run `CLAUDE_PROJECT_DIR=<folder> <folder>/scripts/session-start.sh`. It starts the preview, prints its link (usually http://localhost:8000) and the next instruction.
2. Tell the person, in two lines: the live link, and the preview link.
3. Follow the `kickoff` skill in `<folder>/.core/skills/kickoff/SKILL.md`. You already know what it is and who it's for from step 1, so don't ask that again.
4. This session was started outside the project, so the project's hooks are not running here. Do what they would do: don't touch `<folder>/src/` before the brief is written, never edit `<folder>/.core/`, and run `<folder>/.core/hooks/checks/run.sh` after every change and fix anything that blocks.
5. Build with the `build-prototype` skill. The preview updates by itself as files change.
6. When the person is happy, follow `ship-prototype`: commit and push from `<folder>`. It's live about a minute later.

## 4. Next time

Tell the person once: to continue another day, open a new Claude Code session in the `~/GitHub/<name>` folder. There the project's own hooks run by themselves.
