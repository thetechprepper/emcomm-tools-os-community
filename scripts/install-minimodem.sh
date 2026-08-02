#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 15 February 2025
# Purpose : Install minimodem
set -e

APP=minimodem
et-log "Installing ${APP}..."

apt install \
  minimodem \
  -y
