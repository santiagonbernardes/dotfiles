#!/usr/bin/env bash

module="btusb"
if ! lsmod | grep -q "^${module}"; then
  sudo modprobe "${module}"
fi

sudo systemctl enable \
  bluetooth.service
