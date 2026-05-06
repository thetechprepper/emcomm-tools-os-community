#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 3 April 2025
# Updated : 24 April 2024
# Purpose : Creates a Jekyll doc site
set -e
source /opt/emcomm-tools/bin/et-common

function usage() {
  echo "$(basename $0) <site-name>"
}

if [[ $# -ne 1 ]]; then
  usage
  exit 1
fi

SITE="$1"

rbenv local 3.3.8
gem install jekyll bundler && jekyll new ${SITE}

echo -e "${YELLOW}1. Move into the site directory: ${WHITE}cd ${SITE}${NC}"
echo -e "${YELLOW}2. Build and start site: ${WHITE}bundle exec jekyll serve${NC}" 
echo -e "${YELLOW}3. Access site in web browser: ${WHITE}xdg-open http://localhost:4000${NC}"
