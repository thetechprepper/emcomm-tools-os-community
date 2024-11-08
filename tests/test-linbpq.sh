#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 8 November 2024
# Purpose  : Test Linbpq installation

OUT=$(linbpq -h | grep "G8BPQ")
exit $?
