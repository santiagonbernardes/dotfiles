#!/usr/bin/env bash

declare -A plugins=(
  ["yazi-rs/plugins:git"]="git.yazi"
  ["yazi-rs/plugins:jump-to-char"]="jump-to-char.yazi"
  ["yazi-rs/plugins:mount"]="mount-yazi"
)

for plugin in "${!plugins[@]}"; do
  plugin_folder="${plugins[$plugin]}"

  if ! [[ -d "$HOME/.config/yazi/plugins/$plugin_folder" ]]; then
    ya pkg add "$plugin"
  fi
done
