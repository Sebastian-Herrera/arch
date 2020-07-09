#!/bin/sh
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
hwclock --systohc

sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

sed '/week 7/a\first_weekday   2\nfirst_workday   2' /usr/share/i18n/locales/en_US
locale-gen

echo "LANG=en-US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=es" >> /etc/vconsole.conf

echo "herrera" >> /etc/hostname

echo "127.0.0.0       localhost\n::1             localhost\n127.0.1.1       herrera.localdomain     herrera" >> /etc/hosts

passwd

useradd -m -G wheel herrera -c "Sebastian Herrera"
passwd herrera
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

systemctl enable NetworkManager

grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

exit
