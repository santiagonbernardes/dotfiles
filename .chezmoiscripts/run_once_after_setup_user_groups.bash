#!/usr/bin/env bash

sudo usermod -aG input "$USER"
sudo usermod -aG docker "$USER"
sudo usermod -aG libvirt,libvirt-qemu "$USER"
