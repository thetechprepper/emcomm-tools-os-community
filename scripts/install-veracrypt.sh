#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 7 September 2026
# Purpose : Install Veracrypt
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

APP="veracrypt"
VERSION="1.26.29"
FILE="veracrypt-${VERSION}-Ubuntu-22.04-amd64.deb"
URL="https://github.com/veracrypt/VeraCrypt/releases/download/VeraCrypt_${VERSION}/${FILE}"

et-log "Installing ${APP} ${VERSION}..."

et-log "Installing dependencies..."

apt install \
  pcscd \
  -y

if [[ ! -e "${ET_DIST_DIR}/${FILE}" ]]; then
  et-log "Downloading ${APP}: ${URL}"
  download_with_retries ${URL} ${FILE}
  mv -v ${FILE} ${ET_DIST_DIR}
fi

dpkg -i "${ET_DIST_DIR}/${FILE}"
