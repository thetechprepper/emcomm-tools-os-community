#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 March 2024
# Purpose : Install base tools
set -e

et-log "Installing base packages"
apt install \
  build-essential \
  cmake \
  curl \
  gpg \
  jq \
  net-tools \
  openjdk-11-jdk \
  openssh-server \
  screen \
  stow \
  tree \
  -y
