# Author  : Gaston Gonzalez
# Date    : 26 October 2026
# Purpose : Install Rust
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh

APP=rust
VERSION=1.99.1

et-log "Installing ${APP} ${VERSION}"

# Install a pinned version of Rust for root with zero interaction
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
  sh -s -- -y --no-modify-path --default-toolchain ${VERSION}
