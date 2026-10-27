#!/usr/bin/env bash
# Looks for Swedish and Norwegian personal identity numbers.
# Prototypes use fake sample data only.
pattern='\b(19|20)?[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])[-+][0-9]{4}\b|\b(0[1-9]|[12][0-9]|3[01])(0[1-9]|1[0-2])[0-9]{2} ?[0-9]{5}\b'
found=0
while read -r f; do
  [ -z "$f" ] && continue
  if grep -I -n -E "$pattern" "$f" >/dev/null 2>&1; then
    grep -I -n -E "$pattern" "$f" | cut -d: -f1 | sed "s|^|$f:|; s|$|: looks like a personal identity number|"
    found=1
  fi
done <<< "$FILES"
exit $found
