#!/bin/bash

localeconf() {
  ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
  hwclock --systohc
  echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen
  echo "LANG=en_US.UTF-8" >>/etc/locale.conf
  locale-gen
  echo "FONT=Lat2-Terminus16" >>/etc/vconsole.conf
  echo "KEYMAP=us" >>/etc/vconsole.conf
}

hostsconf() {
  echo "halo" >/etc/hostname
  echo "127.0.0.1 localhost halo" >>/etc/hosts
  echo "::1 localhost halo" >>/etc/hosts
  echo "127.0.1.1 halo.localdomain halo" >>/etc/hosts
}

userconf() {
  echo root:password | chpasswd
  useradd -m venatio
  echo venatio:password | chpasswd
  usermod -aG wheel venatio
  echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >>/etc/sudoers.d/venatio
  echo "Defaults editor=/usr/bin/nvim" >>/etc/sudoers.d/venatio
  chsh -s /bin/zsh "venatio" >/dev/null 2>&1
}

paruconf() {
  sudo -u venatio mkdir -p /home/venatio/.local/src
  chown -R venatio:wheel "$(dirname /home/venatio/.local/src)"
  cd /home/venatio/.local/src
  sudo -u venatio git clone https://aur.archlinux.org/paru.git
  cd paru
  sudo -u venatio makepkg --noconfirm -si
  cd ..
}

installconf() {
  progsfile="https://raw.githubusercontent.com/v3natio/halofiles/main/.bootstrap/pkgs.csv"

  ([ -f "$progsfile" ] && cp "$progsfile" /tmp/pkgs.csv) ||
    curl -Ls "$progsfile" | sed '/^#/d' >/tmp/pkgs.csv

  while IFS=, read -r tag program comment; do
    case "$tag" in
    "A")
      echo "Installing $program from the AUR. $comment"
      sudo -u venatio paru -S "$program" --noconfirm >/dev/null 2>&1
      ;;
    "G")
      echo "Installing $program from Git. $comment"
      git clone "$program" && cd "$(basename "$program" .git)" && make clean install && cd ..
      ;;
    *)
      echo "Installing $program from Arch repos. $comment"
      pacman --noconfirm --needed -S "$program" >/dev/null 2>&1
      ;;
    esac
  done </tmp/pkgs.csv
}

mkinitcpioconf() {
  sed -i '/^MODULES=/c\MODULES=(amdgpu vboxdrv)' /etc/mkinitcpio.conf
  sed -i '/^FILES=/c\FILES=(/etc/modprobe.d/nobeep.conf)' /etc/mkinitcpio.conf
  sed -i '/^HOOKS=/c\HOOKS=(base udev autodetect microcode modconf kms keyboard keymap block encrypt resume filesystems fsck)' /etc/mkinitcpio.conf
  echo "blacklist pcspkr" >>/etc/modprobe.d/nobeep.conf
  mkinitcpio -P
}

bootconf() {
  bootctl --path=/boot/ install
  uuid=$(blkid -s UUID -o value /dev/nvme0n1p2)
  swap=$(filefrag -v /swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}')

  [ ! -f /boot/loader/entries/halo.conf ] && printf "title Halo Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options cryptdevice=UUID=${uuid}:cryptroot root=/dev/mapper/cryptroot resume=/dev/mapper/cryptroot resume_offset=${swap} rw mem_sleep_default=s2idle" >/boot/loader/entries/halo.conf

  rm -rf /boot/loader/loader.conf
  [ ! -f /boot/loader/loader.conf ] && printf 'default halo.conf
timeout 3
console-mode max
editor no' >/boot/loader/loader.conf
}

servicesconf() {
  for service in acpid avahi-daemon bluetooth iwd nordvpnd systemd-boot-update systemd-networkd systemd-resolved thermald tlp; do
    systemctl enable "$service"
  done
  unset service
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
EndSection' >/etc/X11/xorg.conf.d/40-libinput.conf

  # disable bluetooth autostart
  sed -i 's/^#AutoEnable=true/AutoEnable=false/' /etc/bluetooth/main.conf

  # pacman bootctl hook
  mkdir /etc/pacman.d/hooks
  [ ! -f /etc/pacman.d/hooks/95-systemd-boot.hook ] && printf '[Trigger]
Type = Package
Operation = Upgrade
Target = systemd

[Action]
Description = Updating systemd-boot
When = PostTransaction
Exec = /usr/bin/systemctl restart systemd-boot-update.service' >/etc/pacman.d/hooks/95-systemd-boot.hook

  # pacman conf
  sed -i "/^#Color/s/^#//" /etc/pacman.conf
  sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
  sed -i "/^#VerbosePkgLists/s/^#//" /etc/pacman.conf
  sed -i "/^#ParallelDownloads =/c\ParallelDownloads = 15" /etc/pacman.conf

  # wired interface configuration
  [ ! -f /etc/systemd/network/20-wired.network ] && printf '[Match]
Name=enp4s0f3u1u4

[Network]
DHCP=yes' >/etc/systemd/network/20-wired.network

  # wireless interface configuration
  [ ! -f /etc/systemd/network/25-wireless.network ] && printf '[Match]
Name=wlan0

[Network]
DHCP=yes
IPv6PrivacyExtensions=True' >/etc/systemd/network/25-wireless.network

  # startx autologin
  mkdir /etc/systemd/system/getty@tty1.service.d
  [ ! -f /etc/systemd/system/getty@tty1.service.d/autologin.conf ] && printf '[Service]
ExecStart=
ExecStart=-/sbin/agetty -o "-p -f -- \\u" --noclear --autologin venatio %%I $TERM' >/etc/systemd/system/getty@tty1.service.d/autologin.conf

  # setting up nordvpn
  gpasswd -a venatio nordvpn
}

homeconf() {
  cd /home/venatio
  mkdir -p .config
  touch .config/placeholder.txt
  git clone https://github.com/v3natio/halofiles.git
  cd /home/venatio/halofiles/
  stow .
  rm -rf /halofiles
  cd /home/venatio/
  rm .config/placeholder.txt
  mkdir -p desktop/{public,mounted} downloads/torrents/pending documents/templates media/{games,music,pictures/screenshots,videos/recordings}
  mkdir /home/venatio/.cache/zsh
  touch /home/venatio/.cache/zsh/history
  mkdir /home/venatio/.local/share/gnupg
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
homeconf
sudo chown -R venatio:venatio /home/

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
