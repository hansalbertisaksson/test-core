#!/usr/bin/env bash
# Allows only dependency licences that are safe to hand over to a client (MIT, Apache, BSD and similar).
[ -f package.json ] || exit 0
if [ ! -d node_modules ]; then echo "node_modules missing, run npm install first"; exit 1; fi
npm ls --omit=dev --all --parseable 2>/dev/null | python3 "$(dirname "${BASH_SOURCE[0]}")/licences.py"
