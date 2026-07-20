#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 13 February 2026
# Updated : 19 July 2026
# Purpose : Install Reticulum

RNS_VERSION=1.3.9

et-log "Installing Python3..."
apt install \
  python3 \
  python3-pip \
  -y

et-log "Downloading rns ${RNS_VERSION} for offline install..."
python3 -m pip download -d wheelhouse rns==${RNS_VERSION}

#et-log "Downloading nomadnet for offline install..."
#python3 -m pip download -d wheelhouse

et-log "Installing Reticulum for single user use..."
PYTHONUSERBASE=/etc/skel/.local \
  python3 -m pip install --user \
  --no-index --find-links=wheelhouse \
  rns==${RNS_VERSION}

#et-log "Removing wheelhouse to save space..."
#[[ -e wheelhouse ]] && rm -vrf wheelhouse
