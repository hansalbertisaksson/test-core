#!/usr/bin/env bash
# Claude Code PreToolUse hook for Write and Edit.
# Keeps the app (src/, index.html, or site/ in older projects) locked until the brief exists,
# and keeps .core/ read-only.
# Exit code 2 blocks the edit and tells Claude why.
dir="$(dirname "${BASH_SOURCE[0]}")"
project="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel)}"
file="$(python3 -c 'import json,sys; print(json.load(sys.stdin).get("tool_input",{}).get("file_path",""))' 2>/dev/null)"
rel="${file#"$project"/}"

case "$rel" in
  .core/*)
    echo "Build Kit: .core/ is the shared core and read-only. Suggest the change instead of making it." >&2
    exit 2 ;;
  src/*|index.html|site/*)
    status="$("$dir/brief-status.sh")"
    if [ "$status" = "profile" ]; then
      echo "Build Kit: nobody has said who this is for yet, so the pages are locked. Ask once: is it just for you, a tool for the agency, or for a client? Set profile= in .buildkit as in .core/AGENTS.md, then run the kickoff skill." >&2
      exit 2
    fi
    if [ "$status" = "missing" ]; then
      echo "Build Kit: the brief is not written yet, so the pages are locked. Run the kickoff skill (.core/skills/kickoff/SKILL.md) and ask the questions first." >&2
      exit 2
    fi ;;
esac
exit 0
