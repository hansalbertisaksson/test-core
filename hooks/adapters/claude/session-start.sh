#!/usr/bin/env bash
# Claude Code SessionStart hook. Whatever this prints is added to Claude's context.
# A new project gets the kickoff conversation, an existing one gets its brief.
dir="$(dirname "${BASH_SOURCE[0]}")"
cd "${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel)}" || exit 0
status="$("$dir/brief-status.sh")"
if [ "$status" = "profile" ]; then
  cat <<'MSG'
Build Kit: this is a new project and nobody has said who it is for yet (.buildkit says profile=unset).
Before anything else, even for a tiny request, ask once: is it just for you, a tool for the agency, or for a client?
Never guess it from the request. Set profile= in .buildkit as described under "Choosing the profile" in .core/AGENTS.md,
then follow the kickoff skill in .core/skills/kickoff/SKILL.md. The pages in src/ are locked until both are done.
MSG
elif [ "$status" = "missing" ]; then
  cat <<'MSG'
Build Kit: this is a new prototype and docs/brief.md is not filled in yet.
Before building anything, follow the kickoff skill in .core/skills/kickoff/SKILL.md:
greet the person, say you'll ask a few quick questions first, and ask them one at a time.
The pages in src/ are locked until the brief is written.
MSG
else
  echo "Build Kit: the brief for this prototype (docs/brief.md):"
  cat docs/brief.md
fi
exit 0
