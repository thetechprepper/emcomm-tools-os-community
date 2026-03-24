#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 13 August 2025
# Updated : 24 March 2026
# Purpose : Install EmComm Tools API
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

APP=et-api
VERSION=1.3.0
ET_API_JAR="emcomm-tools-api-${VERSION}.jar"
BASE_URL="https://github.com/thetechprepper/et-api-java/releases/download/${VERSION}"

INSTALL_DIR="/opt/emcomm-tools-api"
BIN_DIR="${INSTALL_DIR}/bin"
DATA_DIR="${INSTALL_DIR}/data"
INDEX_DIR="${INSTALL_DIR}/index"

et-log "Installing ${APP} ${VERSION}..."

mkdir -v -p "${BIN_DIR}" "${DATA_DIR}" "${INDEX_DIR}"

# Download and install et-api uber JAR
URL="${BASE_URL}/${ET_API_JAR}"
download_with_retries ${URL} ${APP}
mv ${APP} ${BIN_DIR}
chmod 755 "${BIN_DIR}/${APP}"

# Download pre-built data sets
FILES=(
  "faa.csv"
  "license.csv"
  "rmslist.csv"
  "zip2geo.csv"
  "zip2geo-elevation.csv"
)
for file in "${FILES[@]}"; do
  URL="${BASE_URL}/${file}"

  et-log "Downloading data set: ${URL}"
  download_with_retries ${URL} ${file}
  mv ${file} ${DATA_DIR}
done

et-log "Applying permissions..."
chgrp -v -R ${ET_GROUP} ${DATA_DIR} ${INDEX_DIR}
chmod -v 775 ${DATA_DIR} ${INDEX_DIR}
chmod -v 664 ${DATA_DIR}/*.csv
