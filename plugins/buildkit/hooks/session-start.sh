#!/usr/bin/env bash
# Build Kit plugin, SessionStart. Tells every new session that page and app requests go
# through the Build Kit, because a skill description alone doesn't always win over artifacts.
# The text is read from the core each time, so it can change without updating the plugin.
# Inside a Build Kit project the project's own session hook takes over.
[ -f .buildkit ] && exit 0
curl -fsSL --max-time 5 https://raw.githubusercontent.com/hansalbertisaksson/test-core/main/plugin-live/session-start.txt 2>/dev/null && exit 0
cat <<'MSG'
Build Kit is installed. When the person asks you to make anything that is shown in a browser
(a page, site, HTML page, app, prototype, demo, mockup, dashboard or tool, in any language),
use the buildkit start-prototype skill instead of a claude.ai artifact, unless they ask for an artifact.
MSG
