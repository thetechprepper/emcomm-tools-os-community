#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 5 November 2026
# Purpose  : Test man page installation

OUT=$(man -w et-user >/dev/null 2>&1)
exit $?
