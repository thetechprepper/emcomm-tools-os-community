#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 4 November 2024
# Updated  : 3 December 2024
# Purpose  : Downloads OSM .pbf file selected by user

HTML=page.html
URL=http://download.geofabrik.de/north-america/us.html

# Location to store OSM .bpf files
PBF_MAP_DIR=/etc/skel/my-maps

[ ! -e ${PBF_MAP_DIR} ] && mkdir -v ${PBF_MAP_DIR}

if [ ! -e ${HTML} ]; then
  et-log "Downloading list of maps files for the US..."
  curl -s -L -f -o ${HTML} ${URL}

  if [ $? -ne 0 ]; then
    et-log "Can't download list map data from ${URL}. Exiting..."
    exit 1
  fi
fi

et-log "Extracting state-level .pbf file list..."

options=()
while IFS= read -r state_html; do
    state_file=$(echo $state_html | sed -n 's|.*href="\([^"]*\.osm\.pbf\)".*|\1|p')
    state_url="http://download.geofabrik.de/north-america/${state_file}"

    # Extract a display friendly name for the state
    state_name=$(echo $state_file | sed 's|us/||' | sed 's|-latest.osm.pbf||')

    options+=("$state_name" "$state_url")
done < <(grep "[.]pbf" page.html | grep 'href="us/' | sort)

SELECTED_STATE=$(dialog --clear --menu "Select a map file:" 20 80 10 "${options[@]}" 3>&1 1>&2 2>&3)
exit_status=$?

tput sgr 0 && clear

if [ $exit_status -eq 0 ]; then
  download_file="${SELECTED_STATE}-latest.osm.pbf"
  download_url="http://download.geofabrik.de/north-america/us/${download_file}"

  if [ -e ${download_file} ]; then
    et-log "${download_file} already exists. Skipping download."
  else
    et-log "Downloading ${download_url}."
    curl -L -f -O ${download_url}
  fi

  
  if [ -e ${download_file} ]; then
    navit_osm_bin_file=$(echo ${download_file} | sed 's|pbf|bin|') 
    navit_osm_bin_file_path="/etc/skel/.navit/maps/${navit_osm_bin_file}" 
    et-log "Generating OSM map for Navit: ${navit_osm_bin_file_path}"
    maptool --protobuf -i ${download_file} ${navit_osm_bin_file_path}

    et-log "Moving OSM .pbf to  ${PBF_MAP_DIR}"
    mv -v ${download_file} ${PBF_MAP_DIR}
  fi
fi

