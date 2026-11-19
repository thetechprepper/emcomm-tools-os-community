#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 20 January 2025
# Updated : 11 November 2026
# Purpose : Install VARA HF
set -e

source ./common-checks.sh
source /opt/emcomm-tools/bin/et-common

DOWNLOAD_FILE="VARA.HF.v4.9.1.setup.zip"
ETC_TAG="emcomm-tools-os-community-20261027-r7-build34"
URL="https://github.com/thetechprepper/emcomm-tools-os-community/releases/download/${ETC_TAG}/${DOWNLOAD_FILE}"
VARA_HOME="$HOME/.wine32/drive_c/VARA"

download_with_retries "${URL}" "${DOWNLOAD_FILE}"

unzip -o "${DOWNLOAD_FILE}"

wine 'VARA setup (Run as Administrator).exe'

if [ ! -e "${VARA_HOME}/nt4pdhdll.exe" ]; then
  et-log "Install missing DLL..."

  CWD=$(pwd)

  cd ${VARA_HOME}
  curl -s -f -L -O \
    http://download.microsoft.com/download/winntsrv40/update/5.0.2195.2668/nt4/en-us/nt4pdhdll.exe && unzip nt4pdhdll.exe
  cd ${CWD}
fi

echo -e "${YELLOW}Run ${WHITE}./03-install-vara-fm.sh${YELLOW} to install VARA FM.${NC}"
