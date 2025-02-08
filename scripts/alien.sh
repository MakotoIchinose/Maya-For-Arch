#!/usr/bin/bash

# Sometimes alien doesn't get detected in sudo terminals
# especially in KDE Konsole with zsh.
function checkForAlien() 
{
    echo "Checking for alien command..."

    if ! command -v "alien" &> /dev/null; then
        echo "alien command invalid for this sudo. Exporting vendor_perl to PATH..."
        export PATH=$PATH:/usr/bin/vendor_perl
    fi
}