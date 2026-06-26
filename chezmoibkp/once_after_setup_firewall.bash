#!/usr/bin/env bash

if ! command -v ufw-docker &>/dev/null; then
  ufw_docker_bin="https://raw.githubusercontent.com/chaifeng/ufw-docker/251123/ufw-docker"
  sudo curl "$ufw_docker_bin" -o /usr/local/bin/ufw-docker
  sudo chmod +x /usr/local/bin/ufw-docker
fi

sudo ufw enable

sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw route allow in on virbr0
sudo ufw route allow out on virbr0
sudo ufw allow in on virbr0

sudo ufw-docker install

sudo systemctl restart ufw.service
sudo systemctl enable \
  ufw.service
