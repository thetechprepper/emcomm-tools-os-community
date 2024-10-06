#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 March 2024
# Updated : 4 October 2024
# Purpose : Install base tools
set -e

et-log "Installing environment variables"
grep ET_TEMP_DIR /etc/environment
if [ $? -ne 0 ]; then
  echo "ET_TEMP_DIR=/tmp/et" >> /etc/environment
fi

grep ET_LOG_FILE /etc/environment
if [ $? -ne 0 ]; then
  echo "ET_LOG_FILE=/tmp/et/et.log" >> /etc/environment
fi

et-log "Installing message of the day
cp -v ../overlay/etc/motd /etc/

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
  xsel \
  tree \
  -y
