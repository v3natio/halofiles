# set up the bootloader
bootctl --path=/boot/ install

uuid=$(blkid -s UUID -o value /dev/nvme0n1p2)
swap=$(filefrag -v /swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}')

[ ! -f /boot/loader/entries/halo.conf ] && printf "title Halo Linux
linux /vmlinuz-linux
initrd /amd-ucode.img
initrd /initramfs-linux.img
options cryptdevice=UUID=${uuid}:cryptroot root=/dev/mapper/cryptroot resume=/dev/mapper/cryptroot resume_offset=$swap rw mem_sleep_default=s2idle" > /boot/loader/entries/halo.conf

[ ! -f /boot/loader/loader.conf ] && printf 'default halo.conf
timeout 3
console-mode max
editor no' > /boot/loader/loader.conf

bootctl list
