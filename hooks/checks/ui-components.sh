#!/usr/bin/env bash
# Flags hand-made buttons, inputs and dialogs so every component comes from shadcn/ui.
pattern='<(button|input|select|textarea|dialog|table)[ >/]'
found=0
while read -r f; do
  case "$f" in
    src/components/ui/*) continue ;;
    src/*.tsx|src/*.jsx|src/*/*.tsx|src/*/*.jsx|src/*/*/*.tsx|src/*/*/*.jsx) ;;
    *) continue ;;
  esac
  if grep -n -E "$pattern" "$f" >/dev/null 2>&1; then
    grep -n -E -o "$pattern" "$f" | sed -E "s|^([0-9]+):<([a-z]+).*|$f:\1: plain <\2>, use the shadcn/ui component instead (npx shadcn@latest add \2)|"
    found=1
  fi
done <<< "$FILES"
exit $found
