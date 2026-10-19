#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 13 February 2026
# Updated : 16 October 2026
# Purpose : Install Reticulum
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

APP=rns
VERSION=1.5.7
PYTHON="/opt/python/bin/python3.11"

et-log "Downloading ${APP} ${VERSION} for offline install..."
"${PYTHON}" -m pip download -d wheelhouse ${APP}==${VERSION}

et-log "Installing ${APP} ${VERSION} for single user use..."
PYTHONUSERBASE=/etc/skel/.local \
  "${PYTHON}" -m pip install --user \
  --no-index --find-links=wheelhouse \
  ${APP}==${VERSION}
