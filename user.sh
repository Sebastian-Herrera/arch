#!/bin/sh
echo '0' | sudo -S pacman -Syyu

echo 'Server = http://repo.archlinux.fr/$arch' | sudo tee -a /etc/pacman.conf
sudo pacman -Sy

git clone https://aur.archlinux.org/yay.git
(cd yay && makepkg -si --noconfirm)
rm -rfv yay/

yay -S --noconfirm nvidia-340xx nvidia-340xx-settings 
#nvidia-340xx-utils
#opencl-nvidia-340xx
sudo sed -i 's/MODULES=()/MODULES=(nvidia)/' /etc/mkinitcpio.conf
sudo mkinitcpio -p linux
nvidia-xconfig

yay -S --noconfirm xdg-user-dirs neofetch qtile alacritty google-chrome
#zsh-theme-powerlevel10k-git 

xdg-user-dirs-update

#chsh -s $(which zsh)
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#source ~/.zshrc
#echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc

mkdir -p ~/.config/qtile/
cp /usr/share/doc/qtile/default_config.py ~/.config/qtile/config.py
echo -e '#!/bin/sh\nexec qtile' >> ~/.xinitrc

localectl set-x11-keymap latam deadtilde,dvorak

echo -e 'defaults.pcm.card 2\ndefaults.ctl.card 2' | sudo tee -a /etc/asound.conf

git clone https://github.com/cylgom/ly.git
(cd ly && make github && make && sudo make install)
sudo systemctl enable ly.service
sudo systemctl disable getty@tty1.service
rm -rfv ly/



pactl set-default-sink 'alsa_output.usb-Focusrite_Scarlett_6i6_USB_00011521-00.analog-surround-51'
pactl set-default-source 'alsa_input.usb-Focusrite_Scarlett_6i6_USB_00011521-00.multichannel-input'

#sudo mkdir -p /opt/telegram/Telegram/
#sudo ln -s /opt/telegram/Telegram/Telegram /usr/bin/telegram


echo '' | sudo tee ~/.zlogin
rm ~/user.sh
#startx
reboot
