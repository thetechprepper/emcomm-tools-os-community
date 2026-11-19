#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 3 November 2024
# Updated  : 21 August 2026
# Purpose  : Test Pat Winlink installation

OUT=$(pat version | grep v1.0.0)
exit $?
