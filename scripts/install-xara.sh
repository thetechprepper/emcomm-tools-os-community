#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 26 October 2026
# Updated : 9 November 2026
# Purpose : Build xara from user-provided source tarball
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh

APP=xara

et-log "Checking for ${APP} source tarball..."
if ! ls xara-*.tar.gz >/dev/null 2>&1; then
  et-log "xara source package not found. Skipping install. See xara.md"
  exit 0
fi

TARBALL=$(ls xara-*.tar.gz | head -1)

# Extract X.Y.Z version number (i.e., 0.1.3)
VERSION=${TARBALL#xara-}
VERSION=${VERSION%.tar.gz}

APP_AND_VERSION="${APP}-${VERSION}"
INSTALL_DIR="/opt/${APP_AND_VERSION}"
INSTALL_BIN_DIR="${INSTALL_DIR}/bin"
LINK_PATH="/opt/${APP}"

et-log "Installing ${APP} ${VERSION}..."

cp -v "${TARBALL}" "${ET_DIST_DIR}/"

CWD_DIR=$(pwd)

cd "${ET_SRC_DIR}"

tar -xzf "${ET_DIST_DIR}/${TARBALL}"

if [[ ! -d "${APP}" ]]; then
  et-log "${TARBALL} is not properly structured. Expected top-level directory: ${APP}"
  cd "${CWD_DIR}"
  exit 1
fi

et-log "Compiling ${APP} ${VERSION}..."
cd "${APP}"

# We only need Rust during the Cubic build.
# Source the install in root's home directory.
source "$HOME/.cargo/env"

# Compile with support for higher speeds (registered)
cargo build \
  --release \
  --locked \
  --features registered

[[ ! -e "${INSTALL_BIN_DIR}" ]] && mkdir -v -p "${INSTALL_BIN_DIR}"

# Manually install binaries
cargo metadata --no-deps --format-version 1 |
  jq -r '.packages[].targets[] | select(.kind | index("bin")) | .name' |
   while read -r bin; do
     chmod 755 "target/release/${bin}"
     cp "target/release/${bin}" "${INSTALL_BIN_DIR}"
   done

[[ -e "${LINK_PATH}" ]] && rm -v "${LINK_PATH}"
ln -v -s "${INSTALL_DIR}" "${LINK_PATH}"

stow -v -d /opt "${APP}" -t /usr/local

cd "${CWD_DIR}"
