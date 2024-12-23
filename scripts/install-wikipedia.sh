#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 23 December 2024
# Purpose : Install offline tools for reading Wikipedia dumps
set -e

et-log "Installing tools for reading Wikipedia dumps..."

apt install \
  kiwix \
  kiwix-tools \
  zim \
  zim-tools \
  zimwriterfs \
  -y
