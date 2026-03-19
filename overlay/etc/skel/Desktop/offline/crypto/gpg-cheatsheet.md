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
   with the fingerprint. From the example above, the fingerprint is the
   value starting with `77F8`.

    gpg --fingerprint

4. Optionally, edit the key and set the trust level. See the "Set Trust
   Level" section.

5. For an off-grid use case, where you trust the key, you can sign it
   youself to mark the key valid on your machine.

    gpg --lsign-key FINGERPRINT

Here's an example from EmComm Tools Community R6 that imports the AmRRON
public key.

```
$ gpg --import ~/Desktop/offline/nets/amrron/AmRRON_Actual_ECC_PUBLIC.asc
```


## List Public Keys

List the current public keys on your system.

```
gpg --list-keys
```

Use the following to interpret the keys listed:

- `pub` - Primary key
  - Your identity
  - Used for signing and certifying other keys
- `sub` - Subkey
  - Used for specific operations (usually encryption)
  - Can be replaced or rotated without changing identity
  - Can be revoked or rotated if compromised
- `[SC]` - Sign + Certify
- `[E]`  - Encrypt
- `unknown|full|ultimate` - See "Set Trust Levels"

Here's an example showing the AmRRON public key.

```
$ gpg --list-keys
/home/ham/.gnupg/pubring.kbx
-------------------------------
pub   ed25519 2023-05-25 [SC]
      77F888F3524F00C75FF9F91A8D518D7A50612239
uid           [ unknown] AmRRON Actual (ECC) <amrron@actual.net>
sub   cv25519 2023-05-25 [E]
```


## Verify Signature

There are two common types of signed files:

### 1. Embedded Signature

A single file that contains both the message and the signature. For
example, the AmRRON Intelligence Brief (AIB) uses an inline message.

    gpg --verify COMBINEDFILE


### 2. Detached Signature

A file and a separate signature file.

    gpg --verify SIGNATUREFILE FILE

Here's an example from EmComm Tools Community R6 that verifies that the
AIB distributed by AmRRON on the nationwide net on March, 16, 2026 was
created by AmRRON.

```
$ gpg --verify ~/Desktop/offline/nets/amrron/NATL-RR-260316-1330Z-AIB-sig.k2s 
gpg: Signature made Mon 16 Mar 2026 06:22:46 AM MST
gpg:                using EDDSA key 77F888F3524F00C75FF9F91A8D518D7A50612239
gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   1  trust: 0-, 0q, 0n, 0m, 0f, 1u
gpg: depth: 1  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 1f, 0u
gpg: Good signature from "AmRRON Actual (ECC) <amrron@actual.net>" [full]
```


## Create Key

Generate a new private/public key pair using ECC. It is a modern
standard that provides strong security and works well for radio use
due to smaller key sizes.

1. Create a primary key for signing using ECC. Replace FIRSTNAME,
   LASTNAME, and EMAIL (keep the < and > characters).

    gpg --quick-generate-key "FIRSTNAME LASTNAME <EMAIL>" ed25519 sign 0

2. List your keys and identify the fingerprint of your new key.

    gpg --list-keys

3. Generate an encryption subkey. Replace FINGERPRINT.

    gpg --quick-add-key FINGERPRINT cv25519 encrypt 0

4. List your keys again. You should now see a subkey that is suitable
   for encryption (`[E]`).

    gpg --list-keys


## List Private Keys

List the current private keys on your system.

```
gpg --list-secret-keys
```


## Sign File

Signing a file allows recipients to verify the sender is authentic
and that the file has not been modified in transit.

Create a test file:

    echo "This is a test file for gpg training." > file.txt

There are two common ways to sign a file.


### Embedded Signature

Create a single text file that contains both the message and the
signature.

    gpg --clearsign file.txt

This creates:

    file.txt.asc


### Detached Signature

Create a separate ASCII signature file for the original file.

    gpg --armor --detach-sign file.txt


## Encrypt / Decrypt File

Encryption protects a file so that only the intended recipient can
read it. Decryption restores the original file using your private key.

Create a test file:

    echo "This is a test file for gpg training." > file.txt


### Encrypt File

Encrypt a file for a specific recipient. Replace RECIPIENT with the
recipient email or key ID. This command also signs it (`-s`) and
encrypts the output as plain ASCII (`--armor`).

    gpg --armor -e -s -r RECIPIENT file.txt

This creates:

    file.txt.asc


### Decrypt File

Decrypt a file that was encrypted to you.

    gpg -d file.txt.asc > decrypted.txt

This creates:

    decrypted.txt


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


## Export Keys

If you need to back up your keys, export them as follows.

### Export Public Key

To export your public key for distribution, run the command below.
Replace EMAIL with the email address attached to the key. This file can
be shared with your community.

    gpg --export -a EMAIL > public.asc

### Export Private Key

WARNING: DO NOT SHARE THIS KEY WITH ANYONE.

    gpg --export-secret-keys -a EMAIL > private.asc

Restrict permissions to read-only for your user:

    chmod 400 private.asc

Store this file securely and be careful when moving it between systems.
