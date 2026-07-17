# Emcomm Tools Configuration for Reticulum

EmComms Tools provides plug-and-play support to reduce the barrier to
entry for non-technical users. Reticulum is a very powerful tool for
building user-defined networks. This has the effect of allowing for
users to create sophisticated, end-to-end encrypted networks that can
leverage many different transport mediums. While this is powerful, it
has the potential for introducing complexity for new users. 

This document describes the approach that EmComm Tools takes for
supporting plug-and-play support with near-zero configuration.  

## Blueprint Configuration Files

EmComm Tools uses a _blueprint_ approach for defining a set of reference
network configurations to help new users get started.

config.blueprint.permanent-transport-node

## Replacement Tokens

Replacement tokens are defined by `{{TOKEN}}` where `TOKEN` is one of
the supported tokens below.

```
ET_CALLSIGN
ET_RETICULUM_INTERFACE_AUTO_ENABLED
ET_RETICULUM_INTERFACE_AX25KISS_ENABLED
ET_RETICULUM_INTERFACE_MERCURY_ENABLED
ET_RETICULUM_INTERFACE_MODEM73_ENABLED
```

* Valid characters are capitalized letters (`A-Z`)  and underscores (`_`).
* Start with the prefix: `ET_`.
* Reticulum specific tokens start with the prefix: `ET_RETICULUM_`.

The following replacement tokens are planned, but have not yet been
implemented.

```
ET_RETICULUM_INTERFACE_RNODE_BANDWIDTH
ET_RETICULUM_INTERFACE_RNODE_CODINGRATE
ET_RETICULUM_INTERFACE_RNODE_ENABLED
ET_RETICULUM_INTERFACE_RNODE_FREQUENCY
ET_RETICULUM_INTERFACE_RNODE_SPREADINGFACTOR
ET_RETICULUM_INTERFACE_RNODE_TXPOWER
```
