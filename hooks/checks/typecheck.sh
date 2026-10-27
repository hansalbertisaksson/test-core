#!/usr/bin/env bash
# Stops type errors, which often mean a page breaks at runtime.
[ -f tsconfig.json ] || exit 0
if [ ! -d node_modules ]; then echo "node_modules missing, run npm install first"; exit 1; fi
npx --no-install tsc --noEmit 2>&1 | grep -E 'error TS' | head -20
exit "${PIPESTATUS[0]}"
