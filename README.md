# Maya For Arch

## About

Maya For Arch is a simple script that helps you install Autodesk Maya on Arch Linux (and perhaps on Arch based distros).

## Dependencies

These are the dependencies needed by the script.

* yay
* debhelper
* Lots of time

## How to use it

Note: Depending on your processor, converting the rpm packages may take quite some or a painful amount of time to finish. Be patient!

1. Download Maya for Linux from https://www.autodesk.com/

1. Download Autodesk Licensing Service [here](https://knowledge.autodesk.com/search-result/caas/downloads/content/autodesk-licensing-service-download.html) (only if you don't have it installed or want to update it).

1. Clone this project wherever you like on your PC.

   ```bash
   git clone https://github.com/MakotoIchinose/Maya-For-Arch.git
   ```

1. Cd into Maya-For-Arch

   ```bash
   cd Maya-For-Arch
   ```

1. Put the "Autodesk_Maya.tgz" and the "AdskLicensingInstaller.tar.gz" (optional based on step 2) 
   files in the "Maya-For-Arch" folder.

1. Execute the installer script.

   Note: This will update your system and install all required dependecies. If you don't want
   to update your system, modify the "installDep 'version' () function" in "scripts/'version'.sh"

   ```bash
   sudo ./install.sh
   ```

1. Select the Maya version you want to install.

   ```
   Select the version you want to install
   [1] Maya 2022
   [2] Maya 2023
   [3] Maya 2024
   version:
   ```

1. Choose based in your decision in step 2.

   ```
   Install Autodesk Licensing Service? [Y/N]:
   ```

1. Choose whether you want to enable logging during installation. This is useful to check if something went wrong during the installation process.

   ```
   Enable logging of this installation? Type D for explicit debugging [Y/N/D]: 
   ```

   Choosing D will enable bash verbose debugging in the terminal, meaning it'll log the command it tries to run.

1. Enter your user name (same as your home folder)

   ```bash
   Enter your username:
   ```

   1. If the script does not execute, chmod all ".sh" files

   ```bash
   chmod +x install.sh
   ```
   ```bash
   chmod +x uninstall.sh
   ```
   ```bash
   chmod +x -R scripts
   ```

1. Maya should now be up and running!

1. Note: The converted packages are saved 
    in case you need to reinstall the software.

    If you want to install an update 
    (eg. Maya 2022 is installed and you want to install 2022.3 
    or you want to update Autodesk Licensing Service) first delete 
    the corresponding cached files.

    ```bash
    rm -rf Maya-For-Arch/cache/<Maya version> # Delete this folder to update that version of Maya.
    rm -rf Maya-For-Arch/cache/adsk # Delete this folder to update Autodesk Licensing Service.
    ```

## Uninstalling Maya

1. Execute the uninstall script

   ```
   sudo ./uninstall.sh
   ```

1. Select the Maya version you want to uninstall.

   ```bash
    Select the version you want to uninstall
    [1] Maya 2022
    [2] Maya 2023
    [3] Maya 2024
    version:
   ```

1. If you are going to install another version of Maya (or if other Autodesk software needs it), 
   you should not uninstall Autodesk Licensing Service. Otherwise, you can uninstall it.

   ```bash
   Uninstall Autodesk Licensing Service? [Y/N]:
   ```

1. Enter your username (same as your home folder)

   ```bash
   Enter your username:
   ```

## Updates

* Improved the script's structure.
* Improved installation of Autodesk Licensing Service.
* Added package cache.
* Fixed libtiff error.
* Fixed libpng12 error in 2022 (only appears when crashing).
* Fixed home screen not working (not really, it just gets disabled :p).
* Fixed crash when using Mesa drivers.
* Added Maya 2023
* Removed Maya 2020 as it's no longer available through normal means
* Added install logging feature w/ bash debugging
* Update Autodesk Licensing Service install to use Autodesk Identity Manager

## Known issues

* Maya will crash when trying to activate the software with a serial key.

* Pymel for Maya 2022 throws warnings when executing a Python script when installing.

* The home screen of Maya 2022 and 2023 does not work.

* The mtoh.so plug-in will give and error saying that "hdArnold.so" could not
  find "libai.so"

* Hypothetically the updated Autodesk Licensing Manager might cause issue with versions
  prior to 2024.

* debhelper could fail to install as dependencies. It's advised to install it manually before running the install script.

## I think that's all

If you find any issues, let me know. I'll try to fix them  c:
