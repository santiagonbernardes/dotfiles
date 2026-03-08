#!/usr/bin/env bash

sudo systemctl enable \
  power-profiles-daemon.service \
  docker.service

systemctl --user enable \
  pipewire.service \
  pipewire-pulse.service \
  wireplumber.service \
  playerctld.service \
  waybar.service \
  hyprpaper.service \
  hypridle.service \
  hyprpolkitagent.service \
  spotify.service
