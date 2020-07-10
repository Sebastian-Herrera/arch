#!/bin/sh
pacman -Syyu

echo "Server = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf
pacman -Sy

git clone https://aur.archlinux.org/yay.git
makepkg -si --noconfirm
