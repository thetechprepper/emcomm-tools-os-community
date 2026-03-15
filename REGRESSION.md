# ETC Regression Tests 

- **Build**: ETC R6 Build 9
- **Date**: 14 March 2026

## Desktop/Launcher Icons

* [ ] JS8Call icon
* [ ] fldigi icon
* [ ] et-predict
* [ ] et-aircraft
* [ ] Terminal
* [ ] Navit
* [ ] Min web browser

## et-predict

* [ ] Map rendered
* [ ] Callsign search 
* [ ] Run prediction (e.g, ardop, ssb, vara-500, etc.)

## GPS

* [ ] Conky 
  * [ ] lat,lon
  * [ ] Dynamic grid
* [ ] et-api - http://localhost:1981/api/geo/position
* [ ] GPS Time
* [ ] et-predict - location geodetected
* [ ] Navit
  * [ ] State-level map rendered
  * [ ] Location geodetected

## User Configuration

* [ ] Launch JS8Call before et-user init (not allowed)
* [ ] Launch fldigi before et-user init (not allowed)
* [ ] et-user
* [ ] Conky updated with callsign and grid

## Radio

* [ ] et-radio
  * [ ] TX-500MP
  * [ ] IC-7200
* [ ] JS8Call
  * [ ] Callsign and grid displayed
  * [ ] Call groups (TTP, TTPNET, @GHOSTNET, @GSTFLASH, @AMRRON)
  * [ ] Decode data
  * [ ] Tune up + full TX power out
  * [ ] SNR + full TX power out
  * [ ] Settings > Station Info = ETC_<BUILD>
  * [ ] alsamixer level (IC-7200 = 82 PCM)
* [ ] fldigi
  * [ ] Tune up + full TX power out
  * [ ] Callsign displayed

## SDR

* [ ] et-aircraft-app
  * [ ] Launch app before SDR is connected (not allowed)
  * [ ] Map rendered
  * [ ] Location geodetected
  * [ ] RTL-SDR v4
  * [ ] Offline FAA info
  * [ ] RTL-SDR v3
  * [ ] RTL-SDR v2
  * [ ] ADS-B Exchange
* [ ] SDR++
  * [ ] WFM broadcast

## et-mode

* [ ] winlink-ardop
  * [ ] Callsign displayed
  * [ ] Listener enabled
  * [ ] RMS station listed
  * [ ] Select RMS gateway => VFO updated
  * [ ] Connect

## Bluetooth TNC

* [ ] et-uv-pro
  * [ ] pair
  * [ ] connect
  * [ ] Winlink
  * [ ] QtTermTCP
  * [ ] YAAC
  * [ ] unpair

## VARA

* [ ] et-radio => DigiRig Lite
* [ ] VARA restore
* [ ] et-mode VARA FM (Winlink)
* [ ] et-mode VARA HF (Winlink)

## SIGINT

* [ ] Artemis
  * [ ] Available via application search
  * [ ] Signal database renders

## Security

* [ ] gpa

## fldigi/flmsg/flamp

* [ ] Launch fldigi from Application Launcher 
* [ ] Confirm callsign under Config > Personal data
* [ ] Confirm custom AmRRON forms
* [ ] Confirm flmsg starts with fldigi
* [ ] Confirm flmsg modem syncs with fldigi modem
* [ ] Confirm two rows of macros
* [ ] Confirm AmRRON 2022 macros under: File > Macros > Open

## Offline Resources

* [ ] `offline` folder on Desktop
* [ ] List of public nets avaiable
