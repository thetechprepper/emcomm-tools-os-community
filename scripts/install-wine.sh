#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 20 January 2025
# Updated : 18 March 2025
# Purpose : Install WINE to support VARA

WIN32_DIR="${HOME}/.win32"

et-log "Installing WINE..."

# Check for an existing i386 architecture
ARCH_OUT=$(dpkg --print-foreign-architectures | grep i386)
[ $? -ne 0 ] && dpkg --add-architecture i386

#if [ ! -e "/etc/apt/keyrings/winehq-archive.key" ]; then
#  et-log "Adding apt keys for official wine repo"
#  mkdir -pm755 /etc/apt/keyrings
#  wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
#  wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/$(lsb_release -sc)/winehq-$(lsb_release -sc).sources
#  apt update
# apt install --install-recommends winehq-stable
#fi

apt install \
  wine \
  winetricks \
  exe-thumbnailer \
  -y

# Only show the directions for including WINE in the image to advanced users
if [[ ! -z "${ET_EXPERT}" ]]; then
  dialog --erase-on-exit --stdout --textbox wine.txt 15 74
fi
