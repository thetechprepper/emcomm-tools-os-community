#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 5 October 2022
# Purpose : Install Conky
set -e

et-log "Installing Conky..."
apt install \
  conky\
  -y
