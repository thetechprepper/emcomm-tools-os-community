#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 16 October 2026
# Purpose : Install partyline for Reticulum
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

APP=partyline
VERSION=1.0.5
PYTHON="/opt/python/bin/python3.11"

et-log "Downloading ${APP} ${VERSION} for offline install..."
"${PYTHON}" -m pip download \
  -d wheelhouse \
  "${APP}==${VERSION}"

et-log "Installing ${APP} ${VERSION} for single user use..."
PYTHONUSERBASE=/etc/skel/.local \
  "${PYTHON}" -m pip install --user \
  --no-index --find-links=wheelhouse \
  "${APP}==${VERSION}"

cp -v ../overlay/usr/share/applications/partyline.desktop /usr/share/applications
