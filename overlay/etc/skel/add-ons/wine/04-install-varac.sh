#!/bin/bash
#
# Purpose : Install VarAC

winetricks \
  --unattended \
  vcrun2015 \
  dotnet48 \
  tahoma

installer=$(find ${HOME}/Downloads -name VarAC_Installer_*.exe | sort -r | head -n1)

if [ -z "${installer}" ]; then
  echo -e "${YELLOW}VarAC can not be downloaded automatically"
  echo -e "${WHITE}Visit https://www.varac-hamradio.com/download"
  echo -e "From there, download the VarAC Windows Installer and place it into ~/Downloads"
  echo -e "Rerun ./04-install-varac.sh${NC}"
  exit 1
fi

if [ -f "${installer}" ]; then
  wine "${installer}"
fi

echo -e "${YELLOW}Run ${WHITE}./05-run-regedit.sh${YELLOW} to run registry editor.${NC}"
