#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 March 2024
# Updated : 28 February 2025
# Purpose : Install base tools and configuration
set -e

et-log "Installing environment variables..."
cp -v ../overlay/etc/environment /etc/
cp -v ../overlay/etc/profile.d/emcomm-tools.sh /etc/profile.d/

et-log "Installing message of the day..."
cp -v ../overlay/etc/motd /etc/

et-log "Installing base packages..."

apt install \
  build-essential \
  cmake \
  curl \
  gpg \
  imagemagick \
  jq \
  net-tools \
  openjdk-20-jdk \
  openssh-server \
  screen \
  socat \
  steghide \
  stow \
  xsel \
  tree \
  -y
