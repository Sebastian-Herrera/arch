#!/bin/sh
set -euo pipefail

echo '0' | sudo -S pacman -Syyu

echo 'Server = http://repo.archlinux.fr/$arch' | sudo tee -a /etc/pacman.conf
sudo pacman -Sy

git clone https://aur.archlinux.org/yay.git
(cd yay && makepkg -si --noconfirm)
rm -rfv yay/

#localectl set-locale LANG=en_US.UTF-8

yay -S --noconfirm xdg-user-dirs neofetch zsh-theme-powerlevel10k-git unzip qtile alacritty perl-file-mimeinfo nautilus noto-fonts-emoji google-chrome visual-studio-code-bin
#rofi
#systemd-numlockontty
#systemctl enable numLockOnTty

xdg-user-dirs-update

#chsh -s $(which zsh)
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#source ~/.zshrc
#echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc

mkdir -p ~/.config/qtile/
cp /usr/share/doc/qtile/default_config.py ~/.config/qtile/config.py
echo -e '#!/bin/sh\nexec qtile' > ~/.xinitrc

#localectl set-x11-keymap latam deadtilde,dvorak

#echo -e 'defaults.pcm.card 2\ndefaults.ctl.card 2' | sudo tee -a /etc/asound.conf
#pactl set-default-sink 'alsa_output.usb-Focusrite_Scarlett_6i6_USB_00011521-00.analog-surround-51'
#pactl set-default-source 'alsa_input.usb-Focusrite_Scarlett_6i6_USB_00011521-00.multichannel-input'

mkdir .config/gtk-3.0/
echo -e "[Settings]\ngtk-application-prefer-dark-theme=1" > .config/gtk-3.0/settings.ini

TELEGRAM_URL=$(curl -s https://api.github.com/repos/telegramdesktop/tdesktop/releases/latest | grep "h.*p\..*tar\.xz" | cut -d '"' -f 4)
curl -LJo tsetup.tar.xz $TELEGRAM_URL
sudo mkdir -p /opt/telegram/
sudo tar -xvf tsetup.tar.xz -C /opt/telegram/
sudo ln -s /opt/telegram/Telegram/Telegram /usr/bin/telegram
rm -rfv tsetup.tar.xz

#git clone https://github.com/cylgom/ly.git
#(cd ly && make github && make && sudo make install)
#sudo systemctl enable ly.service
#sudo systemctl disable getty@tty1.service
#rm -rfv ly/

yay -S --noconfirm lightdm lightdm-webkit2-greeter
sudo perl -pi -e 's/(?<=#greeter-session=).*/lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf
sudo sed -i '/#greeter-ses/s/^#//g' /etc/lightdm/lightdm.conf
(cd /usr/share/lightdm-webkit/themes/ && sudo git clone https://github.com/davidmogar/lightdm-webkit2-dmg_blue.git)
sudo sed -i 's/antergos/lightdm-webkit2-dmg_blue/' /etc/lightdm/lightdm-webkit2-greeter.conf
sudo systemctl enable lightdm.service

#yay -S --noconfirm nvidia-340xx nvidia-340xx-settings 
#nvidia-340xx-utils
#opencl-nvidia-340xx
#sudo sed -i 's/MODULES=()/MODULES=(nvidia)/' /etc/mkinitcpio.conf
#sudo mkinitcpio -p linux
#sudo nvidia-xconfig

echo '' | sudo tee ~/.zlogin
#rm ~/user.sh
#startx
reboot
