#!/usr/bin/env bash
# Looks for API keys, tokens and private keys.
patterns='(AKIA[0-9A-Z]{16}|sk-[A-Za-z0-9_-]{20,}|gh[pousr]_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{30,}|xox[baprs]-[A-Za-z0-9-]{10,}|AIza[0-9A-Za-z_-]{35}|-----BEGIN [A-Z ]*PRIVATE KEY-----)'
found=0
while read -r f; do
  [ -z "$f" ] && continue
  case "$(basename "$f")" in
    .env.example) ;;
    .env|.env.*) echo "$f: .env files must not be committed"; found=1; continue ;;
  esac
  lines="$(grep -I -n -E "$patterns" "$f" 2>/dev/null | cut -d: -f1)"
  if [ -n "$lines" ]; then
    printf '%s\n' "$lines" | sed "s|^|$f:|; s|$|: looks like a secret|"
    found=1
  fi
done <<< "$FILES"
exit $found
