#!/bin/bash
#
# Author  : William McKeehan
# Author  : Gaston Gonzalez
# Date    : 3 September 2025
# Updated : 6 March 2026
# Purpose : Install SDR++
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

APP=sdrpp
VERSION=nightly
DOWNLOAD_FILE=sdrpp_ubuntu_jammy_amd64.deb

et-log "****************************************************************"
et-log "* WARNING:                                                     *"
et-log "*                                                              *"
et-log "* SDR++ may get pulled at any time due to its nightly builds.  *"
et-log "* Since the nightly builds are not version pinned, the library *"
et-log "* dependencies may change and result in run-time issues or may *"
et-log "* lead to breakage impacting other parts of the system.        *"
et-log "****************************************************************"

et-log "Installing ${APP} ${VERSION}..."

et-log "Installing build dependencies..."
apt install \
  libvolk2-bin \
  libvolk2-dev \
  libfftw3-dev \
  libglfw3-dev \
  librtaudio-dev \
  libzstd-dev \
  -y

if [[ ! -e ${ET_DIST_DIR}/${DOWNLOAD_FILE} ]]; then

  URL="https://github.com/AlexandreRouma/SDRPlusPlus/releases/download/${VERSION}/${DOWNLOAD_FILE}"

  download_with_retries ${URL} ${DOWNLOAD_FILE}
  mv ${DOWNLOAD_FILE} ${ET_DIST_DIR}
fi

DEBIAN_FRONTEND=noninteractive dpkg -i "${ET_DIST_DIR}/${DOWNLOAD_FILE}"

apt install -f -y
