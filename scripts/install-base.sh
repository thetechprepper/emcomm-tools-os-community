#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 March 2024
# Updated : 28 February 2025
# Purpose : Install base tools and configuration
set -e

et-log "Installing base packages..."

apt install \
  build-essential \
  cmake \
  curl \
  gpg \
  imagemagick \
  jq \
  moreutils \
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

et-log "Installing environment variables..."
# TODO Can enviornment varialbes also be set in profile.d?
cat <(grep -vE '^ET_' /etc/environment) ../overlay/etc/environment | sponge /etc/environment
cp -v ../overlay/etc/profile.d/emcomm-tools.sh /etc/profile.d/

et-log "Installing message of the day..."
cp -v ../overlay/etc/motd /etc/
