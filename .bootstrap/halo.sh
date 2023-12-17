#!/bin/bash

localeconf() {
  ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
  hwclock --systohc
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
  echo "LANG=en_US.UTF-8" >> /etc/locale.conf
  locale-gen
  echo "FONT=Lat2-Terminus16" >> /etc/vconsole.conf
  echo "KEYMAP=us" >> /etc/vconsole.conf
}

hostsconf() {
  echo "halo" > /etc/hostname
  echo "127.0.0.1 localhost halo" >> /etc/hosts
  echo "::1 localhost halo" >> /etc/hosts
  echo "127.0.1.1 halo.localdomain halo" >> /etc/hosts
}

userconf() {
  passwd
  useradd -m hooregi
  passwd hooregi
  usermod -aG wheel hooregi 
  echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/hooregi
  echo "Defaults editor=/usr/bin/nvim" >> /etc/sudoers.d/hooregi
  chsh -s /bin/zsh "hooregi" >/dev/null 2>&1
}

paruconf() {
  sudo -u hooregi mkdir -p /home/hooregi/.local/src
  chown -R hooregi:wheel "$(dirname /home/hooregi/.local/src)"
  cd /home/hooregi/.local/src
  sudo -u hooregi git clone https://aur.archlinux.org/paru.git
  cd paru
  sudo -u hooregi makepkg --noconfirm -si
  cd ..
}

installconf() {
  progsfile="https://raw.githubusercontent.com/hooregi/halofiles/main/.bootstrap/pkgs.csv"

  ([ -f "$progsfile" ] && cp "$progsfile" /tmp/pkgs.csv) ||
    curl -Ls "$progsfile" | sed '/^#/d' > /tmp/pkgs.csv

    while IFS=, read -r tag program comment; do
      n=$((n + 1))
      case "$tag" in
        "A") sudo paru -S "$program" --noconfirm >/dev/null 2>&1 ;;
        "G") git clone "$program" && cd "$(basename "$program" .git)" && make clean install && cd .. ;;
        *) pacman --noconfirm --needed -S "$program" >/dev/null 2>&1 ;;
      esac
    done < /tmp/pkgs.csv
}

mkinitcpioconf() {
  sed -i '/^MODULES=/c\MODULES=(vboxdrv)' /etc/mkinitcpio.conf
  sed -i '/^FILES=/c\FILES=(/etc/modprobe.d/nobeep.conf)' /etc/mkinitcpio.conf
  sed -i '/^HOOKS=/c\HOOKS=(base udev autodetect modconf kms keyboard keymap block encrypt resume filesystems fsck)' /etc/mkinitcpio.conf
  echo "blacklist pcspkr" >> /etc/modprobe.d/nobeep.conf
  mkinitcpio -P
}

bootconf() {
  bootctl --path=/boot/ install
  uuid=$(blkid -s UUID -o value /dev/nvme0n1p2)
  swap=$(filefrag -v /swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}')

  [ ! -f /boot/loader/entries/halo.conf ] && printf "title Halo Linux
  linux /vmlinuz-linux
  initrd /amd-ucode.img
  initrd /initramfs-linux.img
  options cryptdevice=UUID=${uuid}:cryptroot root=/dev/mapper/cryptroot resume=/dev/mapper/cryptroot resume_offset=${swap} rw mem_sleep_default=s2idle" > /boot/loader/entries/halo.conf

  [ ! -f /boot/loader/loader.conf ] && printf 'default halo.conf
  timeout 3
  console-mode max
  editor no' > /boot/loader/loader.conf
}

servicesconf() {
  for service in acpid avahi-daemon bluetooth iwd nordvpnd systemd-networkd systemd-resolved thermald tlp; do
    systemctl enable "$service"
  done; unset service
}

miscconf() {
  # set up trackpad
  [ ! -f /etc/X11/xorg.conf.d/40-libinput.conf ] && printf 'Section "InputClass"
Identifier "libinput touchpad catchall"
Driver "libinput"
MatchIsTouchpad "on"
MatchDevicePath "/dev/input/event*"
Option "Tapping" "on"
Option "NaturalScrolling" "true"
EndSection' > /etc/X11/xorg.conf.d/40-libinput.conf

  # disable bluetooth autostart
  sed -i 's/^#AutoEnable=true/AutoEnable=false/' /etc/bluetooth/main.conf

  # fix DNS issue
  rm /etc/resolv.conf
  ln -s /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

  # pacman bootctl hook
  mkdir /etc/pacman.d/hooks
  [ ! -f /etc/pacman.d/hooks/95-systemd-boot.hook ] && printf '[Trigger]
Type = Package
Operation = Upgrade
Target = systemd

[Action]
Description = Updating systemd-boot
When = PostTransaction
Exec = /usr/bin/bootctl update' > /etc/pacman.d/hooks/95-systemd-boot.hook

  # pacman user.js hook
  [ ! -f /etc/pacman.d/hooks/10-arkenfox-update.hook ] && printf '[Trigger]
Type = Package
Operation = Upgrade
Target = firefox

[Action]
Description = Updating user.js
When = PostTransaction
Exec = /home/hooregi/.local/bin/arkenfox_updater' > /etc/pacman.d/hooks/10-arkenfox-update.hook

  # pacman conf
  sed -i "/^#Color/s/^#//" /etc/pacman.conf
  sed -i "/^#VerbosePkgLists/s/^#//" /etc/pacman.conf
  sed -i "/^#ParallelDownloads =/c\ParallelDownloads = 15" /etc/pacman.conf
  echo "ILoveCandy" >> /etc/pacman.conf

  # wired interface configuration
  [ ! -f /etc/systemd/network/20-wired.network ] && printf '[Match]
Name=enp4s0f3u1u4

[Network]
DHCP=yes' > /etc/systemd/network/20-wired.network

  # wireless interface configuration
  [ ! -f /etc/systemd/network/25-wireless.network ] && printf '[Match]
Name=wlan0

[Network]
DHCP=yes
IPv6PrivacyExtensions=True' > /etc/systemd/network/25-wireless.network

  # startx autologin
  mkdir /etc/systemd/system/getty@tty1.service.d
  [ ! -f /etc/systemd/system/getty@tty1.service.d/autologin.conf ] && printf '[Service]
ExecStart=
ExecStart=-/sbin/agetty -o "-p -f -- \\u" --noclear --autologin hooregi \%I $TERM' > /etc/systemd/system/getty@tty1.service.d/autologin.conf

  # setting up nordvpn
  gpasswd -a hooregi nordvpn
}

# actual script
localeconf
hostsconf
pacman --noconfirm -Sy archlinux-keyring
userconf
paruconf
installconf
mkinitcpioconf
bootconf
servicesconf
miscconf
cd /home/hooregi
git clone https://github.com/hooregi/halofiles.git
cd /home/hooregi/halofiles/
stow .
rm -rf /halofiles

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
