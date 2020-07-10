#!/bin/sh
echo "0" | sudo -S pacman -Syyu

echo "Server = http://repo.archlinux.fr/$arch" | sudo tee -a /etc/pacman.conf
sudo pacman -Sy

git clone https://aur.archlinux.org/yay.git
(cd yay && makepkg -si --noconfirm)

yay -S --noconfirm xdg-user-dirs zsh zsh-theme-powerlevel10k-git neofetch qtile alacritty google-chrome 

xdg-user-dirs-update

(zsh &&
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &&
source ~/.zshrc &&
chsh -s $(which zsh) &&

echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc)
