---
title: "GNU Privacy Guard: Crypto Cheetsheet"
date: 2026-03-19
updated: 2026-03-19
author: [The Tech Prepper]
categories: [cryptography]
tags: [gpg, pgp]
copyright: "(C) 2026 The Tech Prepper, LLC"
---

This is an in-progress cheatsheet for performing basic cryptographic
functions using GNU Privacy Guard (gpg), including encrypting,
decrypting, and verifying files in an offline environment.

## Add Key

Import a public key into your keyring.

1. Download the public key from the trusted individual. It can be saved
   anywhere. For ease of backup, save them under `~/keys/`. Create this
   directory if it does not exist in your home directory.

2. Import the key file.

    gpg --import KEYFILE

3. Verify the key fingerprint. Your trusted source should provide you
   with the fingerprint.

    gpg --fingerprint

4. Optionally, edit the key and set the trust level. See the "Set Trust
   Level" section.

## List Keys

List the current public keys on your system.

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
- `unknown|full|ultimate` - See "Set Trust Levels"


List the current private keys on your system.

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

## Set Trust Levels

Here are common trust levels for basic use:

- `unknown`  - No trust assigned (default)
- `full`     - You trust this person to sign other keys
- `ultimate` - Your own key

Perform the following steps to change the trust level for a key.

1. List the keys and identify the key ID (KEYID).

    gpg --list-keys

2. Replace `KEYID` with the key ID to edit.

    gpg --edit-key KEYID

3. Type `trust` and press [ENTER].

4. Type the number for the desired trust level and press [ENTER].

5. Type `quit` to exit.
