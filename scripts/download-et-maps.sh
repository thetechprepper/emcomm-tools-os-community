#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 6 July 2025
# Updated  : 21 November 2025
# Purpose  : Downloads pre-rendered raster map tiles in mbtile format

BASE_URL="https://github.com/thetechprepper/emcomm-tools-os-community/releases/download"
RELEASE="emcomm-tools-os-community-20251128-r5-final-5.0.0"
TILESET_DIR="/etc/skel/.local/share/emcomm-tools/mbtileserver/tilesets"

# Display names for the menu
OPTIONS=(
  "us" "United States"
  "ca" "Canada"
  "world" "Global Map"
)

# Map each option to its corresponding file name
declare -A FILES
FILES=(
  ["us"]="osm-us-zoom0to11-20251120.mbtiles"
  ["ca"]="osm-ca-zoom0to10-20251120.mbtiles"
  ["world"]="osm-world-zoom0to7-20251121.mbtiles"
)

# Show dialog
SELECTED_COUNTRY=$(dialog --clear --menu "Select a country" 10 40 5 "${OPTIONS[@]}" 2>&1 >/dev/tty)
EXIT_STATUS=$?

tput sgr0 && clear

if [[ $EXIT_STATUS -eq 0 ]]; then
  DOWNLOAD_FILE="${FILES[$SELECTED_COUNTRY]}"
  DOWNLOAD_URL="${BASE_URL}/${RELEASE}/${DOWNLOAD_FILE}"

  if [[ ! -e ${DOWNLOAD_FILE} ]]; then
    et-log "Downloading ${DOWNLOAD_URL}"
    curl -L -f -o "${DOWNLOAD_FILE}" "${DOWNLOAD_URL}"
  fi

  et-log "Moving ${DOWNLOAD_FILE} to ${TILESET_DIR}"
  mv -v "${DOWNLOAD_FILE}" "${TILESET_DIR}"
fi
