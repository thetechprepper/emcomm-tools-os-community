#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 10 September 2026
# Purpose : Install VLC media player
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

# 1. Install utils for setting the package database.
DEBIAN_FRONTEND=noninteractive apt install debconf-utils -y

# 2. Provide answers for the interactive prompts
echo "libdvd-pkg libdvd-pkg/first-install note" | debconf-set-selections
echo "libdvd-pkg libdvd-pkg/post-invoke_hook-install boolean true" | debconf-set-selections
echo "libdvd-pkg libdvd-pkg/upgrade note" | debconf-set-selections
echo "libdvd-pkg libdvd-pkg/build boolean true" | debconf-set-selections

# 3. Install the VLC player and support for DVD playpack
DEBIAN_FRONTEND=noninteractive apt install \
  libdvd-pkg \
  libdvdread8 \
  vlc -y

# 4. Install the DVD decryption library
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure libdvd-pkg
