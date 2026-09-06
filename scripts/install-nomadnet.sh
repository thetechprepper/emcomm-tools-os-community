#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 5 September 2026
# Purpose : Install NomadNet
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

APP=nomadnet
VERSION=1.2.0

et-log "Downloading ${APP} ${VERSION} for offline install..."
python3 -m pip download -d wheelhouse ${APP}==${VERSION}

et-log "Installing ${APP} ${RNS_VERSION} for single user use..."
PYTHONUSERBASE=/etc/skel/.local \
  python3 -m pip install --user \
  --no-index --find-links=wheelhouse \
  ${APP}==${VERSION}
