#!/bin/bash

# fix DNS issue
sudo rm /etc/resolv.conf
sudo ln -s /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# add fallback img
sudo cp /boot/loader/entries/halo.conf /boot/loader/entries/halo-fallback.conf
sudo sed -i 's/title Halo Linux/title Halo (Fallback) Linux/' /boot/loader/entries/halo-fallback.conf
sudo sed -i 's|initrd /initramfs-linux.img|initrd /initramfs-linux-fallback.img|' /boot/loader/entries/halo-fallback.conf

# copy SSH key
sudo cp /home/venatio/desktop/mounted/id_ed25519 /home/venatio/.ssh/
chmod 600 /home/venatio/.ssh/id_ed25519
sudo cp /home/venatio/desktop/mounted/id_ed25519.pub /home/venatio/.ssh/
chmod 644 /home/venatio/.ssh/id_ed25519.pub

# enable eduroam
curl "https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=9190&device=linux&generatedfor=user&openroaming=0" -o eduroam.py
python eduroam.py
sudo mv /home/venatio/.config/cat_installer/ca.pem /etc/ssl/certs/uc3m.pem
[ ! -f /var/lib/iwd/eduroam.8021x ] && {
  cat >/var/lib/iwd/eduroam.8021x <<EOF
[Security]
EAP-Method=PEAP
EAP-Identity=$(grep 'anonymous_identity=' '/home/venatio/.config/cat_installer/cat_installer.conf' | cut -d'"' -f2)
EAP-PEAP-CACert=/etc/ssl/certs/uc3m.pem
EAP-PEAP-ServerDomainMask=$(grep 'altsubject_match=' '/home/venatio/.config/cat_installer/cat_installer.conf' | cut -d'=' -f2 | tr -d '"' | sed 's/DNS://')
EAP-PEAP-Phase2-Method=MSCHAPV2
EAP-PEAP-Phase2-Identity=$(grep '^ *identity=' '/home/venatio/.config/cat_installer/cat_installer.conf' | cut -d'"' -f2)
EAP-PEAP-Phase2-Password=$(grep 'password=' '/home/venatio/.config/cat_installer/cat_installer.conf' | cut -d'"' -f2)

[Settings]
AutoConnect=true
EOF
}
rm -rf /home/venatio/.config/cat_installer

# enable logitech udev rules
sudo curl -o /etc/udev/rules.d/42-logitech-unify-permissions.rules "https://raw.githubusercontent.com/pwr-Solaar/Solaar/master/rules.d-uinput/42-logitech-unify-permissions.rules"

# enable monitor/keyboard hotplug watchdogs
if [ ! -f /etc/udev/rules.d/90-keyboard-hotplug.rules ]; then
  sudo sh -c 'printf "ACTION==\"add|remove\", SUBSYSTEM==\"input\", KERNEL==\"event*\", ENV{ID_INPUT_KEYBOARD}==\"1\", TAG+=\"systemd\", ENV{SYSTEMD_USER_WANTS}+=\"switch-keymaps.service\"\n" > /etc/udev/rules.d/90-keyboard-hotplug.rules'
fi

if [ ! -f /etc/udev/rules.d/90-monitor-hotplug.rules ]; then
  sudo sh -c 'printf "ACTION==\"change\", SUBSYSTEM==\"drm\", ENV{HOTPLUG}==\"1\", TAG+=\"systemd\", ENV{SYSTEMD_USER_WANTS}+=\"switch-screen.service\"\n" > /etc/udev/rules.d/90-monitor-hotplug.rules'
fi

sudo udevadm control --reload-rules
sudo udevadm trigger
command systemctl --user daemon-reload
command systemctl --user start notify-battery.timer
command systemctl --user enable notify-battery.timer
command systemctl --user enable gdrive-rclone.service

# configure tlp
sudo sed -i '/#START_CHARGE_THRESH_BAT0=0/s/^#//;/#STOP_CHARGE_THRESH_BAT0=1/s/^#//' /etc/tlp.conf
