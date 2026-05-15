#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 13 May 2026
# Purpose : Install MeshChat for Reticulum
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

APP=ReticulumMeshChat
VERSION=2.3.0
INSTALL_DIR="/opt/${APP}-${VERSION}"
INSTALL_BIN_DIR="${INSTALL_DIR}/bin"
LINK_PATH="/opt/${APP}"

DOWNLOAD_FILE="${APP}-v${VERSION}-linux.AppImage"
URL="https://github.com/liamcottle/reticulum-meshchat/releases/download/v${VERSION}/${DOWNLOAD_FILE}"

et-log "Installing ${APP} ${VERSION}..."

if [[ ! -e ${DOWNLOAD_FILE} ]]; then
  download_with_retries ${URL} ${DOWNLOAD_FILE}
fi

chmod -v 755 ${DOWNLOAD_FILE}

[[ ! -e "${INSTALL_BIN_DIR}" ]] && mkdir -v -p "${INSTALL_BIN_DIR}"

mv ${DOWNLOAD_FILE} ${INSTALL_BIN_DIR}

ET_WRAPPER_SCRIPT="${ET_HOME}/bin/et-meshchat"

et-log "Creating wrapper script: ${ET_WRAPPER_SCRIPT}"
cat <<EOF > ${ET_WRAPPER_SCRIPT}
#!/bin/bash

${INSTALL_BIN_DIR}/${DOWNLOAD_FILE}
EOF

chmod -v 755 ${ET_WRAPPER_SCRIPT}
