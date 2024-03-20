#!/bin/bash
#
# Author  : Gaston Gonzalez 
# Date    : 16 March 2024
# Purpose : Global functions 

function exitIfNotRoot() {
  if [ $EUID -ne 0 ]; then
    echo "Exiting. You must be root."
    echo "Try running: sudo ./$(basename $0)"
    exit -1
  fi
}
