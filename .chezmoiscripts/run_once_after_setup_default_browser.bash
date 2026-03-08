#!/usr/bin/env bash

expected_browser="firefox.desktop"
current_browser="$(xdg-settings get default-web-browser 2>/dev/null || echo '')"
if [[ "$current_browser" != "$expected_browser" ]]; then
  xdg-settings set default-web-browser "$expected_browser" || true
fi
