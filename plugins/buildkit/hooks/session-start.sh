#!/usr/bin/env bash
# Build Kit plugin, SessionStart. Tells every new session that page and app requests go
# through the Build Kit, because a skill description alone doesn't always win over artifacts.
# Inside a Build Kit project the project's own session hook takes over.
[ -f .buildkit ] && exit 0
cat <<'MSG'
Build Kit is installed. When the person asks you to make anything that is shown in a browser
(a page, site, HTML page, app, prototype, demo, mockup, dashboard or tool, in any language,
for example "sida", "prototyp", "verktyg"), use the buildkit start-prototype skill.
Do not make a claude.ai artifact or a loose HTML file for it, unless the person explicitly
asks for an artifact. Start by asking who it is for: just them, a tool for the agency, or a client.
MSG
