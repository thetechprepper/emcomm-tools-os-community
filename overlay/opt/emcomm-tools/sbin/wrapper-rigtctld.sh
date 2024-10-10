#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 9 October 2024
# Purpose : Wrapper startup/shutdown script around systemd/rigctld

ET_HOME=/opt/emcomm-tools
ACTIVE_RADIO="${ET_HOME}/conf/radios.d/active-radio.json"
CAT_DEVICE=/dev/et-cat

do_full_auto() {
  et-log "Found ET_DEVICE='${ET_DEVICE}'"

  case "$1" in
    IC-705)
      echo "Automatically configuring $1..."
      if [ -L ${ACTIVE_RADIO} ]; then
        rm -v  ${ACTIVE_RADIO}
      fi

      ln -v -s ${ET_HOME}/conf/radios.d/icom-ic705.json ${ACTIVE_RADIO}
    ;;
  *)
    et-log "Full auto configuration not available for ET_DEVICE=$1"
    ;;
  esac
}

start() {
  if [ ! -e ${CAT_DEVICE} ]; then
    et-log "No CAT device found. ${CAT_DEVICE} symlink is missing."
    exit 1
  fi

  # Attempt "full auto" plug-and-play for select devices
  udevadm info ${CAT_DEVICE} | grep ET_DEVICE > /dev/null
  if [ $? -eq 0 ]; then
    et-log "Attempting full auto plug and play..." 
    ET_DEVICE=$(udevadm info ${CAT_DEVICE} | grep ET_DEVICE | cut -d"=" -f2)
    do_full_auto $ET_DEVICE
  fi

  if [ ! -L ${ACTIVE_RADIO} ]; then
    et-log "No active radio defined. ${ACTIVE_RADIO} symlink is missing."
    exit 1
  fi

  # check if rigctld is already running
  ps -ef | grep [r]igctld
  if [ $? -eq 0 ]; then
    PID=$(ps -ef | grep [r]igctld | awk '{print $2}')
    et-log "Rig control is already running with process ID: ${PID}. Killing it now..." 
    kill -9 ${PID} 
    sleep 1
  fi

  # Grab rigctld values from active radio configuration
  ID=$(cat ${ET_HOME}/conf/radios.d/active-radio.json | jq -r .rigctrl.id)
  BAUD=$(cat ${ET_HOME}/conf/radios.d/active-radio.json | jq -r .rigctrl.baud)
  PTT=$(cat ${ET_HOME}/conf/radios.d/active-radio.json | jq -r .rigctrl.ptt)

  # Generate command
  CMD="rigctld -m ${ID} -r ${CAT_DEVICE} -s ${BAUD} -P ${PTT} "
  et-log "Starting rigctld with: ${CMD}"
  $CMD
}

stop() {
  et-log "Not implemented yet"
}

usage() {
  echo "usage: $(basename $0) <cmd>"
  echo "  <cmd>  [start|stop]"
}

if [ $# -ne 1 ]; then
  usage
  exit 1
fi

case $1 in
  start)
    start
    ;;
  stop)
    stop
    ;;
  *)
    usage
  ;;
esac
