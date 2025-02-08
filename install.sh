#!/bin/bash

source $PWD/scripts/dependencies.sh
source $PWD/scripts/convert.sh
source $PWD/scripts/install.sh
source $PWD/scripts/clean.sh
source $PWD/scripts/alien.sh

echo -e "\n====== Maya For Arch by MyHCel ======\n"
echo -e "\n        Modified by IchinoseP        \n"

echo "Select the version you want to install"
echo "[1] Maya 2022"
echo "[2] Maya 2023"
echo -n "version: "
read VERSION

echo -n "Install Autodesk Licensing Service? [Y/N]: "
read ADSK

echo -n "Enable logging of this installation? Type D for explicit debugging [Y/N/D]: "
read LOGGING

echo -n "Enter your username: "
read NONROOT

case $VERSION in
    1 | 2022)
        VERSION=2022
    ;;

    2 | 2023)
        VERSION=2023
    ;;
esac

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")  # Generate timestamp
log_file="log_$timestamp.log"  # Define log filename

case $LOGGING in
    [Yy])
        echo "Logging enabled. Output will be saved to $log_file"
        exec > >(tee "$log_file") 2>&1
    ;;
    [Dd])
        echo "Logging with bash debug enabled. Output will be saved to $log_file"
        set -x
        exec > >(tee "$log_file") 2>&1
    ;;
    *)
    ;;
esac

ROOT_DIR=$PWD
PKG=$ROOT_DIR/pkg
VERSION2=$VERSION

CACHE=$ROOT_DIR/cache
CACHE_MAYA=$CACHE/$VERSION
CACHE_ADSK=$CACHE/adsk
CACHE_MAYA_FLAG=0
CACHE_ADSK_FLAG=0

installDep $VERSION $NONROOT
sudo -u $NONROOT mkdir $CACHE

# Check if Maya cache exists
if [[ $(ls $CACHE | grep $VERSION) != "" ]]; then
    CACHE_MAYA_FLAG=1
fi

# Check if Adsk cache exists
if [[ $(ls $CACHE | grep adsk) != "" ]]; then
    CACHE_ADSK_FLAG=1
fi

if [[ $ADSK == n || $ADSK == N ]]; then
    CACHE_ADSK_FLAG=1
fi

# Create pkg folder and install utilities
if [[ $CACHE_MAYA_FLAG == 0 || $CACHE_ADSK_FLAG == 0 ]]; then
    sudo -u $NONROOT mkdir $PKG
    installUtil $NONROOT

    # Check if alien can be detected
    checkForAlien
fi

# Install adsk
if [[ $ADSK == y || $ADSK == Y ]]; then
    # Install
    if [[ $CACHE_ADSK_FLAG == 0 ]]; then
        # Extract files
        sudo -u $NONROOT tar zxvf $(ls | grep Adsk | grep .gz) -C .
        convertAdsk $PKG
    else
        PKG=$CACHE_ADSK
    fi

    installAdsk $PKG

    if [[ $CACHE_ADSK_FLAG == 0 ]]; then
        cleanAdsk $PKG $ROOT_DIR
        sudo -u $NONROOT mkdir $CACHE_ADSK
        cachePkg $NONROOT $PKG $CACHE_ADSK $ROOT_DIR
    fi

    PKG=$ROOT_DIR/pkg
fi

# Extract Maya files
cd $ROOT_DIR
sudo -u $NONROOT mkdir Maya
sudo -u $NONROOT tar zxvf $(ls | grep Maya | grep .tgz) -C Maya

# Install Maya

if [[ $CACHE_MAYA_FLAG == 0 ]]; then
    convertMaya $VERSION $PKG
else
    PKG=$CACHE_MAYA
fi

installMaya $VERSION $NONROOT $PKG $ROOT_DIR
cleanMaya $VERSION2 $PKG $ROOT_DIR

if [[ $CACHE_MAYA_FLAG == 0 ]]; then
    sudo -u $NONROOT mkdir $CACHE_MAYA
    cachePkg $NONROOT $PKG $CACHE_MAYA $ROOT_DIR
fi

PKG=$ROOT_DIR/pkg
cd $ROOT_DIR && rm -rf $PKG

echo "Done C:"
