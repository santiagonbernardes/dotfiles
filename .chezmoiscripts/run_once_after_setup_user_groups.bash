#!/usr/bin/env bash

groups=(
  "libvirt"
  "libvirt-qemu"
  "input"
  "docker"
)

sudo usermod -aG "$(
  IFS=,
  echo "${groups[*]}"
)" "$USER"
