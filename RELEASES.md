# EmComm Tools OS Community Release

# 2024.11.27.R3 (3.0.0)

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
