#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 March 2024
# Updated : 6 October 2024
# Purpose : Install base tools and configuration
set -e

et-log "Installing environment variables..."
cp -v ../overlay/etc/environment /etc/

et-log "Installing message of the day..."
cp -v ../overlay/etc/motd /etc/

et-log "Installing base packages..."

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
  xsel \
  tree \
  -y
