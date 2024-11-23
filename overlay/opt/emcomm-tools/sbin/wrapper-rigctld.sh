#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 9 October 2024
# Updated : 28 October 2024
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

  # Special cases for the DigiRig Lite and DigiRig Mobile with no CAT. 
  if [ -L "${ET_HOME}/conf/radios.d/active-radio.json" ]; then
    RIG_ID=$(cat "${ET_HOME}/conf/radios.d/active-radio.json" | jq -r .rigctrl.id)

    # All VOX devices use the dummy mode provided by Hamlib. This helps maintain 
    # a cleaner interface by leveraging rigctl NET in applications.
    if [ "${RIG_ID}" = "1" ]; then
      et-log "Starting dummy rigctld service for VOX device."

      ID=$(cat ${ET_HOME}/conf/radios.d/active-radio.json | jq -r .rigctrl.id)
      PTT=$(cat ${ET_HOME}/conf/radios.d/active-radio.json | jq -r .rigctrl.ptt)

      CMD="rigctld -m ${ID} -P ${PTT} "
      et-log "Starting rigctld in VOX mode with: ${CMD}"
      $CMD
      exit 0
    fi

  fi

  if [ ! -e ${CAT_DEVICE} ]; then
    et-log "No CAT device found. ${CAT_DEVICE} symlink is missing."
    exit 1
  fi

  if [ ! -L ${ACTIVE_RADIO} ]; then
    et-log "No active radio defined. ${ACTIVE_RADIO} symlink is missing."
    exit 1
  fi

  # Check if rigctld is already running
  ps -ef | grep [r]igctld
  if [ $? -eq 0 ]; then
    PID=$(ps -ef | grep [r]igctld | awk '{print $2}')
    et-log "Rig control is already running with process ID: ${PID}."
    #kill -9 ${PID} 
    #sleep 1
  fi

  # Grab rigctld values from active radio configuration
  ID=$(cat ${ET_HOME}/conf/radios.d/active-radio.json | jq -r .rigctrl.id)
  BAUD=$(cat ${ET_HOME}/conf/radios.d/active-radio.json | jq -r .rigctrl.baud)
  PTT=$(cat ${ET_HOME}/conf/radios.d/active-radio.json | jq -r .rigctrl.ptt)

  # Special case for DigiRig Mobile for radios with no CAT control.
  if [ "${ID}" = "6" ]; then
    et-log "Starting rigctld in RTS PTT only mode with: ${CMD}"
    PTT=$(cat ${ET_HOME}/conf/radios.d/active-radio.json | jq -r .rigctrl.ptt)

    CMD="rigctld -p ${CAT_DEVICE} -P ${PTT} "
    et-log "Starting rigctld in RTS PTT only mode with: ${CMD}"
    $CMD
    exit 0
  fi

  # Generate command
  CMD="rigctld -m ${ID} -r ${CAT_DEVICE} -s ${BAUD} -P ${PTT} "
  et-log "Starting rigctld with: ${CMD}"
  $CMD
}

stop() {
  et-log "Stopping rigctld service..."
  systemctl stop rigctld

  if [ -L /dev/et-cat ]; then
    et-log "Removing stale /dev/et-cat symlink"
    rm -f /dev/et-cat
  fi
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
