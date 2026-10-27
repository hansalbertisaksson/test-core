---
name: ship-client
description: Hand over a change in a client project as a pull request for review. Use when asked to ship, deliver, push or share work in a project whose .buildkit says profile=client.
---

# Ship a client change

1. Work on a branch, never on `main`: `git switch -c <short-description>`. The pre-push hook stops pushes to `main`.
2. Run `.core/hooks/checks/run.sh`. In the client profile every check blocks, so all of them must pass, including `typecheck`, `dependency-audit` and `licences`.
3. Commit with messages that say what changed for the client, not how.
4. Push the branch and open a pull request with `gh pr create`. In the description, write what changed, how to look at it, and anything the reviewer should check by hand (copy, accessibility, edge cases).
5. Tell the person the pull request link and who should review it, as named in `docs/brief.md`.
6. Never merge it yourself and never approve it. A person reviews and merges.
7. After the merge, CI builds the site on `main` and keeps it as a download on the run. Deploying it to the client's hosting follows the plan in `docs/brief.md`.

If a check fails in CI, read which one blocked and fix the cause. Never disable a check, and never move a project to a weaker profile to get it green.

## Updating the core

Client projects pin the core version. To take a newer core, run `./scripts/update-core.sh` on a branch, run the checks, and open a pull request that says which core changes it brings in.
