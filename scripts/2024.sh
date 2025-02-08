#!/usr/bin/bash

# Install dependencies
# Argument 1: user name
function installDep2024()
{
    sudo -u $1 yay -Syu --noconfirm --needed \
    ld-lsb libxp gamin audiofile e2fsprogs \
    libmng flite speech-dispatcher cups libpng15 \
    xorg-fonts-75dpi xorg-fonts-100dpi ttf-liberation \
    libjpeg6-turbo ncurses5-compat-libs
}

# Convert all rpm packages
# from the current directory
function rpmToDeb2024()
{
    alien -d -c -v Maya/Packages/$(ls Maya/Packages/ | grep Substance | grep .rpm)
    alien -d -c -v Maya/Packages/$(ls Maya/Packages/ | grep Bifrost | grep .rpm)
    alien -d -c -v Maya/Packages/$(ls Maya/Packages/ | grep Maya2024_64 | grep .rpm)
    alien -d -c -v Maya/Packages/$(ls Maya/Packages/ | grep MayaUSD | grep .rpm)
    alien -d -c -v Maya/Packages/$(ls Maya/Packages/ | grep Pymel | grep .rpm)
}

# Move all deb packages from
# the current directory
# Argument 1: dest dir
function mvDebPkg2024()
{
    mv $(ls | grep substance | grep .deb) $1
    mv $(ls | grep bifrost | grep .deb) $1
    mv $(ls | grep maya2024 | grep .deb) $1
    mv $(ls | grep mayausd | grep .deb) $1
    mv $(ls | grep pymel | grep .deb) $1
}

# Convert all deb packages
# from the current directory
function debToZst2024()
{
    debtap -Q $(ls | grep substance | grep .deb)
    debtap -Q $(ls | grep bifrost | grep .deb)
    debtap -Q $(ls | grep maya2024 | grep .deb)
    debtap -Q $(ls | grep mayausd | grep .deb)
    debtap -Q $(ls | grep pymel | grep .deb)
}

# Install all packages from
# the current directory
function installPkg2024()
{
    pacman -U --noconfirm $(ls | grep maya2024 | grep .zst)
    pacman -U --noconfirm $(ls | grep mayausd | grep .zst)
    pacman -U --noconfirm $(ls | grep substance | grep .zst)
    pacman -U --noconfirm $(ls | grep bifrost | grep .zst)
    pacman -U --noconfirm $(ls | grep pymel | grep .zst)
}

# Install libraries from
# the current directory
# Argument 1: Installer root dir
function installLib2024()
{
    # Create Maya's lib folder
    mkdir -p /usr/autodesk/maya2024/lib

    # Copy libraries to Maya's lib folder
    cp -r $1/lib/libtiff/4.4.0-1/* /usr/autodesk/maya2024/lib/
    cp -r $1/lib/libjbig/2.1-23/* /usr/autodesk/maya2024/lib/
    cp -r $1/lib/libffi/3.1-3.1-32/* /usr/autodesk/maya2024/lib/

    # Link libraries to Maya's lib folder
    ln -s /usr/lib/libcrypt.so.2.0.0 /usr/autodesk/maya2024/lib/libcrypt.so.1

    # Create libmd.so into lib folder
    touch /usr/autodesk/maya2024/lib/libmd.so
}

# Delete all deb packages
# from the current directory
function rmDebPkg2024()
{
    rm -f $(ls | grep substance | grep .deb)
    rm -f $(ls | grep bifrost | grep .deb)
    rm -f $(ls | grep maya2024 | grep .deb)
    rm -f $(ls | grep mayausd | grep .deb)
    rm -f $(ls | grep pymel | grep .deb)
}

# Uninstall packages
function uninstallPkg2024()
{
    pacman -Rns --noconfirm $(pacman -Qm | grep substance | awk '{print $1}')
    pacman -Rns --noconfirm $(pacman -Qm | grep bifrost | awk '{print $1}')
    pacman -Rns --noconfirm $(pacman -Qm | grep pymel | awk '{print $1}')
    pacman -Rns --noconfirm $(pacman -Qm | grep mayausd | awk '{print $1}')
    pacman -Rns --noconfirm $(pacman -Qm | grep maya2024 | awk '{print $1}')
}
