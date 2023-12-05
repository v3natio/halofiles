#!/bin/sh

# variables
dotfilesrepo="https://github.com/hooregi/halofiles.git"
progsfile="https://github.com/hooregi/halofiles/raw/main/.bootstrap/pkgs.csv"
aurhelper="paru"
repobranch="main"

installationloop() {
    # Check if the CSV file exists locally, if not fetch it
    if [ -f "$progsfile" ]; then
        cp "$progsfile" /tmp/progs.csv
    else
        echo "CSV file not found!"
        return 1
    fi

    total=$(wc -l </tmp/progs.csv)
    
    # Loop through the CSV and install based on tag
    while IFS=, read -r tag program comment; do
        # Remove quotes around the comment if they exist
        echo "$comment" | grep -q "^\".*\"$" && comment="$(echo "$comment" | sed -E "s/(^\"|\"$)//g")"

        case "$tag" in
            "A") 
                # Command to install AUR packages
                echo "Installing AUR package: $program"
                paru -S "$program" --noconfirm
                ;;
            "G") 
                # Command to git clone and then make clean install
                echo "Cloning and installing git package: $program"
                git clone "$program" && cd "$(basename "$program" .git)" && make clean install && cd ..
                ;;
            *) 
                # Command for packages without a tag (using pacman)
                echo "Installing package using pacman: $program"
                pacman -S "$program" --noconfirm
                ;;
        esac
    done </tmp/progs.csv
}

# set up trackpad
[ ! -f /etc/x11/xorg.conf.d/40-libinput.conf ] && printf 'Section "InputClass"
  Identifier "libinput touchpad catchall"
  Driver "libinput"
  MatchIsTouchpad "on"
  MatchDevicePath "/dev/input/event*"
  Option "Tapping" "on"
  Option "NaturalScrolling" "true"
EndSection' > /etc/x11/xorg.conf.d/40-libinput.conf
