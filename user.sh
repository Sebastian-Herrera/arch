#!/bin/sh
set -euo pipefail

echo '0' | sudo -S chown -Rv herrera:herrera ~/
echo '0' | sudo -S pacman -Syyu

sudo sed -i 's/sh -c.*"/#/' ./user.sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo 'Server = http://repo.archlinux.fr/$arch' | sudo tee -a /etc/pacman.conf
sudo pacman -Sy

git clone https://aur.archlinux.org/yay.git
(cd yay && makepkg -si --noconfirm)
rm -rfv yay/

yay -Sy --noconfirm xorg-server xorg-xinit mesa mesa-demos nvidia-340xx
#nvidia-340xx-settings 
#nvidia-340xx-utils
#opencl-nvidia-340xx
sudo sed -i 's/MODULES=()/MODULES=(nvidia)/' /etc/mkinitcpio.conf
sudo mkinitcpio -p linux
#sudo nvidia-xconfig

echo '0' | sudo pacman -Sy --noconfirm xdg-user-dirs neofetch noto-fonts-emoji unzip qtile gtk2 gtk3 alacritty perl-file-mimeinfo nautilus pulseaudio
yay -Sy --noconfirm zsh-theme-powerlevel10k-git google-chrome visual-studio-code-bin spotify
#rofi #localectl set-locale LANG=en_US.UTF-8
#systemd-numlockontty
#systemctl enable numLockOnTty

xdg-user-dirs-update

#chsh -s $(which zsh)
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#source ~/.zshrc
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

#mkdir -p ~/.config/qtile/
#cp /usr/share/doc/qtile/default_config.py ~/.config/qtile/config.py
echo -e '#!/bin/sh\nexec qtile' > ~/.xinitrc

echo "0" | sudo -S localectl set-x11-keymap es

#echo -e 'defaults.pcm.card 2\ndefaults.ctl.card 2' | sudo tee -a /etc/asound.conf
#pactl set-default-sink 'alsa_output.usb-Focusrite_Scarlett_6i6_USB_00011521-00.analog-surround-51'
#pactl set-default-source 'alsa_input.usb-Focusrite_Scarlett_6i6_USB_00011521-00.multichannel-input'

curl -L -o myosevka.zip https://www.dropbox.com/sh/nqyurzy8wcupkkz/myosevka.zip\?dl\=1

#mkdir .config/gtk-3.0/
#echo -e "[Settings]\ngtk-application-prefer-dark-theme=1" > .config/gtk-3.0/settings.ini

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

yay -Sy --noconfirm lightdm lightdm-webkit2-greeter
sudo perl -pi -e 's/(?<=#greeter-session=).*/lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf
sudo sed -i '/#greeter-ses/s/^#//g' /etc/lightdm/lightdm.conf
(cd /usr/share/lightdm-webkit/themes/ && sudo git clone https://github.com/davidmogar/lightdm-webkit2-dmg_blue.git)
sudo sed -i 's/antergos/lightdm-webkit2-dmg_blue/' /etc/lightdm/lightdm-webkit2-greeter.conf
sudo systemctl enable lightdm.service

echo '' | sudo tee ~/.zlogin
rm -f ~/.zshrc.pre-oh-my-zsh ~/user.sh
#startx
reboot
