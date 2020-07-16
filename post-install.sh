#!/bin/sh
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
hwclock --systohc

sed -i '/#en_US.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
locale-gen

sed -i '/week 7/a\first_weekday 2\nfirst_workday 2' /usr/share/i18n/locales/en_US
locale-gen

echo "LANG=en-US.UTF-8" > /etc/locale.conf
echo "KEYMAP=es" > /etc/vconsole.conf

echo "herrera" > /etc/hostname

echo -e "127.0.0.0       localhost\n::1             localhost\n127.0.1.1       herrera.localdomain     herrera" >> /etc/hosts

echo "root:0" | chpasswd 

useradd -m -G wheel -s /bin/zsh herrera -c "Sebastian Herrera"
echo "herrera:0" | chpasswd
sed -i '/# %wheel ALL=(ALL) ALL/s/^# //g' /etc/sudoers

systemctl enable NetworkManager

grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

exit
