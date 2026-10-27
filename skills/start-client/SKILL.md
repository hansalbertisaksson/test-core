---
name: start-client
description: Set up a new client project from the client template. Use when someone needs a repo for real client work, a delivery or a production site, not a quick prototype.
---

# Start a client project

1. Ask one question: which client and what is the delivery? Suggest a repo name in lowercase with dashes, like `acme-booking`, and ask for a go-ahead in one message: "I'll create `acme-booking` as a private repo on your GitHub. OK?" Their yes is the approval for step 2.
2. Run the script next to the prototype skill with the client flag:

   ```bash
   bash "<the start-prototype skill's folder>/new-prototype.sh" --client <name>
   ```

   It creates a private repo from the client template, copies it to `~/GitHub/<name>`, and fetches the pinned core. There is no public live link.
3. When it prints `READY`, run `CLAUDE_PROJECT_DIR=<folder> <folder>/scripts/session-start.sh`, then follow the `kickoff` skill inside `<folder>`, including the client questions.
4. Build with `build-prototype` and `use-shadcn`. Hand over every change with `ship-client`.
5. Tell the person once: in GitHub, under Settings, Branches, protect `main` so it needs a review. On a free personal account this needs a public repo or a paid plan. Until then the pre-push hook and the house rules keep `main` behind pull requests.
