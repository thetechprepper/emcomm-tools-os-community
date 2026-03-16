#!/bin/bash
#
# Purpose : Install VarAC

source /opt/emcomm-tools/bin/et-common

winetricks \
  --unattended \
  vcrun2015 \
  dotnet48 \
  tahoma

installer=$(find ${HOME}/Downloads -name VarAC_Installer_*.exe | sort -r | head -n1)

if [ -z "${installer}" ]; then
  echo -e "${YELLOW}VarAC can not be downloaded automatically"
  echo -e "${WHITE}Visit https://www.varac-hamradio.com/download#:~:text=Download%20VarAC%20Windows%20Installer"
  echo -e "Fill out the form to download the VarAC Windows Installer executable (.exe) and place it into ~/Downloads"
  echo -e "Rerun ./04-install-varac.sh${NC}"
  exit 1
fi

if [ -f "${installer}" ]; then
  wine "${installer}"
fi

echo -e "${YELLOW}Run ${WHITE}./05-run-regedit.sh${YELLOW} to run registry editor.${NC}"
