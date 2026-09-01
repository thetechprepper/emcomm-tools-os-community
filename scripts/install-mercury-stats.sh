#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 31 August 2026
# Updated : 1 September 2026
# Purpose : Install Mercury Stats
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh

APP=mercury-stats
VERSION=0.2.2
APP_AND_VERSION="${APP}-${VERSION}"
DOWNLOAD_FILE="${APP}-${VERSION}.tar.gz"
URL="https://github.com/thetechprepper/mercury-stats/archive/refs/tags/${VERSION}.tar.gz"
SRC_DIR="${ET_SRC_DIR}/${APP}-${VERSION}"
INSTALL_DIR="/opt/${APP}-${VERSION}"
INSTALL_BIN_DIR="${INSTALL_DIR}/bin"
INSTALL_LIB_DIR="${INSTALL_DIR}/lib/${APP}"
LINK_PATH="/opt/${APP}"

et-log "Installing ${APP} ${VERSION}..."

if [[ ! -e "${ET_DIST_DIR}/${DOWNLOAD_FILE}" ]]; then

  et-log "Downloading ${APP}: ${URL}"
  curl -s -L -o ${DOWNLOAD_FILE} --fail ${URL}

  mv ${DOWNLOAD_FILE} ${ET_DIST_DIR}
fi

CWD_DIR=`pwd`

et-log "Unpacking ${APP} ${VERSION} source..."
tar -xzf "${ET_DIST_DIR}/${DOWNLOAD_FILE}"

[ -e ${SRC_DIR} ] && rm -rf "${SRC_DIR}"
mv "${APP_AND_VERSION}" ${ET_SRC_DIR} && cd ${SRC_DIR}

mkdir -v -p ${INSTALL_LIB_DIR}
cp -v *.py ${INSTALL_LIB_DIR}

mkdir -v -p ${INSTALL_BIN_DIR}

cat <<'EOF' > "${INSTALL_BIN_DIR}/et-mercury-stats"
#!/bin/bash

APP_ROOT="/opt/mercury-stats"

exec /usr/bin/python3 \
    "${APP_ROOT}/lib/mercury-stats/mercury_stats.py" \
    "$@"
EOF

chmod 755 "${INSTALL_BIN_DIR}/et-mercury-stats"

[[ -e ${LINK_PATH} ]] && rm ${LINK_PATH}
ln -v -s ${INSTALL_DIR} ${LINK_PATH}

stow -v -d /opt ${APP} -t /usr/local

cd $CWD_DIR
