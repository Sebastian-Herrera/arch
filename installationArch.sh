#!/bin/sh
set -euo pipefail

mkfs.ext4 -F /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2

pacman -Syy
pacman -S --noconfirm reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
reflector --sort rate -l 5 --save /etc/pacman.d/mirrorlist

mount /dev/sda1 /mnt

pacstrap /mnt base base-devel linux linux-firmware intel-ucode man-db man-pages grub networkmanager zsh neovim git

genfstab -U /mnt >> /mnt/etc/fstab

cp -rfv ~/arch/post-install.sh /mnt/root/
chmod 777 /mnt/root/post-install.sh
arch-chroot /mnt /root/post-install.sh
rm /mnt/root/post-install.sh

cp -rfv ~/arch/user.sh /mnt/home/herrera/
chmod 777 /mnt/home/herrera/user.sh

#> /mnt/home/herrera/.zshrc
echo "sh ~/user.sh" >> /mnt/home/herrera/.zlogin

mv ~/arch/.config/ /mnt/home/herrera/

cp -rfv ~/arch/etc/ /mnt/

rm -rfv ~/arch/.git 
mv ~/arch/.* /mnt/home/herrera/
#mv ~/arch/.zshrc /mnt/home/herrera/ && mv ~/arch/.p10k.zsh /mnt/home/herrera/ && mv ~/arch/.prettierrc /mnt/home/herrera/ && mv ~/arch/.stylelintrc /mnt/home/herrera/

umount -R /mnt
reboot
