#!/usr/bin/env bash

groups=(
  "input"
)

sudo usermod -aG "$(
  IFS=,
  echo "${groups[*]}"
)" "$USER"
