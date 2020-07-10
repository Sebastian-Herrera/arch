#!/bin/bash
mkfs.ext4 -F /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2

pacman -Syy
pacman -S --noconfirm reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
reflector --sort rate -l 5 --save /etc/pacman.d/mirrorlist

mount /dev/sda1 /mnt

pacstrap /mnt base sudo linux-lts linux-firmware intel-ucode neovim grub networkmanager xorg-server xorg-xinit mesa mesa-demos git

genfstab -U /mnt >> /mnt/etc/fstab

cp -rfv post-install.sh /mnt/root/
chmod 777 /mnt/root/post-install.sh

arch-chroot /mnt /root/post-install.sh

cp -rfv user.sh /mnt/root/
chmod 777 /mnt/herrera/user.sh

umount -R /mnt
reboot
