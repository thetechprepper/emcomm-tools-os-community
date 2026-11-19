## xara Source Package Requirements

Due to xara being discontinued by its developer, users wishing to
install the xara modem must obtain a copy of the original source code
repository and ensure that it is packaged as follows:
To use xara with the EmComm Tools installer:

1. Create a compressed source tarball named `xara-VERSION.tar.gz`
   (e.g., `xara-0.1.3.tar.gz`).

2. The archive must contain a single top-level directory named `xara`.

3. The directory structure must be:

   ```text
   xara
   |-- BUILDING.md
   |-- Cargo.lock
   |-- Cargo.toml
   |-- CHANGELOG.md
   |-- CONTRIBUTING.md
   |-- crates
   |-- dist
   |-- LICENSE
   |-- README.md
   |-- rustfmt.toml
   |-- scripts
   `-- vectors
   ```

4. Place the tarball in `emcomm-tools-os-community/scripts/`.
