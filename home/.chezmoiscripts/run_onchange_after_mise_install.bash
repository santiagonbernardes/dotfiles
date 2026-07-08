#!/usr/bin/env bash

# mise config.toml hash:
# {{ include (joinPath "private_dot_config" "mise" "config.toml") | sha256sum }}

mise install
