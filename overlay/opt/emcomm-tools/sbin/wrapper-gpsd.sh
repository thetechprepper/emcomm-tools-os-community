#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 4 October 2024
# Purpose : Wrapper startup/shutdown script around systemd/gpsd 

WAIT=5

start() {
  et-log "Waiting to start gpsd for ${WAIT} seconds..."
  sleep ${WAIT}
  /usr/bin/systemctl restart gpsd
}

stop() {
  et-log "Waiting to stop gpsd for ${WAIT} seconds..."
  sleep ${WAIT}
  /usr/bin/systemctl stop gpsd
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
