#/bin/bash
# Author  : Gaston Gonzalez
# Date    : 7 January 2025
# Purpose : Generates an authentication table

top=( {A..M} )
side=( {N..Z} )
chars=( {A..Z} {0..9} )

printf "%2s " ""
for col in "${top[@]}"; do
  printf "%2s " "$col"
done
printf "\n"

for row in "${side[@]}"; do
  printf "%2s " "$row"
  for col in "${top[@]}"; do
    rand_index=$(( RANDOM % ${#chars[@]} ))
    printf "%2s " "${chars[$rand_index]}"
  done
  printf "\n"
done
