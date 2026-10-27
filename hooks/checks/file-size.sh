#!/usr/bin/env bash
# Stops files over 5 MB from being committed. Large media belongs in a shared drive or a CDN.
limit=$((5 * 1024 * 1024))
found=0
while read -r f; do
  [ -z "$f" ] && continue
  size=$(wc -c < "$f" | tr -d ' ')
  if [ "$size" -gt "$limit" ]; then
    echo "$f: $((size / 1024 / 1024)) MB is over the 5 MB limit"
    found=1
  fi
done <<< "$FILES"
exit $found
