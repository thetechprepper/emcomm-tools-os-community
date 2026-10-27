# Author  : Gaston Gonzalez
# Date    : 26 October 2026
# Purpose : Build xara from source
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh

APP=xara
VERSION=0.1.1
APP_AND_VERSION="${APP}-${VERSION}"
GIT_TAG="v${VERSION}"
GIT_URL="https://github.com/x0rro/xara.git"
GIT_WORKSPACE=xara
INSTALL_DIR="/opt/${APP_AND_VERSION}"
INSTALL_BIN_DIR="${INSTALL_DIR}/bin"
LINK_PATH="/opt/${APP}"

et-log "Installing ${APP} ${VERSION}"

CWD_DIR=`pwd`

cd ${ET_SRC_DIR}
[[ ! -e ${GIT_WORKSPACE} ]] && git clone ${GIT_URL} ${GIT_WORKSPACE}

cd ${GIT_WORKSPACE}
git checkout ${GIT_TAG}

# We only need Rust during the Cubic build.
# Source the install in # root's home directory.
source "$HOME/.cargo/env"

# Compile with support for higher speeds (registered)
cargo build \
  --release \
  --locked \
  --features registered

[[ ! -e ${INSTALL_BIN_DIR} ]] && mkdir -v -p ${INSTALL_BIN_DIR}

# Manually install binaries
cargo metadata --no-deps --format-version 1 |
  jq -r '.packages[].targets[] | select(.kind | index("bin")) | .name' |
   while read -r bin; do
     chmod 755 "target/release/${bin}"
     cp "target/release/${bin}" "${INSTALL_BIN_DIR}"
   done

[[ -e ${LINK_PATH} ]] && rm -v ${LINK_PATH}
ln -v -s ${INSTALL_DIR} ${LINK_PATH}

stow -v -d /opt ${APP} -t /usr/local

cd ${CWD_DIR}
