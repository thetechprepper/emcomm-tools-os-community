#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 5 September 2026
# Updated : 16 October 2026
# Purpose : Install NomadNet
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

APP=nomadnet
VERSION=1.2.0
PYTHON="/opt/python/bin/python3.11"

et-log "Downloading ${APP} ${VERSION} for offline install..."
"${PYTHON}" -m pip download -d wheelhouse ${APP}==${VERSION}

et-log "Installing ${APP} ${VERSION} for single user use..."
PYTHONUSERBASE=/etc/skel/.local \
  "${PYTHON}" -m pip install --user \
  --no-index --find-links=wheelhouse \
  ${APP}==${VERSION}
