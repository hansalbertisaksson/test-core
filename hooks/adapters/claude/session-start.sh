#!/usr/bin/env bash
# Claude Code SessionStart hook. Whatever this prints is added to Claude's context.
# A new project gets the kickoff conversation, an existing one gets its brief.
dir="$(dirname "${BASH_SOURCE[0]}")"
cd "${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel)}" || exit 0
if [ "$("$dir/brief-status.sh")" = "missing" ]; then
  cat <<'MSG'
Build Kit: this is a new prototype and docs/brief.md is not filled in yet.
Before building anything, follow the kickoff skill in .core/skills/kickoff/SKILL.md:
greet the person, say you'll ask a few quick questions first, and ask them one at a time.
Files in site/ are locked until the brief is written.
MSG
else
  echo "Build Kit: the brief for this prototype (docs/brief.md):"
  cat docs/brief.md
fi
exit 0
