#!/usr/bin/env bash

sudo systemctl enable \
  power-profiles-daemon.service \
  docker.service

systemctl --user enable \
  waybar.service \
  hyprpaper.service \
  hypridle.service \
  hyprpolkitagent.service \
  spotify.service
