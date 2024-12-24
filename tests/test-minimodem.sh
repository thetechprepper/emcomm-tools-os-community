#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 24 December 2024
# Purpose  : Test minimode installation

OUT=$(minimodem -V | grep 0.24)
exit $?
