#!/bin/bash
#
# Author  : William McKeehan
# Author  : Gaston Gonzalez
# Date    : 3 September 2025
# Updated : 10 December 2025
# Purpose : Install SDR++

# WARNING: SDR++ may get pulled altogether as this application's dependencies
# has a high risk of breaking the stability of the platform. DO NOT RELY ON
# SDR++ being here for much longer. I am testing this downgrade to an earlier
# version (1.0.4). The nightly build goes against the goals of EmComm Tools
# philosophy. Stability always wins over new and shinny.
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

APP=sdrpp
VERSION=nightly
DOWNLOAD_FILE=sdrpp_ubuntu_jammy_amd64.deb

et-log "Installing ${APP} ${VERSION}..."

if [[ ! -e ${ET_DIST_DIR}/${DOWNLOAD_FILE} ]]; then

  URL="https://github.com/AlexandreRouma/SDRPlusPlus/releases/download/${VERSION}/${DOWNLOAD_FILE}"

  download_with_retries ${URL} ${DOWNLOAD_FILE}
  mv ${DOWNLOAD_FILE} ${ET_DIST_DIR}
fi

DEBIAN_FRONTEND=noninteractive dpkg -i "${ET_DIST_DIR}/${DOWNLOAD_FILE}"

apt install -f -y
