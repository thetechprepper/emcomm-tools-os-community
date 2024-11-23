#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 March 2024 
# Updated : 20 October 2024
# Purpose : Install light weight web browsers
#
# Postconditions:
# 1. Min browser installed
# 2. Brave brower installed

et-log "Installing Min web browser..."

VERSION="1.33.1"
FILE="min-${VERSION}-amd64.deb"
URL="https://github.com/minbrowser/min/releases/download/v${VERSION}/${FILE}"

if [ ! -e $ET_DIST_DIR/$FILE ]; then
  et-log "Downloading Min web browser: $URL"

  curl -s -L -O --fail $URL

  [ ! -e $ET_DIST_DIR ] && mkdir -v $ET_DIST_DIR

  mv -v $FILE $ET_DIST_DIR
else
  et-log "${FILE} already downloaded. Skipping..."
fi

et-log "Installing ${ET_DIST_DIR}/${FILE}..."
dpkg -i $ET_DIST_DIR/$FILE


et-log "Installing Brave web browser..."

INSTALL_PATH=$(which brave-browser)
if [ $? -ne 0 ]; then
  apt install apt-transport-https -y

  # Add Brave repository.
  curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

  apt update

  apt install brave-browser -y
else
  et-log "Brave already installed: $INSTALL_PATH. Skipping."
fi

