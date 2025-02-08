#!/usr/bin/bash

source $PWD/scripts/2022.sh
source $PWD/scripts/2023.sh
source $PWD/scripts/2024.sh
source $PWD/scripts/adsk.sh

# Uninstall Maya packages
# Argument 1: version
function uninstallMaya()
{
    case $1 in
        2022)
            uninstallPkg2022
        ;;

        2023)
            uninstallPkg2023
        ;;
        2024)
            uninstallPkg2024
        ;;
    esac
}

# Uninstall Adsk packages
function uninstallAdsk()
{
    uninstallPkgAdsk
}
