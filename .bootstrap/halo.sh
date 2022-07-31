#!/bin/sh

# variables
dotfilesrepo="https://gitlab.com/hooregi/halofiles.git"
progsfile="https://gitlab.com/hooregi/halofiles/-/raw/main/.bootstrap/pkgs.csv"
aurhelper="paru"
repobranch="main"

# set up the bootloader
bootctl --path=/boot/ install

uuid=$(blkid -s UUID -o value /dev/sda2)
swap=$(filefrag -v /swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}')

[ ! -f /boot/loader/entries/halo.conf ] printf 'title   Halo Linux LTS
linux   /vmlinuz-linux-lts
initrd  /intel-ucode.img
initrd  /initramfs-linux-lts.img
options cryptdevice=UUID={$uuid}:cryptroot root=/dev/mapper/cryptroot rw resume=/dev/mapper/cryptroot resume_offset={$swap}' > /boot/loader/entries/halo.conf

[ ! -f /boot/loader/loader.conf ] && printf 'default       halo.conf
timeout       3
console-mode  max
editor        no' > /boot/loader/loader.conf

# set up trackpad

[ ! -f /etc/x11/xorg.conf.d/40-libinput.conf ] && printf 'Section "InputClass"
  Identifier "libinput touchpad catchall"
  Driver "libinput"
  MatchIsTouchpad "on"
  MatchDevicePath "/dev/input/event*"
  Option "Tapping" "on"
  Option "NaturalScrolling" "true"
EndSection' > /etc/x11/xorg.conf.d/40-libinput.conf
