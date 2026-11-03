---
title: Obtaining Weather Forecasts Off-Grid Using FTPmail
description: >-
  How to obtain weather information in the U.S. via Winlink
date: 2026-01-05
author: gaston
categories: [howto, weather, winlink]
tags: [weather, winlink, noaa]
---

## Background

Long before smartphones, apps, and high-speed Internet, weather
information was still critical. Mariners and remote operators often
worked far from reliable land-based communications. In the early 1990s,
the World Wide Web was young, slow, or simply unavailable to many users.

Back then, access to email was often possible even when a full Internet
connection was not available. This reality shaped the development of
some very clever systems that allowed people to request data using
nothing more than an email client with specially crafted messages.

Some of those systems still exist today. In fact, the U.S. National
Weather Service (NWS) offers one of these services in 2026 called
"FTPmail".

As amateur radio operators working off-grid, we often find ourselves in
a similar situation as mariners at sea. We have field power, a radio,
and email access via Winlink, but no direct access to the Internet.


## What is FTP and FTPmail?

FTP, or File Transfer Protocol, is one of the oldest tools on the
Internet. It was designed to move files between computers using simple
commands. The NWS still publishes daily weather forecast information
to their FTP server (`tgftp.nws.noaa.gov`).

FTP is great if you have direct access to the Internet, but like the
early 90s and our mariner friends, this is not always the case.

FTPmail was an ingenious solution to this problem. It allows a user
to request information from an FTP server via a specially crafted email.
Instead of connecting directly to an FTP server, a user sends an email
containing a short list of FTP commands. The FTPmail service then
issues these commands on the user's behalf and replies with the
requested files.


## How FTP works?

For those with Internet access, weather information can be retrieved by
connecting to the NWS FTP server. For example, here is a full terminal
session using the `ftp` command.

```
$ ftp tgftp.nws.noaa.gov
Connected to tgftp-bldr.ncep.noaa.gov.
220-******************************************************************
                  **WARNING**WARNING**WARNING**
 This is a United States (Agency) computer system, which may be accessed
 and used only for official Government business by authorized personnel.
 Unauthorized access or use of this computer system may subject violators
 to criminal, civil, and/or administrative action.
 All information on this computer system may be intercepted, recorded,
 read, copied, and disclosed by and to authorized personnel for official
 purposes, including criminal investigations. Access or use of this
 computer system by any person whether authorized or unauthorized,
 constitutes consent to these terms.
                 **WARNING**WARNING**WARNING**
 ******************************************************************
 
220 
Name (tgftp.nws.noaa.gov:gaston): anonymous
331 Anonymous login ok, send your complete email address as your password
Password: 
230 Login successful.
Using binary mode to transfer files.
ftp>
ftp> cd data
ftp> cd forecasts
ftp> cd state
ftp> cd az
ftp> get azz541.txt
local: azz541.txt remote: azz541.txt
150 Opening BINARY mode data connection for azz541.txt (1913 bytes)
100% |*************************************|  1913      916.66 KiB/s    00:00 ETA
226 Transfer complete
1913 bytes received in 00:00 (36.46 KiB/s)
ftp> quit
221 Goodbye.
```

In short, I performed the following steps:

1. Connected to the NWS FTP server over the Internet.
2. Read the scary government warning message (welcome message).
3. Logged in as an `anonymous` user. I entered a valid email address as
   the password (for example, `foo@bar.com`).
4. Issued the `cd` command several times to change into the directory
   (`data/forecasts/state/az`) containing the weather forecasts for
   Arizona.
5. Downloaded the 5-day weather forecast for zone "541" using the `get`
   command.
6. Logged out with the `quit` command.

The file `azz541.txt` is a simple plain text file containing the 5-day
weather forecast for Maricopa County.


## How FTPmail works?

FTPmail works by acting as a middleman between email and an FTP server.
Instead of connecting over the Internet via FTP, the user sends an email
to the FTPmail server contain the FTP commands in the email body, one
line per command.

To request the file from the last section over email, compose the
following email.

**To:** NWS.FTPMail.OPS@noaa.gov

**Subject:** [Put whatever you want here]

**Body:**

```
open
cd data
cd forecasts
cd state
cd az
get azz541.txt
quit
```

That's it. Send it, wait a few minutes, and recheck your email. You
should receive a response from the NWS with the weather forecast for the
zone you requested.


## What's my forecast zone?

This is where pre-planning is required. You need to know your "forecast
zone" in advance (that is, before you need it).

Visit the [Public Zone Maps](https://www.weather.gov/pimar/PubZone) and
download the map for your state and find your three-digit forecast zone.

Next, I suggest logging into the NWS FTP server and testing the commands
to changing into the directories and fetch the appropriate file.

**Note:** Always ensure that you have `open` as the first line, 
followed by the remaining FTP commands in your email body.


##  Summary 

In 2025, FTPmail is not a replacement for modern weather tools. When the
Internet is available, web-based forecasts and apps are more convenient.

However, FTPmail shines as a fallback.

I suggest treating it as a tool of last resort that you practice using
before you need it. Learn the directory structure. Save example request
messages. Keep notes on the forecast zones relevant to your area.

Most importantly, test it over radio!

There is something deeply satisfying about pulling down an official NWS
forecast using nothing but a radio, a laptop, and a plain text email.
It feels like a small connection to an earlier era of the Internet,
when efficiency and simplicity mattered.


## Resources

* [FTPmail Help](https://tgftp.nws.noaa.gov/ftpmail.txt)
* [Forecast Zones Maps](https://www.weather.gov/media/pimar/PubZone)
* [Zone-county correlation file](https://www.weather.gov/gis/ZoneCounty)


## Support

If you like this content, please consider supporting me on
[Buy Me a Coffee](https://buymeacoffee.com/thetechprepper). I rely on
member support to create this content and develop off-grid software.
