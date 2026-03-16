#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 1 February 2025
# Purpose : Backup the ~/.wine32 directory for use in ETC image inclusion.

TODAY=$(date +"%Y%m%d")
BACKUP_FILE="${HOME}/etc-wine-backup-${HOSTNAME}-${TODAY}.tar.gz"

source /opt/emcomm-tools/bin/et-common

if [ -e "${BACKUP_FILE}" ]; then
  echo -e -n "${RED}A backup file for today exists. Can ${WHITE}${BACKUP_FILE} ${RED}be overwritten? (y/n) ${NC}"
  read response
  [[ $response != [yY] ]] && echo "Skipping backup and exiting." && exit 1
fi

# All paths are relative to $HOME.
BACKUP_DIRS=(
  ".wine32"
)

tar -czf ${BACKUP_FILE} \
   --transform 's|^.*\.local|.local|' \
   -C "${HOME}" "${BACKUP_DIRS[@]}"

[ $? -ne 0 ] && et-log "Error creating backup" && exit 1

# Test that we can read if after we create it.
TAR_OUT=$(tar -tzf ${BACKUP_FILE})
[ $? -ne 0 ] && et-log "Can't read backup file: ${BACKUP_FILE}. Error creating backup." && exit 1

echo -e "${GREEN}Backup created: ${WHITE}${BACKUP_FILE}\n"
