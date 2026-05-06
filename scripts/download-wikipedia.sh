#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 25 December 2024
# Purpose  : Download offline sections of Wikipedia.
set -e

HTML=kiwix.html
URL=http://download.kiwix.org/zim/wikipedia

# Location to store .zim files
ZIM_DIR=/etc/skel/wikipedia

[ ! -e ${ZIM_DIR} ] && mkdir -v ${ZIM_DIR}

if [ ! -e ${HTML} ]; then
  et-log "Downloading list of English Wikipedia files"
  curl -s -L -f -o ${HTML} ${URL}

  if [ $? -ne 0 ]; then
    et-log "Can't download list of files from ${URL}. Exiting..."
    exit 1
  fi
fi

options=()
while IFS= read -r zim_files; do
    zim_file=$(echo $zim_files | sed -n 's|.*href="\([^"]*\.zim\)".*|\1|p')

    options+=("$zim_file" "")
done < <(grep "[.]zim" kiwix.html | grep "wikipedia_en" kiwix.html | grep nopic | grep -E "computer|history|mathematics|medicine|simple" | sort)

selected_file=$(dialog --erase-on-exit --stdout --menu "Select a Wikipedia file:" 20 80 10 "${options[@]}")
exit_status=$?

download_url="${URL}/${selected_file}"
et-log "Downloading ${download_url}..."
curl -L -f -O ${download_url} && mv ${selected_file} ${ZIM_DIR}

rm ${HTML}
