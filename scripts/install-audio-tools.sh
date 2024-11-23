#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 30 October 2024
# Purpose : Install audio tools
set -e

et-log "Installing audio tools..."

apt install \
  audacity \
  ffmpeg \
  sox \
  -y
