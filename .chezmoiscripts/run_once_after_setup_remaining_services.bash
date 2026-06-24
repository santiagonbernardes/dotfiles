#!/usr/bin/env bash

sudo systemctl enable \
  docker.service

systemctl --user enable \
  spotify.service
