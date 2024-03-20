#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 March 2024
# Purpose : Minimal install of image build tools for Ubuntu
set -e

. ./env.sh
. ./functions.sh

exitIfNotRoot

./bootstrap.sh
./update-apt.sh

et-log "Installing tools for building custom ISO image"
if ! command -v cubic
then
  sudo apt-add-repository universe -y
  sudo apt-add-repository ppa:cubic-wizard/release -y
  sudo apt update
  sudo apt install --no-install-recommends cubic -y
fi
