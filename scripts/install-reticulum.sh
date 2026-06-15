#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 13 February 2026
# Updated : 15 June 2026
# Purpose : Install Reticulum

# Version pin Reticulum as we want to favor stability
# above all other concerns (security, features, etc.).
RNS_VERSION=1.2.5
# WARNING: 1.3.5 does not work with MeshChat
#RNS_VERSION=1.3.5

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

et-log "Removing wheelhouse to save space..."
[[ -e wheelhouse ]] && rm -vrf wheelhouse
