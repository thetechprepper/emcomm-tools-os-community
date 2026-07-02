#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 2 July 2026
# Purpose : Cache supported RNode firmware for offline installs using:
#
#           rnodeconf --autoinstall --nocheck --fw-version VERSION
#
# Here are the supported devices and the command to install the firmware
# offline.
#
# Heltec LoRa32 v4
# $ rnodeconf --autoinstall --nocheck --fw-version 1.86

set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

et-log "Installing offline RNode firmware..."

OFFLINE_FILES_JSON="install-offline-rnode-firmware.json"
OFFLINE_SAVE_DIR="/etc/skel/.config/rnodeconf"
OFFLINE_UPDATE_DIR="/etc/skel/.config/rnodeconf/update"

[[ ! -e "${OFFLINE_SAVE_DIR}" ]] && mkdir -v -p ${OFFLINE_SAVE_DIR}

jq -c '.[]' "${OFFLINE_FILES_JSON}" | while read -r item; do
  URL=$(echo "$item" | jq -r '.url')
  FILE=$(echo "$item" | jq -r '.file')
  DIR=$(echo "$item" | jq -r '.dir')
  VERSION=$(echo "$item" | jq -r '.version')
  HASH=$(echo "$item" | jq -r '.hash')
  ABS_DIR="${OFFLINE_SAVE_DIR}/${DIR}"

  # 1. Create missing directories
  mkdir -v -p "${ABS_DIR}"

  # 2. Download resources
  download_with_retries ${URL} ${FILE}

  # 3. Move to offline folder
  mv "${FILE}" "${ABS_DIR}/"

  # 4. Create version file
  VERSION_FILE="${OFFLINE_UPDATE_DIR}/${VERSION}/${FILE}.version"
  et-log "Creating firmware version file: ${VERSION_FILE}"
  echo "${VERSION} ${HASH}" > ${VERSION_FILE}
done
