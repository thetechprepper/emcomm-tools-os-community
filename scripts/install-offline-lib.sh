#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 14 March 2026
# Purpose : Installs a variety of offline resources

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

et-log "Installing offline docs..."

OFFLINE_FILES_JSON="install-offline-lib.json"
OFFLINE_SAVE_DIR="/etc/skel/Desktop/offline"

[[ ! -e "${OFFLINE_SAVE_DIR}" ]] && mkdir -v -p ${OFFLINE_SAVE_DIR}

jq -c '.[]' "${OFFLINE_FILES_JSON}" | while read -r item; do
  URL=$(echo "$item" | jq -r '.url')
  FILE=$(echo "$item" | jq -r '.file')
  DIR=$(echo "$item" | jq -r '.dir')
  ABS_DIR="${OFFLINE_SAVE_DIR}/${DIR}"

  # 1. Create missing directories
  mkdir -v -p "${ABS_DIR}"

  # 2. Download resources
  download_with_retries ${URL} ${FILE}

  # 3. Move to offline folder
  mv "${FILE}" "${ABS_DIR}/"
done

