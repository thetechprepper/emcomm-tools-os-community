# EmComm Tools OS Community Release

## 2026.11.26.R7 (7.0.0) Release Notes

* et-mode
  * Added time-wwv mode (see et-wwv)
  * Added winlink-telnet mode
  * Added winlink-xara-fm mode
  * Added winlink-xara-hf mode
  * Added man page
  * Cleaned up order of menu items
* et-user-backup
  * Added NomadNet to backup
  * Added man page
* et-wwv
  *  Sets the system clock to the top of the minute via WWV/WWVH
* HF Prediction
  * Updated solar sunspot smoothing numbers through October 2027
* VARA
  * Fixed add-on script to install VARA FM 4.4.1
  * Fixed add-on script to install VARA HF 4.9.1
* Winlink
  * Upgraded Pat Winlink to version 1.0.0
  * Updated Winlink RMS list for 11/10/26


cd63ecf man - Added initial draft of et-partyline-server
d3db90d vara - Updated VARA add-on scripts to pull the latest version of VARA HF and FM. This is needed as Cloudfare is blocking cURL. The VARA license allows for unmodified redistribution of the installers.
577e971 man - Added initial draft for et-reticulum
7d4adbe reticulum - Upgraded from 1.5.7 to 1.6.0
c3350bf Merge pull request #124 from thetechprepper/feature/xara-user-build
861deb4 xara - Enable xara modem in et-mode only if xara is installed
df84a09 xara - Changed exit status to zero if source tarball not present; applied consistent quotation marks for variable expansion; finally switched to modern command substituion.
18333b9 xara - Updated xara installer to use user-provided source package if available
c46ca8a xara - Add instructions for providing a source package when building the EmComm Tools ISO.
e00e623 Merging misc/pre-r7-build36-updates to release/r7
92fd3fc et-index - Added man page for et-index
db62e2d et-index - Initial command to help with rebuilding EmComm Tools indexes if needed
c9397cd man - Initial draft of et-user-restore command
558e72e man - Initial draft of et-user-backup command
2ef2601 regression - Bumped build to 36
af5f332 mercury - Bumped version 1.9.13 to 1.9.22
bd5893e Merge pull request #123 from thetechprepper/docs/r7-man-pages
1026486 man - Initial draft of et-mode command
16982dd man - Initial draft of et-radio command
1d7492c man - Added test case, regression item, and man page installation
013a529 man - Initial draft of et-user command
fb37b2d man - Initial man page for et-user
1ee1806 Merge misc/pre-r7-build35-updates to release/r7
dba59ed xara - Enabled full modem speeds
9162878 xara - Upgrade from version 0.1.1 to 0.1.3
d19140d ttp-blog - Adding an NWS weather post that I wrote for my internal blog and public BBS.
47c3417 debranding - Adjusted EmComm Tools logo alignment
d702cf0 qttermtcp - Correct argument order for download_with_retries
768bf8e r7 - Added strawman for R7 release with critical pre-release reminders
0815ecd Merge pull request #122 from thetechprepper/fix/cantab-net
cfc14ed qttermtcp - Moved QtTermTCP artifact to GitHub release given cantab.net outage.
78d298b linbpq - Moved LinBPQ artifacts to GitHub release given cantab.net outage.
175c5f5 Merge pull request #121 from thetechprepper/feature/xara
4a90506 xara - Implemented workaround so that xara works with VOX devices
ab25457 xara - Updated to-do. Found issue with the xara and VOX devices (DigiRig Lite) via rigctld
29841fb xara - Updated et-mode to support all xara modes for the QtTermTCP application (bbs-client2)
0248caf xara - Added individual user-level systemd unit files for all combinations of xara modes and bandwidth options
83d58f7 xara - Updated et-vara to include CLI arg for xara HF and FM with corresponding bandwidth options
85c4dbb xara - Added standard ET audio subsystem checks before starting modem
c14b92f xara - Updated regression
e11b67a xara - Added intial support for replacing the user's callsign and audio card and device numbers.
09a7f69 xara - Updated comments to reflect finished to-do items
0f97747 xara - Fixed typo in xara test case
d114cb4 xara - Added initial support to et-mode for QtTermTCP and Winlink
339c081 xara - Initial installer for xara
e995c8a xara - Install Rust for root only for use during the Cubic build.
dac85ef Merge pull request #120 from thetechprepper/feature/reticulum-bluetooth
bcddd58 regression - Updated manual tests
8d1b82a bluetooth - Add Reticulum AX.25 support for supported Bluetooth TNCs
0b607f7 bluetooth - Fixed empty string evaluation bug in get_mac_or_exit
ad3ca3a bluetooth - Fixed bug preventing Bluetooth pairing due to env typo
8c34939 Merge pull request #119 from thetechprepper/feature/partyline
0918677 partyline - Fixed typo
6e24482 veracrypt - Removing test case since it is not currently be installed
4645f6f veracrypt - Disabling as it is preventing the live USB installer from completing
4ba5d7b party-line - Added an example audio/music bot wrapper based on my SWL with TTP channel
94a2bf0 partyline - Fixed partlyline-server test following Cubic build
8d44a6f partyline - Fixed et-partlyline-server test following Cubic build
d198dd8 veracrypt - Added Veracrypt to main installer
31cf484 partyline - Added test case for et-partyline-server
c81ab3b partyline - Added initial support for et-partyline-server wrapper script for PnP
925e2f7 partyline - Added launcher for partyline
fc67829 partyline - Added test case for partyline installation
896d252 python - Updated Python 3.11.17 build to enable optional C extension modules
d75ceae python3 - Added test case for Python 3.11.17 custom install
bffb9b1 partyline - Initial attempt to install partyline, but it required an upgrade to Python 3.11.x or newer. I opted to install it from source under opt and explicitly reference it for the Reticulum ecosystem. Unlike the other optional software, I did not want to symlink it back to /usr/local with stow.
20d87c8 Merge pull request #118 from thetechprepper/misc/pre-r7-build28-updates
c296f56 display - Always set screen to 100% on login
9af0f40 power - Prevent automatic screen brightness. Not ideal for field operations
6dfa7c9 power - Prevent screen from dimming. Not ideal for field operations
5a08317 linbpq - Fixed linbpq installer following removal of linbpq 32-bit download file by the developer. This version in ETC is now version pinned.
6b684c3 Enabled dark mode as default
b51b7bd meshchat - Upgraded to TTP fork version 2.4.0-R7B27. Includes minor UI updates tfor the paper message feature
e0b63fa meshchat - Upgraded to TTP fork version 2.4.0-R7B26. Includes initial support for paper messages
426e9b2 reticulum - Upgraded rnsd to 1.5.2
0813f94 dvd - Added support for VLC and DVD playback
abf1288 Merge pull request #117 from thetechprepper/feature/veracrypt
10a9b8d veracrypt - Added latest release of VeraCrypt
6697bca Merge pull request #116 from thetechprepper/misc/pre-r7-build23-updates
e1905f4 ubiquity - Added R7 installer icon
8bf71e3 debranding - Added .gitignore
a929ad3 debranding - Removed the E and T from the spinner. No headaches!
e45c905 debranding - Removed original spinner design and script
67ff657 debranding - Experimenting with a larger spinner based on the EmComm Tools main icon
e922cfe debranding - Replaced Plymouth spinners with EmComm Tools spinner
d46e605 nomadnet - Added NomadNet 1.2.0
47ce4da reticulum - Upgrade Reticulum from version 1.3.9. to 1.5.1
6e225a4 et-mode - Suppressed warning messages from min when starting Winlink modes
37b2fbc Merge pull request #115 from thetechprepper/feature/mercury-enhancements
ee9cc15 et-mercury-stats - Bumped version to 0.2.2 following over-the-air testing
a0a03c0 et-mercury-stats - Bumped version to 0.2.1 following over-the-air testing
2e46758 et-mercury-stats - Bumped version to 0.2.0 following over-the-air testing
a6ac1f2 et-mercury-stats - Initial tool to help analyze Mercury HF logs
491fa99 mercury - Switched to using JSON logging to support easier parsing of logs by third-party tools
85d3e9a mercury - Added Mercury HF support to BBS client 2 (i.e. QtTermTCP)
3f36a68 Merge pull request #114 from thetechprepper/feature/mercury-enhancements
5cf4885 mercury - Updated all systemd service to user only three Mercury modes: ARQ, broadcast and custom
54c50a2 mercury - Corrected typos ini files
486c284 mercury - Initial refactoring for the Mercury plug-and-play support in EmComm Tools. Moved to a model where ARQ, broadcast, and user-defined mode are the only options
77fa9e7 mercury - Updated Mercury HF modem version from 1.9.11 to 1.9.13
1d7a6bf Merge pull request #113 from thetechprepper/feature/winlink-mercury
0403ba1 regression - Updated regression tests
5bcc4fd et-kill-all - Added the mercury process to ensure that mercuy does not continue running.
595c2b2 Merge pull request #112 from CowboyPilot/patch-2
c3ad768 Update test-winlink.sh
8454ddb mercury - Added initial support for Winlink over Mercury HF modem
24d13e4 mercury - Upgraded mercury from 1.9.9 to 1.9.11
f110ee6 min - Upgraded min from version 1.34.1 to 1.35.6
3e9444e Merge pull request #111 from thetechprepper/feature/et-user-app
8210150 Minor updates post ETC R7 Build installation.
0894cc5 ubiquity - Added et-user-app to the Ubiquity slideshow. Also made minor edits to existings slides.
758a286 et-user-app - Upgraded to version 1.0.2 to support centering via an x11 backend. Added support for starting et-user-app on first login
0ce0d28 et-user-app Updated version 1.0.1
6fe10e1 Added et-user-app to installer and desktop
efa0466 et-user-app Initial installer script for the et-user GUI
b6afc3e Merge pull request #110 from thetechprepper/misc/post-7-build12-updates
87a02ff ubiquity - Added et-radio and et-mode slides
db3d98d ubiquity - Removed bold typeset as it is not rendered
eeddf58 ubiquity - Added correct screenshot for et-reticulum slide
36f23aa ubiquity - Added et-reticulum to the installer slide show
5a2db72 et-reticulum - Temporarily removing ET_RETICULUM replacement tokens that are not yet supported by et-reticulum. These will be re-added soon.
40f1741 bpq - Set a proper retry for the 1200 baud packet port. 100 is excessive. It should be 10
c1e0e8e reticulum - Changed the interface mode for the LoRa, Packet, and Auto interfaces from ap to internal. This allows all the internal devices on those interfaces to see eachother while avoiding the external announce storm.
60fcc54 et-reticulum - Enabled TTP TCP Client interface on Permanent Transport Node blueprint
6b54b9d et-reticulum - Fixed radio modem selection to allow for packet, modem73, or mercury
7ef268d reticulum - Fixed a bug resulting in a premature exit if an et-radio device is connected, but the configuration does not use the radio interface. For example, DigiRig Lite connected, but RNode blueprint selected.
6095aa4 reticulum - Upgraded to version 1.3.9
41e9e52 reticulum - Removed trailing whitespace in Mercury interface
0594c15 mercurcy - Fixed PTT issue for rigctld
921f726 reticulum - Updated exit handler in et-reticulum to kill mercury
0ee7608 Merge pull request #109 from thetechprepper/misc/reticulum-updates-1
5e39f0c reticulum - Set mode to roaming for Mercury interface
10d0a96 reticulum - Exit if user does not want to run encryption
dfda7d5 reticulum - Exit if user does not select a modem
716cf3c mercury - Disabled the following Mercury modes (DATAC17 and QAM16C2) as they do not appear as valid indexes in version 1.9.9
bcafbee reticulum - Removed the RNode interface from all the radio-only interfaces (i.e., packet, modem73, and mercury)
3c79b31 mercury - Updated et-kill-all to kill all modem73 and mercury modems
24bc105 mercury - Added user systemd services for starting the Mercury modem at different speeds
3362164 mercury - Initial wrapper script for starting the Mercury HF modem
b408d94 mercury - Initial wrapper script for starting the Mercury HF modem
ac599b5 mercury - Added Mercury HF modem
25687da reticulum - Consistently set enabled to no (instead of No)
8ee7bf6 reticulum - Consistently set enabled to yes (instead of Yes)
5c05593 reticulum - Set mode to AP on the AutoInterface to prevent an announce storm on the local ethernet/wi-fi
afe8f44 reticulum - Upgraded MeshChat to v2.4.0 with the EmComm Tools patches
b58d53c Merge pull request #108 from thetechprepper/misc/post-7-build10-uppdates
c89ca4f reticulum - Upgraded rnsd from 1.3.5 to 1.3.8
2046cd4 reticulum - Initial PnP support RAK4631 boards
36726e9 offline-lib - Updated Reticulum manual to version 1.3.4
619f279 email - Added Thunderbird to regression doc
3cc56fb email - Installed Thunderbird for future off-grid email application
fd1fba1 reticulum - Added an RNode firmware wrapper script for installing the Heltec v4 firmware fully offline
4ba6f8c reticulum - Added RNode-only blueprint for Reticulum
139512a voacap - Updated Sunspot Smoothing Numbers as of 07/03/26
f760f7e et-user-backup - Add Reticulum assets to backup list
d4930aa offline-libs - Added 2025 NiFOG
18fdc85 reticulum - Added support for flashing the RNode firmware on a Heltec v4 offline
bf8eb94 Merge pull request #107 from thetechprepper/fix/artemis
07b7659 artemis - Removing Artemis from EmComm Tools as the developers removed the 4.1.0 ZIP asset and replaced it with a debian package on GitHub. The new Debian package forces upgrades to systems dependencies that may make EmComm Tools unstable.
bf0fb99 Merge pull request #106 from thetechprepper/debrand
ce2ed32 Merge pull request #105 from thetechprepper/feature/reticulum
5d83a76 modem73 - Updated et-reticulum to support all the new simple-to-use modem73 modes
ad3f81e modem73 - Updated et-reticulum to support no simple operating modes
e0630fa modem73 - Added systemd user unit files for each support modulation provided by the et-modem73 wrapper script
a74e19b modem73 - Added three more modulation types that map to fast speeds
832fc11 modem73 - Added support for passing the currently configured callsign
3030d02 modem73 - Changed the command line interface to support only the mode and optional --headless argument
237f575 modem73 - Removed settings file before each run to prevent inconsistent or incorrect configuration for ETC
5419c48 modem73 - Added support for force killing modem73 on application exit
bbb0417 modem73 - Force stop modem73 if it will not exit
32179bd retiuclum - Added support to dynamically enable/disable modem73 depending on the system state
f5fb54c reticulum - Renamed the radio only interface to packet now that we have modem73 as anothor radio options
257037b reticulum - Updated et-reticulum to restrict the list of radio modem options based on the interfaces defined in the blueprint.
a2e55f3 modem73 - Added modem73 interface to Reticulum installation
5af3630 modem73 - Added a blueprint for a modem73 interface
f3f9f85 modem73 - Add support for stopping all services to support a clean start of Reticulum
d3a12fd modem73 - Initial PnP wrapper script for modem73
2fffb14 modem73 - Patched my fork of modem73 to use the ALSA backend in order to support audio PnP in EmComm Tools
d572bdf modem73 - Add modem73 user systemd service
252c9b8 Initial support for modem73
18a917e reticulum - Added a modified version of MeshChat
3f60176 reticulum - Upgraded Reticulum to version 1.3.5
7994eb3 reticulum - Added a TCP client example to the TTP test network
eb8b7a0 reticulum - Added a sample comment for using an RNode over a TCP port
a1f24f3 reticulum - Updates following ETC R7 Build 5 Reticulum testing. rnsd 1.3.5 does not work with NomadNet. Rolled back to version 1.2.5
74d688e reticulum - Sorted list of blueprint configs
7899533 ETC R7 Build 5 Updates - Updated download link for pfte; upgrade Reticulum to 1.3.5; removed nomadnet temporarily from the installer due to dependency issues
21d51f7 reticulum - Changed approach for running MeshChat. It's up to the user to ensure that rnsd is running
1efca3d reticulum - Add sample TCP Client intrface for those interested in enabling it manually
b90e8b1 reticulum - Enabled AutoInterface on transport blueprint
ae85cbc reticulum - Only poll for LoRa power settings if device is detected
87b9216 reticulum - Added ET_DEVICE_LORA to environment
419d9f8 reticulum - Added initial support for dynamically determining the max TX power output of a device
559bf54 reticulum - Updated regression testing notes
8c7c364 reticulum - Added support for optionally started a packet modem if a supported is plugged in and detected
941b747 reticulum - Removed original approach for Reticulum systemd services
d614e5c et-mode - Removed Reticulum as an option
9467576 reticulum - Added support to dynamically enable the AX.25 interface if the PnP subsystem detected the device
d3d5dfc reticulum - Added support to dynamically enable the RNode interface if the PnP subsystem detected the device
510657d lora - Updated LoRa udev rules to correctly create a symlink to /dev
26b0c0b reticulum - Complete redesign for starting the Reticulum Network Stack. Still a work in progress.
25cd53e reticulum - Removing initial attempt add managing Reticulum configuration files in EmComm Tools
8009e03 reticulum - Initial proof-of-concept for supporting multiple Reticulum configurations. EmComm Tools refers to these as 'Blueprints'.
4b60b56 lora - Added support for LilyGO TTGO v2.1 and disabled Heltec v3
e6aa120 lora - Move LoRa devices rules ahead of the legacy et-cat rules
f6b72ad lora - Fixed syntax error for et-lora case
43e6895 lora - Initial support for introducing PnP for LoRa devices. The Heltec v3 collides with chip sets used by et-radio. Will address with a solution in a future commit on this branch
fb23857 misc - Added offline Heltec v3 and v4 datasheets; added a very early design for the potential Reticulum blueprint configuration subsystem
2235d9e Reticulum - Added support for running MeshChat at 1200 baud packet from the Desktop Activities
1548e41 reticulum - Updated 300 baud configuration to match 1200 baud conifiguration
0a14708 reticulum - Added support for MeshChat to et-mode; enabled Reticulum to support multi-interface routing
7cfa0d5 reticulum - Added support for creating ~/.reticulum if does not exist
9118989 debranding - Added missing steps to start apply EmComm Tools brand
e634d0e reticulum - Added basic NomadNet configuration file and Reticulum manual
eaaa1e5 reticulum - Updated et-kill-all to stop all Reticulum systemd services
21c5023 reticulum - Initial work add Reticulum to et-mode
44a2495 reticulum - Added initial user-level systemd services for Reticulum
3505390 reticulum - Updated TODO and REGRESSION docs
9b65d80 reticulum - Start the appropriate direwolf systemd service based on the desired packet mode
c14a9c1 reticulum - Initial work on et-reticulum wrapper script
e612fac reticulum - Initial Reticulum configuration with AX.25 support based on my original proof-of-concept from rnsd version 1.1.3.
b18f6a4 reticulum - Initial work to install Reticulum and Nomad for use be a local user.
2947e08 reticulum - Added the Reticulum Primer by Michael Faragher for offline reading.
5ed346a reticulum - Initial work on integrating Reticulum into EmComm Tools
2cc1eea debranding - Added initial support for branding EmComm Tools with basic Plymouth overrides.
a5fd8d9 debranding - Added et-mail and et-aircraft to the slideshow
7b412c3 debranding - Initial work to customize the Ubiquity installer
cce643f Resolved merge conflict
4ec08ce security - Disabled the algif_aead module to prevent the exploitation of CVE-2026-31431
e52acc6 js8call - Fetching JS8Call 2.2.0 from an alternate location as it looks like there are new site owners for the js8call domain
e10c34e Merge pull request #104 from thetechprepper/feature/et-wwv
ee1c336 et-auth-table - Added a script to generate an authentication table. This was used during the T-Rex Labs collaboration video.
16ae97e et-wwv - Added et-wwv-wrapper
5d34d7a et-clock - Added support for et-clock. An alias to render a terminal clock with HH:MM:SS
49301f3 et-mode - Added WWV mode to et-mode
516fb98 et-wwv - Added support for running et-wwv wrapper with password
1315fde Early work on the et-wwv wrapper script

## 2026.04.01.R6 (6.0.0) Release Notes

* Tier 1 radio PnP support
  * Updated notes for IC-7200 and automatically set ALSA audio levels
  * Updated notes for IC-7300 and automatically set ALSA audio levels
* Tier 2 radio PnP support
  * Added Xiegu X6200 support
* SDR
  * Added SDR++ application
* HF Prediction
  * Added et-winlink-find - Locate Winlink stations near a geographic area
  * Updated et-voacap - Add support for VARA HF 500, 2300, and 2750 modes
* et-predict-app 1.5.2
  * Added VARA HF modes
  * Fixed dark mode
  * Added 24-hour prediction
  * Added Maidenhead grid search
  * Changed default zoom level to work better with global maps
* Fldigi suite
  * Added flmsg and flamp
  * Added AmRRON forms to fldigi
  * Added zero configuration and PnP support for flmsg and flamp
* et-api - Updated version 1.3.0
* Winlink
  * Enabled listener by default for all modes to support P2P
* WSJT-X
  * Added PnP support for WSJT-X
* WINE
  * Updated add-on script to set registry keys
* SIGINT
  * Added Artemis (offline signal database)
* Misc
  * Added minimodem
  * Added Ventoy
* Security
  * Added GNU Privacy Agent (gpg)
  * Added AmRRON's public key
  * Added Paranoia File & Text Encryption
* Data Sets
  * Offline FCC data set updated as of March 2026
  * Offline SSN data set updated as of February 2026
  * Offline Winlink RMS data set updated as of February 2026
  * Added support offline Canadian callsigns (if address available)
* Offline Reference
  * S2 Underground - GhostNet
  * AmRRON - AIB resources
  * U.S. Maidenhead grid square
  * BPQ cheatsheet and U.S. node list
  * gpg quick reference
  * NATO phonetics quick reference
  * NOAA Weather Radio quick reference
  * Steganography quick reference
* Bug fixes
  * et-[uv-pro|vr-n76|th-d74] - Added better check for MAC address

## 2025.11.28.R5 (5.0.0) Release Notes

* Tier 1 radio PnP support
  * Lab599 TX-500MP via DigiRig Mobile
  * FX-4CR
  * Xiegu X6200
* Tier 2 radio PnP support
  * FTX-1 Field (CAT control only)
* SDR
  * rtl-sdr tools
  * dump1090 - ADS-B server
  * et-aircraft-app 1.1.0 - Offline aircraft tracking
  * SDR PnP support  - RTL-SDR v2, v3 and v4, ADS-B SDR
* Offline Raster Map Engine
  * mbtileserver 0.11.0 - Map tile server
  * mbutil 0.3.0 - Tool for creating raster tilesets in `.mbtiles` format
  * Open Street Maps tileset for US (zoom level 0 through 11)
  * Open Street Maps tileset for Canada (zoom level 0 through 10)
  * Open Street Maps tileset for World (zoom level 0 through 7)
* RF Prediction
  * voacap
  * splat!  
  * et-voacap - Offline command line HF prediction script
  * et-predict-app 1.2.0 - Offline graphical HF prediction application
* et-api - Java-based API used for various ETC services such as geo location and offline lookup services
* fldigi
* Misc
  * JS8Call - Update maidenhead grid based on et-api (GPS if available) or et-user
  * Mapping tools: QGIS, GPSBabel
  * Database: SQLite
* Data Sets
  * Offline FCC data set updated on 11/12/25
  * Offline SSN data set updated on 11/12/25
  * Offline Winlink RMS data set updated on 11/12/25  
* Bug fixes
  * LinBPQ - Changed PACKLEN and MAXFRAMES stability settings
  * udev - Disabled brltty service due to udev device hijacking
  * Winlink - Fixed position reports via GPS 
  * YAAC - Added larger heap to allow for larger OSM map imports
  * Updated various installer scripts to use a more robust download function (download_with_retries)

## 2025.04.01.R4 (4.0.0)

* Tier 1 radio PnP support
  * Yaesu FT-991A
* Tier 2 radio PnP support
  * Icom IC-7300
  * Elecraft KX2 (DigiRig Mobile)
* et-mode
  * BBS Client 1: Paracon (AGW radio terminal)
  * BBS Client 2: QtTermTCP (multi mode radio terminal)
  * BBS Server: 1200 baud packet node/BBS using LinBPQ 
  * Chattervox: Packet-based chat client
  * Added 300, 1200, and 9600 baud packet packet to direwolf
  * Added VARA HF and VARA FM mode selection if installed
* GPS PnP support
  * Dell 7220 (u-blox 8 receiver)
* Winlink
  * Enabled P2P listening for AX.25 and ARDOP
  * Updated RMS list as of 03/27/25
* Bluetooth TNC support
  * et-uv-pro: Support for BTECH UV Pro
  * et-vr-n76: support for Vero VGC NR-76
  * et-th-d74: support for Kenwood TH-D74
  * Added support for: axcall, QtTermTCP, Winlink, and YAAC
* WINE
  * Added basic installation of WINE
  * Added scripts (`~/add-on/wine/*.sh`) to install VARA HF/FM
* Misc
  * Added kiwix for offline Wikipedia and/or .zim browsing
  * et-user-backup: Performs ETC configuration backup
  * et-user-restore: Restores ETC configuration
  * Added misc tooling: pup, socat 
* Bug fixes
  * Updated OSM map downloader to work with updates to Geofabrik site
  * Fixed formatting of et-radio text output
  * Resolved inconsistent Conky startup behavior

## 2024.11.27.R3 (3.0.0)

* Plug-and-Play (PnP) support for CAT control, sound card, and GPS
* Tier 1 radio PnP support
  * Yaesu FT-818ND (DigiRig Mobile)
  * Yaesu FT-857D (DigiRig Mobile)
  * Yaesu FT-897D (DigiRig Mobile)
  * Icom IC-705
  * Icom IC-7100
* Tier 2 radio PnP support
  * DigiRig Lite (any radio with supported cable)
  * DigiRig Mobile with no CAT (any radio with supported cable)
  * Icom IC-7200
  * QRPLabs QMX
  * Xiegu G90 (DigiRig Mobile)
  * Yaesu FT-891 (DigiRig DR-891)
* GPS PnP support
  * Icom IC-705
  * VK-162 G-Mouse USB GPS - https://amzn.to/3XQqmYj
  * VK-172 G-Mouse USB GPS - https://amzn.to/3Ya7Viu
  * VFAN UG-353 - https://amzn.to/3XL2lSo 
* Automatic time synchronization via GPS
* Zero-configuration JS8Call launcher
  * Replace callsign, grid and sound card on every startup
  * Added @TTPNET call group
  * Prevent startup if no callsign defined via et-user
  * Prevent startup if no radio connected
  * If no GPS, reminder user to check time synchronization
  * Set default mode to normal
  * Show only message column in band activity window
  * Sort band activity by last heard station
  * Show only callsign, last heard, SNR, and offset in call activity window
  * Expire heard stations after 30 minutes in call activity window
  * Set ETC version in station info field
  * Hide waterfall controls
* Zero-configuration mode switcher
  * APRS Client (YAAC)
  * APRS Digipeater (Dire Wolf)
  * Packet Digipeater (Dire Wolf)
  * Winlink VHF/UHF (AX.25 packet)
  * Winlink HF (ARDOP)
* Added Conky for displaying system telemetry information
  * Date/time (local and UTC)
  * GPS time synchronization state
  * System resource utilization
  * Connected radio and connection state for CAT, GPS, and audio interface
  * Operator callsign and grid
  * Current mode of operation
* Radio Applications
  * ARDOP - amateur radio modem suitable for HF
  * Dire Wolf - Software-based packet TNC
  * Pat - Winlink client
  * YAAC - APRS client
* Misc Applications
  * Audio tools - Audacity, ffmpeg, sox
  * Development tools - Java 20, meld, vim 
  * Min - Web browser
  * Navit - Offline navigation
  * Paracon - Packet radio terminal emulator
* Added state-level (US only) OSM downloader to installer
* Utility scripts
  * et-device-info - Capture USB device information for PnP development
  * et-radio - Set active radio
  * et-mode - Communications mode switcher
  * et-system-info - Display system information
  * et-time - Display time synch information for GPS
  * et-user - Configure global operating settings
* Desktop notification messaging to user
* Use old-releases for apt repositories
* Basic post-installation test/validation suite
* Set terminal to high visibility color palette
* Upgraded DireWolf from 1.6 to 1.7

# 2024.05.19.R2

* Enabled Panasonic brightness fix
* Added motd
* Added GNOME settings for power management
* Added pbcopy and pbpaste command aliases
* Installed hamlib 4.5 from source
* Installed JS8Call 2.2.0 from Debian package


## 2024.03.16.R1

* Ported and adjusted initial scripts from commercial build
* Added `et-log` logger utility
* Enabled old-releases for apt source
* Installed base packages
* Installed initial build tools and image creation tools
* Replaced Firefox with Brave web browser
* Removed miscellaneous packages
* Installed EmComm Tools branding
* Applied initial GNOME settings
* Initial work to improve brightness issues on Panasonic hardware
