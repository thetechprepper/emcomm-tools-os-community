#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 20 January 2025
# Updated : 18 March 2025
# Purpose : Install VARA FM
source ./common-checks.sh

VARA_HOME="$HOME/.wine32/drive_c/VARA FM"
VARA_PATTERN="VARA%20FM"

./vara-downloader.sh "${VARA_PATTERN}"
[[ $? -ne 0 ]] && et-log "Error downloading VARA FM" && exit 1

DOWNLOAD_FILE=$(ls *.zip | grep "${VARA_PATTERN}")
[[ ! -e "${DOWNLOAD_FILE}" ]] && et-log "VARA download file not found" && exit 1

unzip -o ${DOWNLOAD_FILE}

wine 'VARA FM setup (Run as Administrator).exe'

if [ ! -e "${VARA_HOME}/nt4pdhdll.exe" ]; then
  et-log "Install missing DLL..."

  CWD=$(pwd)

  cd "${VARA_HOME}"
  curl -s -f -L -O \
    http://download.microsoft.com/download/winntsrv40/update/5.0.2195.2668/nt4/en-us/nt4pdhdll.exe && unzip nt4pdhdll.exe
  cd ${CWD}
fi

echo -e "${YELLOW}Run ${WHITE}./04-run-regedit.sh${YELLOW} to run registry editor.${NC}"
