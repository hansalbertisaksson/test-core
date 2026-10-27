#!/usr/bin/env bash
# Claude Code PreToolUse hook for Write and Edit.
# Keeps site/ locked until the brief exists, and keeps .core/ read-only.
# Exit code 2 blocks the edit and tells Claude why.
dir="$(dirname "${BASH_SOURCE[0]}")"
project="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel)}"
file="$(python3 -c 'import json,sys; print(json.load(sys.stdin).get("tool_input",{}).get("file_path",""))' 2>/dev/null)"
rel="${file#"$project"/}"

case "$rel" in
  .core/*)
    echo "Build Kit: .core/ is the shared core and read-only. Suggest the change instead of making it." >&2
    exit 2 ;;
  site/*)
    if [ "$("$dir/brief-status.sh")" = "missing" ]; then
      echo "Build Kit: the brief is not written yet, so site/ is locked. Run the kickoff skill (.core/skills/kickoff/SKILL.md) and ask the questions first." >&2
      exit 2
    fi ;;
esac
exit 0
