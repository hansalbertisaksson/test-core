#!/usr/bin/env bash
# Stops dependencies with known high or critical security issues from shipping.
[ -f package-lock.json ] || exit 0
# On commit, only when the dependencies changed. It needs the network.
if [ -n "${BUILDKIT_STAGED:-}" ] && ! printf '%s\n' "$FILES" | grep -qx 'package-lock.json'; then exit 0; fi
out="$(npm audit --omit=dev --audit-level=high 2>&1)" && exit 0
printf '%s\n' "$out" | grep -E '^[a-z@].*  |Severity|vulnerabilit' | head -15
echo "run npm audit fix, or upgrade the package that is listed"
exit 1
