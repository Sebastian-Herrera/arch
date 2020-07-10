#!/bin/sh
echo "0" | sudo -S pacman -Syyu

echo "Server = http://repo.archlinux.fr/$arch" | sudo tee -a /etc/pacman.conf
sudo pacman -Sy

git clone https://aur.archlinux.org/yay.git
(cd yay && makepkg -si --noconfirm)

yay -S --noconfirm xdg-user-dirs zsh neofetch qtile alacritty 
#zsh-theme-powerlevel10k-git 
#google-chrome 

xdg-user-dirs-update

chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
source ~/.zshrc
#echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc

yay -S --noconfirm nvidia-340xx-lts nvidia-340xx-settings 
#nvidia-340xx-utils
#opencl-nvidia-340xx
sed -i 's/MODULES=()/MODULES=(nvidia)/' /etc/mkinitcpio.conf
sudo mkinitcpio -p linux

mkdir -p ~/.config/qtile/
cp /usr/share/doc/<qtile_dir>/default_config.py ~/.config/qtile/config.py
echo -e "#!/bin/sh\nexec qtile" >> ~/.xinitrc

git clone https://github.com/cylgom/ly.git
(cd ly && make github && make && sudo make install)
sudo systemctl enable ly.service
sudo systemctl disable getty@tty1.service

#startx
reboot
