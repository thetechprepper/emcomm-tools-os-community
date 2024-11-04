#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 3 November 2024
# Updated  : 4 November 2024
# Purpose  : Test Pat Winlink installation

OUT=$(pat version | grep v0.16.0)
exit $?
