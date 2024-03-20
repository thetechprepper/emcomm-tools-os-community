#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 March 2024 
# Purpose : Install light weight web browser

et-log "Installing Brave web browser"

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

