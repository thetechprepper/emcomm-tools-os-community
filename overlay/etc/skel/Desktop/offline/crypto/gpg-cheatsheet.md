---
title: "GNU Privacy Guard: Crypto Cheetsheet"
date: 2026-03-19
updated: 2026-03-19
author: [The Tech Prepper]
categories: [cryptography]
tags: [pgp]
---

This is an in-progress cheatsheet for performing basic cryptographic
functions using GNU Privacy Guard (gpg), including encrypting,
decrypting, and verifying files in an offline environment.

## List Keys

List the current keys on your system.

```
gpg --list-keys
```

- `pub` - Primary key
  - Your identity (root of trust)
  - Used for signing and certifying other keys
- `sub` - Subkey
  - Used for specific operations (usually encryption)
  - Can be replaced or rotated without changing identity
  - Can be revoked or rotated if compromised
- `[SC]` - Sign + Certify
- `[E]`  - Encrypt
- Trust levels 
  - `unknown` - No trust assigned (default)
  - `full` - you trust this person to sign other keys
  - `ultimate` - Your own key

```
gpg --list-secret-keys
```

## Create Key

```
gpg --full-generate-key
```

## Encrypt File

```
gpg -e -r RECIPIENT file.txt
```

## Decrypt File

```
gpg -d file.txt.gpg
```

## Verify Signature

```
gpg --verify file.sig file.txt
```

```
gpg --verify file.asc
```
