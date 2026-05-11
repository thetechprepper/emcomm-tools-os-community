#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 13 February 2026
# Updated : 11 May 2026
# Purpose : Install Reticulum

# Version pin Reticulum and Nomadnet as we want to favor stability
# above all other concerns (security, features, etc.).
RNS_VERSION=1.2.5
NOMADNET_VERSION=0.9.8

et-log "Installing Python3..."
apt install \
  python3 \
  python3-pip \
  -y

et-log "Downloading rns ${RNS_VERSION} for offline install..."
python3 -m pip download -d wheelhouse rns==${RNS_VERSION}

et-log "Downloading nomadnet ${NOMADNET_VERSION} for offline install..."
python3 -m pip download -d wheelhouse nomadnet==${NOMADNET_VERSION}

et-log "Installing Reticulum and Nomadnet for single user use..."
PYTHONUSERBASE=/etc/skel/.local \
  python3 -m pip install --user \
  --no-index --find-links=wheelhouse \
  rns==${RNS_VERSION} \
  nomadnet==${NOMADNET_VERSION}

et-log "Removing wheelhouse to save space..."
[[ -e wheelhouse ]] && rm -vrf wheelhouse
