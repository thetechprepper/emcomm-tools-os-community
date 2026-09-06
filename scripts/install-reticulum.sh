#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 13 February 2026
# Updated : 5 September 2026
# Purpose : Install Reticulum
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

RNS_VERSION=1.5.1

et-log "Installing Python3..."
apt install \
  python3 \
  python3-pip \
  -y

et-log "Downloading rns ${RNS_VERSION} for offline install..."
python3 -m pip download -d wheelhouse rns==${RNS_VERSION}

et-log "Installing Reticulum ${RNS_VERSION} for single user use..."
PYTHONUSERBASE=/etc/skel/.local \
  python3 -m pip install --user \
  --no-index --find-links=wheelhouse \
  rns==${RNS_VERSION}
