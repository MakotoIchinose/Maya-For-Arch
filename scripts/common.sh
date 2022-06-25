#!/usr/bin/bash

# Enable adks licensing
function adskLic()
{
    getent group adsklic &>/dev/null || sudo groupadd adsklic
    id -u adsklic &>/dev/null || sudo useradd -M -r -g adsklic adsklic -d / -s /usr/bin/nologin
    systemctl enable adsklicensing --quiet
    systemctl start adsklicensing
}

# Install Arnold for Maya
# from the current directory
# Argument 1: version
# Argument 2: Installer root dir
function installMtoA()
{
    cd $2/Maya/Packages
    python2 ./unix_installer.py $1 linux silent
}

# Remove the pkg directory
# Argument 1: Installer root dir
function rmPkg()
{
    echo -n "Remove converted packages? [Y/N]: "
    read INPUT

    cd $1

    case $INPUT in

    y | Y)
       rm -r pkg
       ;;

    *)
       echo " "
       ;;
esac
}

# Set the env file
# Argument 1: version
# Argument 2: user name
function setEnv()
{
    sudo -u $2 mkdir -p /home/$2/maya/$1

    sudo -u $2 echo -e "MAYA_OPENCL_IGNORE_DRIVER_VERSION=1\nMAYA_CM_DISABLE_ERROR_POPUPS=1\nMAYA_COLOR_MGT_NO_LOGGING=1\nTMPDIR=/tmp" \
    > /home/$2/maya/$1/Maya.env

    chown $2:$2 /home/$2/maya/$1/Maya.env
}
