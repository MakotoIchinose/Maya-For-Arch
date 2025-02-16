#!/usr/bin/bash

source $PWD/scripts/uninstall.sh
source $PWD/scripts/common.sh

echo -e "\nSelect the version you want to uninstall"
echo "[1] Maya 2022"
echo "[2] Maya 2023"
echo "[3] Maya 2024"
echo -n "version: "
read VERSION

echo -n "Uninstall Autodesk Licensing Service? [Y/N]: "
read ADSK

echo -n "Enter your username: "
read NONROOT

HOME_DIR=/home/$NONROOT

case $VERSION in
    1 | 2022)
        VERSION=2022
    ;;

    2 | 2023)
        VERSION=2023
    ;;

    3 | 2024)
        VERSION=2024
    ;;
esac

uninstallMaya $VERSION
rmMayaDirs $VERSION $NONROOT

if [[ $ADSK == y || $ADSK == Y ]]; then
    systemctl stop adsklicensing
    systemctl disable adsklicensing
    uninstallAdsk
    rmAdskDirs $NONROOT
    rmAutodeskDirs $NONROOT
fi

echo -n "\nRemove cache directory? [y/N]: "
read CACHE

case $CACHE in
    [Yy])
        rm -rf cache
    ;;
    *)
    ;;
esac