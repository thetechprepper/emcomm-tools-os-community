#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 11 October 2024
# Updated : 8 December 2024
# Purpose : Perform tests that can be used by the udev subsystem to aid
#           in rule development. This is intended to by used with the PROGRAM
#           directive inside of a udev rule.
#
# Exit Statuses:
#  0   udev rule should match  
#  1   udev rule should not match.

ET_HOME=/opt/emcomm-tools
ACTIVE_RADIO="${ET_HOME}/conf/radios.d/active-radio.json"

# Exit with a 0 exit status if, and only if, the currently selected radio is
# a Yaesu FT-891.
test_yaesu_ft891() {
  if [ -L "${ET_HOME}/conf/radios.d/active-radio.json" ]; then
    ID=$(cat "${ET_HOME}/conf/radios.d/active-radio.json" | jq -r .id)

    if [[ "$ID" == "yaesu-ft891" ]]; then
      exit 0
    fi
  fi
  
  exit 1
}

# Exit with a 0 exit status if, and only if, the currently selected radio is
# a Yaesu FT-991A.
test_yaesu_ft991a() {
  if [ -L "${ET_HOME}/conf/radios.d/active-radio.json" ]; then
    ID=$(cat "${ET_HOME}/conf/radios.d/active-radio.json" | jq -r .id)

    if [[ "$ID" == "yaesu-ft991a" ]]; then
      exit 0
    fi
  fi
  
  exit 1
}

# Exit with a 0 exit status if, and only if, the currently selected radio 
# uses a DigiRig Mobile.
test_digirig_mobile() {
  if [ -L "${ET_HOME}/conf/radios.d/active-radio.json" ]; then
    ID=$(cat "${ET_HOME}/conf/radios.d/active-radio.json" | jq -r .id)

    if [[ "$ID" == "digirig-mobile-no-cat" ]]; then
      et-log "Old DigiRig Mobile detected for no CAT device"
      exit 0
    fi

    if [[ "$ID" == "yaesu-ft818nd" ]]; then
      et-log "Old DigiRig Mobile detected for FT-818ND"
      exit 0
    fi

    if [[ "$ID" == "yaesu-ft857d" ]]; then
      et-log "Old DigiRig Mobile detected for FT-857D"
      exit 0
    fi

    if [[ "$ID" == "yaesu-ft897d" ]]; then
      et-log "Old DigiRig Mobile detected for FT-897D"
      exit 0
    fi

  fi
  
  exit 1
}

usage() {
  echo "usage: $(basename $0) <radio ID>"
}

if [ $# -ne 1 ]; then
  usage
  exit 1
fi

case $1 in
  yaesu-ft891)
    test_yaesu_ft891
  ;;
  yaesu-ft991a)
    test_yaesu_ft991a
  ;;
  digirig-mobile)
    test_digirig_mobile
esac

exit 1
