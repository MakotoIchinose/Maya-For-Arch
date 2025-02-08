#!/usr/bin/bash

source $PWD/scripts/2022.sh
source $PWD/scripts/2023.sh
source $PWD/scripts/2024.sh
source $PWD/scripts/adsk.sh

# Convert Maya packages
# Argument 1: version
# Argument 2: dest dir
function convertMaya()
{
    case $1 in
        2022)
            rpmToDeb2022
            mvDebPkg2022 $2
            cd $2
            debToZst2022
        ;;

        2023)
            rpmToDeb2023
            mvDebPkg2023 $2
            cd $2
            debToZst2023
        ;;

        2024)
            rpmToDeb2024
            mvDebPkg2024 $2
            cd $2
            debToZst2024
        ;;
    esac
}

# Convert Adsk packages
# Argument 1: dest dir
function convertAdsk()
{
    rpmToDebAdsk
    mvDebPkgAdsk $1
    cd $1
    debToZstAdsk
}
