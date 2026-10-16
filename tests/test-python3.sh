#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 16 October 2026
# Purpose  : Test custom Python3 installation

OUT=$(/opt/python/bin/python3.11 --version 2>&1 | grep "3.11.17")
exit $?
