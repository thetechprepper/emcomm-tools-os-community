---
title: Reticulum Setup Notes
date: 2026-02-13
updated: 2026-05-11
author: [The Tech Prepper]
categories: [reticulum]
tags: [reticulum]
---

The following are my personal notes while workthrough an initial evaluation
of Reticulum for use over packet radio.

1. Install Python 3.
```
sudo apt install \
  python3 \
  python3-pip \
  -y
```

2. Add `~/.local/bin` to your PATH.

3. Install Reticulum as a non-priveleged user.
```
python3 -m pip install --user rns
```

4. Verify that the Reticulum daemon is installed correctly.
```
which rnsd
```

4. Start Reticulum. This will start the service and create an initial
   configuration file under `.reticulum/config`.
```
rnsd
```
	

5. Stop the service with `<CTRL>+C`.

6. Edit `~/.reticulum/config` and enable the AX.25 interface by 
   adding the KISS section below.
```
[interfaces]

  # This interface enables communication with other
  # link-local Reticulum nodes over UDP. It does not
  # need any functional IP infrastructure like routers
  # or DHCP servers, but will require that at least link-
  # local IPv6 is enabled in your operating system, which
  # should be enabled by default in almost any OS. See
  # the Reticulum Manual for more configuration options.

  # Default local LAN interface (keep this enabled for testing)
  [[Default Interface]]
    type = AutoInterface
    enabled = No

  [[Packet Radio AX25 KISS]]
    type = AX25KISSInterface
    enabled = Yes

    callsign = KT7RUN
    ssid = 2

    port = /tmp/kisstnc
    mtu = 256
```

7. Start Dire Wolf. In EmComm Tools, run `et-mode` and select
   `bbs-client`.

8. In another terminal, start Reticulum.
```
rnsd
```

If successful, you should see something like the following:
```
$ rnsd
[2026-02-14 12:59:02] [Notice]   Serial port /tmp/kisstnc is now open
[2026-02-14 12:59:02] [Notice]   Configuring KISS interface parameters...
[2026-02-14 12:59:02] [Notice]   KISS interface configured
[2026-02-14 12:59:02] [Notice]   Started rnsd version 1.1.3
```

## Install a Message App

1. Install NomadNet.
```
python3 -m pip install --user nomadnet
```

2. Start NomadNet.
```
nomadnet
```

## Add Identity

TODO
