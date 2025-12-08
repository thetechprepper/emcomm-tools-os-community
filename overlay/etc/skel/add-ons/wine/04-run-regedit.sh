#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 20 January 2025
# Updated : 8 December 2025
# Purpose : Run regedit
set -e

source ./common-checks.sh

echo "Applying COM port mapping to /dev/et-cat..."
wine reg add 'HKEY_CURRENT_USER\Software\Wine\Ports' /t REG_SZ /v COM10 /d "/dev/et-cat" /f

echo "Applying application foucs hijacking fix..."
wine reg add 'HKEY_CURRENT_USER\Software\Wine\X11 Driver' /t REG_SZ /v UseTakeFocus /d N /f

echo -e "${YELLOW}"
echo -e "1. Expand HKEY_CURRENT_USER > Software > Wine > Ports"
echo -e "   Confirm that ${WHITE}COM10${YELLOW} key present and is to ${WHITE}/dev/et-cat${YELLOW}"
echo -e "2. Expand HKEY_CURRENT_USER > Software > Wine > X11 Driver"
echo -e "   Confirm that ${WHITE}UseTakeFocus${YELLOW} key present and is to ${WHITE}N${YELLOW}"
echo -e "3. Close the Registry Editor application"
echo -e "${NC}"

wine regedit
