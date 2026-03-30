#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 23 May 2023
# Updated : 1 December 2025
# Purpose : Offline HF prediction using voacapl
set -e
set -o pipefail
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo -e "${RED}\"${last_command}\" command failed with exit code $?.${NC}"' ERR

source /opt/emcomm-tools/bin/et-common

lookup_station() {
  local type="$1"   # call | grid | latlon
  local value="$2"  # callsign | grid | "lat,lon"
  local json_file="$3"

  case "$type" in
    gps)
      curl -f -s "http://localhost:1981/api/geo/position" | jq .position > "$json_file"
      if [[ $? -ne 0 ]]; then
        echo -e "${RED}Can't determine your position for use as the transmitting station.${NC}" >&2
        echo "Try specifying your callsign, grid or lat,lon." >&2
        echo "  --tx-call CALLSIGN        Transmitting station callsign" >&2
        echo "  --tx-grid GRID            Transmitting station Maidenhead grid" >&2
        echo "  --tx-latlon LAT,LON       Transmitting station coordinates in decimal degrees" >&2
        return 1
      fi
      ;;
    call)
      curl -f -s "http://localhost:1981/api/license?callsign=${value}" > "$json_file"
      if [[ $? -ne 0 ]]; then
        echo -e "${RED}Location not found for callsign: ${value}.${NC}" >&2
        return 1
      fi
      ;;
    grid)
      curl -f -s "http://localhost:1981/api/geo/grid?gridSquare=${value}"  | jq '{lat: .position.lat, lon: .position.lon}' > "$json_file"
      if [[ $? -ne 0 ]]; then
        echo -e "${RED}Error converting grid to lat/lon using value: ${value}.${NC}" >&2 
        return 1
      fi
      ;;
    latlon)
      # Write directly to JSON for consistency
      local lat lon
      IFS=',' read -r lat lon <<< "$value"
      if [[ -z $lat || -z $lon ]]; then
        echo -e "${RED}Invalid lat,lon format: $value. Expected 'lat,lon'.${NC}" >&2
        return 1
      fi
      jq -n --arg lat "$lat" --arg lon "$lon" '{lat: ($lat|tonumber), lon: ($lon|tonumber)}' > "$json_file"
      ;;
    *)
      echo -e "${RED}Invalid station type: $type${NC}" >&2
      return 1
      ;;
  esac

  # Extract lat/lon regardless of type
  local lat lon
  lat=$(jq .lat "$json_file")
  lon=$(jq .lon "$json_file")

  echo "$lat $lon"
}

validate_latitude() {
  local lat="$1"

  if [[ -z "$lat" ]]; then
    echo -e "${RED}Latitude can't be an empty value${NC}" >&2
    return 1
  fi

  if ! [[ "$lat" =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
    echo -e "${RED}Latitude must be a number${NC}" >&2
    return 1
  fi

  local latf
  latf=$(printf "%.10f" "$lat" 2>/dev/null) || {
    echo -e "${RED}Error converting latitude${NC}" >&2
    return 1
  }

  # Check range: -90 <= lat <= 90
  if (( $(echo "$latf < -90" | bc -l) )) || (( $(echo "$latf > 90" | bc -l) )); then
    echo -e "${RED}Latitude must be in range between -90 and 90 degrees${NC}" >&2
    return 1
  fi
}

validate_longitude() {
  local lon="$1"

  if [[ -z "$lon" ]]; then
    echo -e "${RED}Longitude can't be an empty value${NC}" >&2
    return 1
  fi

  if ! [[ "$lon" =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
    echo -e "${RED}Longitude must be a number${NC}" >&2
    return 1
  fi

  local lonf
  lonf=$(printf "%.10f" "$lon" 2>/dev/null) || {
    echo -e "${RED}Error converting longitude ${NC}" >&2
    return 1
  }

  # Check range: -180 <= lat <= 1800
  if (( $(echo "$lon < -180" | bc -l) )) || (( $(echo "$lon > 180" | bc -l) )); then
    echo -e "${RED}Longitude must be in range between -180 and 180 degrees${NC}" >&2
    return 1
  fi
}

ET_SSN="${HOME}/.local/share/emcomm-tools/voacap/ssn.txt"
if [[ ! -e ${ET_SSN} ]]; then
  echo -e "${RED}Sunspot number file not available:${WHITE}${ET_SSN}${NC}"
  echo -e "${YELLOW}Try running the following to fetch the sunspot numbers (requires Internet):${NC}"
  echo -e "${WHITE}cd ${HOME}/.local/share/emcomm-tools/voacap${NC}"
  echo -e "${WHITE}./fetch-ssn.sh${NC}"

  exit 1
fi

usage() {
  echo "Usage: $(basename $0) [OPTIONS]"
  echo
  echo "Station options (choose one per TX and RX):"
  echo "  --tx-call CALLSIGN        Transmitting station callsign"
  echo "  --tx-grid GRID            Transmitting station Maidenhead grid"
  echo "  --tx-latlon LAT,LON       Transmitting station coordinates in decimal degrees"
  echo "  --rx-call CALLSIGN        Receiving station callsign"
  echo "  --rx-grid GRID            Receiving station Maidenhead grid"
  echo "  --rx-latlon LAT,LON       Receiving station coordinates in decimal degrees"
  echo
  echo "If no --tx option is specified, your position will be pulled from a supported"
  echo "ETC GPS unit or fallback to the grid square configured by 'et-user'."
  echo 
  echo "Other options (required):"
  echo "  -p POWER                  Output power [5|10|20|50|100|500|1500]"
  echo "  -m MODE                   Mode [am|ardop|cw|js8|ssb|vara-500|vara-2300|vara-2750]"
  echo

  exit 1
}

tx_type="" 
tx_value=""
rx_type="" 
rx_value=""
power="" 
mode=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tx-call)   tx_type="call";   tx_value="$2"; shift 2 ;;
    --tx-grid)   tx_type="grid";   tx_value="$2"; shift 2 ;;
    --tx-latlon) tx_type="latlon"; tx_value="$2"; shift 2 ;;
    --rx-call)   rx_type="call";   rx_value="$2"; shift 2 ;;
    --rx-grid)   rx_type="grid";   rx_value="$2"; shift 2 ;;
    --rx-latlon) rx_type="latlon"; rx_value="$2"; shift 2 ;;
    -p)          power="$2"; shift 2 ;;
    -m)          mode="$2";  shift 2 ;;
    -*|--*)      echo "Unknown option: $1"; usage ;;
    *)           echo "Unexpected argument: $1"; usage ;;
  esac
done

# Use local ETC user position if TX station not defined
if [[ -z $tx_type ]]; then
   tx_type="gps"
fi

# Validate required args
[[ -z $rx_type || -z $power || -z $mode ]] && usage

#echo "TX ($tx_type): $tx_value"
#echo "RX ($rx_type): $rx_value"
#echo "Power: $power"
#echo "Mode: $mode"

# Allow for case-insensitve match of the user-defined operating mode
MODE=$mode
case "${MODE,,}" in
  js8-slow)
    MD="10.0"
    ;;
  js8)
    # normal speed
    MD="14.0"
    ;;
  js8-fast)
    MD="19.0"
    ;;
  ardop)
    MD="20.0"
    ;;
  js8-turbo)
    MD="24.0"
    ;;
  cw)
    MD="24.0"
    ;;
  ssb)
    MD="38.0"
    ;;
  am)
    MD="49.0"
    ;;
  vara-500)
    # VARA 500 Hz bandwidth (narrow)
    MD="15.0"
    ;;
  vara-2300)
    # VARA 2300 Hz bandwidth (standard)
    MD="20.0"
    ;;
  vara-2750)
    # VARA 2750 Hz bandwidth (tactical)
    MD="22.0"
    ;;    
  *)
    echo -e "${RED}Unknown mode: ${MODE}${NC}" >&2
    usage
    exit 1
    ;;
esac

ET_VOA_WORKING_DIR=$HOME/itshfbc/run
ET_VOA_REPORT=${ET_VOA_WORKING_DIR}/voacapl.txt
INP=${ET_VOA_WORKING_DIR}/voacapx.dat
OUT=${ET_VOA_WORKING_DIR}/voacapx.out

# Year = 2023
YEAR=$(echo $(date '+%Y'))

# Month (May) = 5.00
MONTH=$(date +'%m')
MONTH_FMT=$(date +'%-m.00')

#######################################################################
# TX Antenna
#######################################################################

if ! result=$(lookup_station "$tx_type" "$tx_value" tx-station.json); then
  if [[ "$tx_type" == "call" ]]; then
    echo "Try specifying a grid or lat,lon for the transmitting station."
    echo "  --tx-grid GRID            Transmitting station Maidenhead grid"
    echo "  --tx-latlon LAT,LON       Transmitting station coordinates in decimal degrees"
  fi
  exit 1
fi
read TL TK <<< "$result"

validate_latitude "$TL" || exit 1
validate_longitude "$TK" || exit 1

TL1=$( awk -v n1=$TL -v n2=90 -v n3=-90 'BEGIN {if (n1<n3 || n1>n2) printf ("%s", "a"); else printf ("%.2f", n1);}' )

# add North or South (N/S)
TLA=$( awk -v n1=$TL1 -v n2=0 'BEGIN {if (n1<n2) { n1=substr(n1,2); printf ("%6sS", n1); } else printf ("%6sN", n1);}' )

TK1=$( awk -v n1=$TK -v n2=180 -v n3=-180 'BEGIN {if (n1<n3 || n1>n2) printf ("%s", "a"); else printf ("%.2f", n1);}' )
		    
# add East or West (E/W)
TLO=$( awk -v n1=$TK1 -v n2=0 'BEGIN {if (n1<n2) { n1=substr(n1,2); printf ("%7sW", n1); } else printf ("%7sE", n1);}' )


#######################################################################
# RX Antenna
#######################################################################

if ! result=$(lookup_station "$rx_type" "$rx_value" rx-station.json); then
  if [[ "$rx_type" == "call" ]]; then
    echo "Try specifying a grid or lat,lon for the receiving station."
    echo "  --rx-grid GRID            Receiving station Maidenhead grid"
    echo "  --rx-latlon LAT,LON       Receiving station coordinates in decimal degrees"
  fi
  exit 1
fi
read RL RK <<< "$result"

validate_latitude "$RL" || exit 1
validate_longitude "$RK" || exit 1

RL1=$( awk -v n1=$RL -v n2=90 -v n3=-90 'BEGIN {if (n1<n3 || n1>n2) printf ("%s", "a"); else printf ("%.2f", n1);}' )

# add North or South
RLA=$( awk -v n1=$RL1 -v n2=0 'BEGIN {if (n1<n2) { n1=substr(n1,2); printf ("%6sS", n1); } else printf ("%6sN", n1);}' )

RK1=$( awk -v n1=$RK -v n2=180 -v n3=-180 'BEGIN {if (n1<n3 || n1>n2) printf ("%s", "a"); else printf ("%.2f", n1);}' )

# add East or West
RLO=$( awk -v n1=$RK1 -v n2=0 'BEGIN {if (n1<n2) { n1=substr(n1,2); printf ("%7sW", n1); } else printf ("%7sE", n1);}' )

# Power settings 
# Use 80% of user-defined power and express it in killiwatts since VOACAP's
# power setting is the power at the feedpoint not the transmitter.
#
# PW=(PWR×0.8)/1000
#
PWR=$power
PW="0.0800"
echo "TX Power: ${PWR} watts"
if [ "$PWR" = "5" ]; then
  PW="0.0040"
elif [ "$PWR" = "10" ]; then
  PW="0.0080"
elif [ "$PWR" = "20" ]; then
  PW="0.0160"
elif [ "$PWR" = "50" ]; then
  PW="0.0400"
elif [ "$PWR" = "100" ]; then
  PW="0.0800"
elif [ "$PWR" = "500" ]; then
  PW="0.4000"
elif [ "$PWR" = "1500" ]; then
  PW="1.2000"
else
  echo "Unsupported power level."
  usage
  exit 1
fi

# TODO: Add as an argument to R6
# Man-made Noise
# 140. industrial
# 144. residential
# 150. rural
# 163. remote
MMN="144."

# Format for 117
# NOTE: The card requires <SSN>. (117.)
ssn=`grep "$YEAR $MONTH" ${ET_SSN} | awk '{print $5}' | cut -d"." -f1`

# read more about fine-tuning your input file:
# http://www.voacap.com/voacapw.html
# http://www.voacap.com/frequency.html

echo -e "\n"

cat << END | tee $INP
LINEMAX     999       number of lines-per-page
COEFFS    CCIR
TIME          1   24    1    1
MONTH      $YEAR $MONTH_FMT
SUNSPOT    $ssn.
LABEL     $TX$RX
CIRCUIT  $TLA  $TLO   $RLA  $RLO  S     0
SYSTEM       1. $MMN 3.00  90. $MD 3.00 0.10
FPROB      1.00 1.00 1.00 0.00
ANTENNA       1    1    2   30     0.000[samples/sample.00    ]  0.0    $PW
ANTENNA       2    2    2   30     0.000[samples/sample.00    ]  0.0    0.0000
FREQUENCY  3.60 5.30 7.1010.1014.1018.1021.1024.9028.20 0.00 0.00
METHOD       30    0
BOTLINES      8   12   21
TOPLINES      1    2    3    4    6
EXECUTE
QUIT

END

voacapl -s ~/itshfbc
echo "voacapl exited with $? using in=$INP and out=$OUT"

(tail -n +27 $OUT | head -n 5 &&  grep -e'-  REL' $OUT && grep -e'-  S DBW' $OUT) | ./rel.pl > ${ET_VOA_REPORT}
cat ${ET_VOA_REPORT}
