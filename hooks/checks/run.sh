#!/usr/bin/env bash
# Runs the checks for this project's profile.
# Usage: run.sh [--staged]
#   --staged  check only files staged for commit (used by the git pre-commit hook)
# Exit code 1 means at least one blocking check failed.
set -uo pipefail

CHECKS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILES_DIR="$CHECKS_DIR/../profiles"
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$ROOT"

PROFILE="prototype"
if [ -f .buildkit ]; then
  PROFILE="$(sed -n 's/^profile=//p' .buildkit | head -1)"
fi
if [ "$PROFILE" = "unset" ]; then
  echo "Build Kit: no profile chosen yet, so the prototype checks run for now. Ask whether it's personal, internal or for a client."
  PROFILE="prototype"
fi
PROFILE_FILE="$PROFILES_DIR/$PROFILE.conf"
if [ ! -f "$PROFILE_FILE" ]; then
  echo "Unknown profile '$PROFILE' in .buildkit" >&2
  exit 1
fi

# The files to check, one per line. Never the shared core itself.
if [ "${1:-}" = "--staged" ]; then
  export BUILDKIT_STAGED=1
  FILES="$(git diff --cached --name-only --diff-filter=ACM)"
else
  FILES="$(git ls-files --cached --others --exclude-standard 2>/dev/null || find . -type f -not -path './.git/*')"
fi
FILES="$(printf '%s\n' "$FILES" | grep -v -e '^\.core/' -e '^\.core$' -e '^_site/' -e '^site/core/' | while read -r f; do [ -f "$f" ] && printf '%s\n' "$f"; done)"
export FILES

failed=0
echo "Build Kit checks, profile: $PROFILE"
while read -r mode check; do
  case "$mode" in ''|\#*) continue ;; esac
  output="$("$CHECKS_DIR/$check.sh" 2>&1)"
  status=$?
  # Optional machine-readable report, used by the build to show results on the kit page.
  if [ -n "${BUILDKIT_REPORT:-}" ]; then
    result="ok"; [ $status -ne 0 ] && result="$mode"
    printf '%s\t%s\t%s\t%s\n' "$check" "$mode" "$result" "$(printf '%s' "$output" | head -5 | tr '\n\t' '  ')" >> "$BUILDKIT_REPORT"
  fi
  if [ $status -eq 0 ]; then
    echo "  ok    $check"
  elif [ "$mode" = "block" ]; then
    echo "  FAIL  $check"
    printf '%s\n' "$output" | sed 's/^/        /'
    failed=1
  else
    echo "  warn  $check"
    printf '%s\n' "$output" | sed 's/^/        /'
  fi
done < "$PROFILE_FILE"

if [ $failed -ne 0 ]; then
  echo "A blocking check failed. Fix the cause, do not turn the check off." >&2
fi
exit $failed
