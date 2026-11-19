#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 18 October 2026
# Purpose : A wrapper script around music_bot.py for playing
#           audio on a Partyline channel. This example is based
#           the Shortwave Listening whth TTP channel.

# If you're an EmComm Tools user, change the following varibales
# to suit your needs.
#
# - SERVER
# - ROOM
# - BOT
# - FOLDER

# Target server hash
SERVER="e6fc58d908db02cc07b60bd0a79a1b45"

# Target room name
ROOM="SWL with TTP"

# Name of this bot
BOT="SWL Bot"

# Music/audio folder
FOLDER=~/.config/partyline/music

# Do NOT change below this line unless you know what you are doing.

PYTHON=/opt/python/bin/python3.11
SCRIPT=~/.local/lib/python3.11/site-packages/partyline/bots/music_bot.py

if [[ ! -e "${FOLDER}" ]]; then
  et-log "Audio folder ${FOLDER} does not exist. Exiting..."
  exit 1
fi

${PYTHON} ${SCRIPT} \
  --autoplay \
  --room "${ROOM}" \
  --name "${BOT}" \
  --folder "${FOLDER}" \
  ${SERVER}
