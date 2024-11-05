#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 5 November 2024
# Purpose  : Test ARDOP Winlink installation

OUT=$(ardopcf -h | grep "1.0.4.1.3")
exit $?
