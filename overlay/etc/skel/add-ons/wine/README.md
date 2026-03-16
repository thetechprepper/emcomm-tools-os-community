# Installing Windows Applications

The following instructions only need to be run once. They should be run
in this directory as your normal user (do not use 'sudo').

1. Install the WINE dependencies.

    ./01-install-wine-deps.sh

2. Install VARA HF. Accept the default settings and uncheck Launch My Program
   when prompted during the installation.

    ./02-install-vara-hf.sh

3. Install VARA FM. Accept the default settings and uncheck Launch My Program
   when prompted during the installation.

    ./03-install-vara-fm.sh

4. Run the registry editor. Follow the instructions in the terminal. In 
   this step we will need to map COM port 10 (COM10) to the EmComm Tools
   CAT control device (/dev/et-cat).

    ./04-run-regedit.sh

5. If you want to include your WINE installation in a future EmComm Tools
   Community image build, run the following to make a backup of your WINE
   installation now.

    ./05-backup-wine-install.sh

It is important that you do not run any of the VARA programs until after
the backup is run in step 5.

## Including VARA in an ETC ISO image

If you want to include VARA in a future EmComm Tools Community image build,
perform the following in Cubic after the main install script is finished.

1. Change into the `/etc/skel` directory.

2. Copy the WINE backup file created in step 5 using the file copy option
   in Cubic (i.e. `etc-wine-backup-HOST-YYYYMMDD.tar.gz`).

3. Unpack the backup file. This will create `/etc/skel/.wine32`.

```
tar -xzf etc-wine-backup-*
```

4. Delete the backup file on the Cubic session to save on space.

```
rm etc-wine-backup-*
```
