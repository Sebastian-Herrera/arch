#!/bin/sh
echo "0" | sudo -S pacman -Syyu

echo "Server = http://repo.archlinux.fr/$arch" | sudo tee -a /etc/pacman.conf
sudo pacman -Sy

git clone https://aur.archlinux.org/yay.git
(cd yay && makepkg -si --noconfirm)

yay -S --noconfirm xdg-user-dirs zsh zsh-theme-powerlevel10k-git neofetch qtile alacritty 
#google-chrome 

xdg-user-dirs-update

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
source ~/.zshrc
#chsh -s $(which zsh)
#echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc

yay -S nvidia-340xx nvidia-340xx-settings nvidia-340xx-utils opencl-nvidia-340xx

mkdir -p ~/.config/qtile/
cp /usr/share/doc/<qtile_dir>/default_config.py ~/.config/qtile/config.py
echo -e "#!/bin/sh\nexec qtile" >> ~/.xinitrc

git clone https://github.com/cylgom/ly.git
(cd ly && make github && make && sudo make install)
sudo systemctl enable ly.service
sudo systemctl disable getty@tty1.service

startx
