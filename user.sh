#!/bin/sh
set -euo pipefail

#if [ -d ~/.oh-my-zsh/ ]
#then
#        echo "..."
#else
#        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#fi

#mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc

echo '0' | sudo -S chown -Rv herrera:herrera ~/
echo '0' | sudo -S pacman -Syyu

echo 'Server = http://repo.archlinux.fr/$arch' | sudo tee -a /etc/pacman.conf
sudo pacman -Sy

git clone https://aur.archlinux.org/yay.git
(cd yay && makepkg -si --noconfirm)
rm -rfv yay/

yay -Sy --noconfirm xorg-server xorg-xinit xorg-server-xephyr mesa mesa-demos nvidia-340xx
#nvidia-340xx-settings 
#nvidia-340xx-utils
#opencl-nvidia-340xx
sudo sed -i 's/MODULES=()/MODULES=(nvidia)/' /etc/mkinitcpio.conf
sudo mkinitcpio -p linux
#sudo nvidia-xconfig

sudo sed -i '/IgnorePkg.*=/s/=/= linux linux-headers nvidia-340xx/g' /etc/pacman.conf
sudo sed -i '/IgnorePkg.*=/s/^#//g' /etc/pacman.conf

echo '0' | sudo pacman -Sy --noconfirm numlockx xdg-user-dirs neofetch noto-fonts ttf-apple-emoji ttf-liberation unzip awesome qtile picom hsetroot gtk2 gtk3 alacritty rofi rofimoji dunst xdg-utils perl-file-mimeinfo ranger nautilus file-roller pulseaudio playerctl unrar fzf catimg redshift ntfs-3g wget gnome-keyring uget zathura zathura-pdf-mupdf vlc python-pip
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
#curl -sS https://download.spotify.com/debian/pubkey.gpg | gpg --import - && gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
yay -Sy --noconfirm nautilus-open-any-terminal escrotum-git bottom glow google-chrome uget-integrator-chrome visual-studio-code-bin notion-app figma-linux spotify spicetify-cli #zsh-theme-powerlevel10k-git
#localectl set-locale LANG=en_US.UTF-8

#Starship
wget -P ~/.zsh/lib/ https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/lib/history.zsh
wget -P ~/.zsh/lib/ https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/lib/key-bindings.zsh
wget -P ~/.zsh/lib/ https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/lib/grep.zsh
wget -P ~/.zsh/lib/ https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/lib/completion.zsh

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/plugins/zsh-syntax-highlighting
wget -P ~/.zsh/plugins/archlinux/ https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/archlinux/archlinux.plugin.zsh
wget -P ~/.zsh/plugins/colored-man-pages/ https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/colored-man-pages/colored-man-pages.plugin.zsh
wget -P ~/.zsh/plugins/history-substring-search/ https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/history-substring-search/history-substring-search.zsh
wget -P ~/.zsh/plugins/git/ https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh

#OHMYZSH
#echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search && bindkey '^[[A' history-substring-search-up && bindkey '^[[B' history-substring-search-down
#perl -pi -e 's/(?<=plugins=).*/(zsh-syntax-highlighting zsh-autosuggestions archlinux colored-man-pages history-substring-search git)/g' ~/.zshrc

xdg-user-dirs-update

gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal keybindings '<Ctrl><Alt>t'
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal new-tab true

#mkdir -p ~/.config/qtile/
#cp /usr/share/doc/qtile/default_config.py ~/.config/qtile/config.py
chmod +x ~/.config/qtile/autostart.sh
#echo -e '#!/bin/sh\nexec qtile' > ~/.xinitrc

wget -P ~/.config/awesome/charitable https://raw.githubusercontent.com/frioux/charitable/master/init.lua

echo "0" | sudo -S localectl set-x11-keymap es

#bash -c "$(wget -q -O - https://linux.kite.com/dls/linux/current)"

#echo -e 'defaults.pcm.card 2\ndefaults.ctl.card 2' | sudo tee -a /etc/asound.conf
#pactl set-default-sink 'alsa_output.usb-Focusrite_Scarlett_6i6_USB_00011521-00.analog-surround-51'
#pactl set-default-source 'alsa_input.usb-Focusrite_Scarlett_6i6_USB_00011521-00.multichannel-input'

DRACULA_URL=$(curl https://api.github.com/repos/dracula/gtk/releases/latest | grep "h.*a\.tar" | cut -d '"' -f 4)
curl -Ljo dracula.tar.xz $DRACULA_URL
sudo tar -xvf dracula.tar.xz -C /usr/share/themes/ && rm dracula.tar.xz

git clone https://github.com/fontello/typicons.font.git && (cd typicons.font && sudo mv font /usr/share/fonts/typicons) && rm -rfv typicons.font/
curl -L -o material-design-icons.ttf https://www.dropbox.com/s/4fevs095ho7xtf9/material-design-icons.ttf\?dl\=1 && sudo mv material-design-icons.ttf /usr/share/fonts/
curl -L -o icomoon.zip https://www.dropbox.com/s/hrkub2yo9iapljz/icomoon.zip\?dl\=1 && sudo unzip icomoon.zip -d /usr/share/fonts && rm icomoon.zip

curl -L -o myosevka.zip https://www.dropbox.com/sh/nqyurzy8wcupkkz/myosevka.zip\?dl\=1 && sudo unzip myosevka.zip -d /usr/share/fonts/ && rm myosevka.zip
curl -LJo Open_Sans.zip https://fonts.google.com/download\?family\=Open%20Sans && sudo unzip Open_Sans.zip -d /usr/share/fonts/open-sans/ && rm Open_Sans.zip
curl -LJo sf-ui-display-cufonfonts.zip https://www.cufonfonts.com/download/font/sf-ui-display && sudo unzip sf-ui-display-cufonfonts.zip -d /usr/share/fonts/sf-ui-display/ && rm sf-ui-display-cufonfonts.zip
curl -fLo "Iosevka Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf && sudo mv Iosevka\ Nerd\ Font\ Complete.otf /usr/share/fonts/

FIRACODE_URL=$(curl https://api.github.com/repos/tonsky/firacode/releases/latest | grep "h.*\.zip" | cut -d '"' -f 4)
curl -LJo Fira_Code.zip $FIRACODE_URL
sudo unzip Fira_Code.zip -d /usr/share/fonts/fira-code/ && rm Fira_Code.zip

SCIENTIFICA_URL=$(curl https://api.github.com/repos/NerdyPepper/scientifica/releases/latest | grep "h.*\.tar" | cut -d '"' -f 4)
curl -LJo scientifica.tar $SCIENTIFICA_URL
sudo tar -xvf scientifica.tar -C /usr/share/fonts/ && rm scientifica.tar

TELEGRAM_URL=$(curl -s https://api.github.com/repos/telegramdesktop/tdesktop/releases/latest | grep "h.*p\..*tar\.xz" | cut -d '"' -f 4)
curl -LJo tsetup.tar.xz $TELEGRAM_URL
sudo mkdir -p /opt/telegram/
sudo tar -xvf tsetup.tar.xz -C /opt/telegram/
sudo ln -s /opt/telegram/Telegram/Telegram /usr/local/bin/telegram
rm -rfv tsetup.tar.xz

mkdir ~/Applications/

RESPONSIVELY_URL=$(curl -s https://api.github.com/repos/responsively-org/responsively-app/releases/latest | grep "h.*\.AppImage" | cut -d '"' -f 4)
curl -LJo ResponsivelyApp.AppImage $RESPONSIVELY_URL
mv ResponsivelyApp.AppImage ~/Applications/
chmod +x ~/Applications/ResponsivelyApp.AppImage
sudo ln -s ~/Applications/ResponsivelyApp.AppImage /usr/local/bin/responsivelyApp

MARKTEXT_URL=$(curl https://api.github.com/repos/marktext/marktext/releases/latest | grep "ht.*\.AppImage" | cut -d '"' -f 4)
curl -LJo marktext.AppImage $MARKTEXT_URL
mv marktext.AppImage ~/Applications
chmod +x ~/Applications/marktext.AppImage
sudo ln -s ~/Applications/marktext.AppImage /usr/local/bin/marktext

EXERCISM_URL=$(curl -s https://api.github.com/repos/exercism/cli/releases/latest | grep "h.*linux-64.*tgz" | cut -d '"' -f 4)
curl -LJO $EXERCISM_URL
tar -zxvf exercism-linux-64bit.tgz
sudo mv ~/exercism /usr/local/bin/
wget -O ~/.zsh/functions/_exercism https://raw.githubusercontent.com/exercism/cli/master/shell/exercism_completion.zsh
rm -rfv LICENSE README.md shell exercism-linux-64bit.tgz

sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
spicetify
spicetify backup apply enable-devtool
spicetify update
wget -P ~/.config/spicetify/Themes/Dribbblish https://raw.githubusercontent.com/morpheusthewhite/spicetify-themes/master/Dribbblish/user.css
wget -P ~/.config/spicetify/Extensions https://raw.githubusercontent.com/morpheusthewhite/spicetify-themes/master/Dribbblish/dribbblish.js
spicetify config extensions dribbblish.js extensions fullAppDisplay.js
spicetify config current_theme Dribbblish color_scheme amarena
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
spicetify apply

#git clone https://github.com/cylgom/ly.git
#(cd ly && make github && make && sudo make install)
#sudo systemctl enable ly.service
#sudo systemctl disable getty@tty1.service
#rm -rfv ly/

yay -Sy --noconfirm lightdm lightdm-webkit2-greeter
sudo perl -pi -e 's/(?<=#greeter-session=).*/lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf
sudo sed -i '/#greeter-ses/s/^#//g' /etc/lightdm/lightdm.conf
sudo perl -pi -e 's/(?<=#greeter-setup-script=).*/\/usr\/bin\/numlockx on/g' /etc/lightdm/lightdm.conf
sudo sed -i '/#greeter-setup-script/s/^#//g' /etc/lightdm/lightdm.conf
(cd /usr/share/lightdm-webkit/themes/ && sudo git clone https://github.com/davidmogar/lightdm-webkit2-dmg_blue.git)
sudo sed -i 's/antergos/lightdm-webkit2-dmg_blue/' /etc/lightdm/lightdm-webkit2-greeter.conf
sudo systemctl enable lightdm.service

curl -LJO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
sudo unzip ngrok-stable-linux-amd64.zip -d /usr/local/bin/ && rm -fv ngrok-stable-linux-amd64.zip

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | zsh
source ~/.zshrc
nvm install --lts && perl -pi -e 's/\$USER/'"$USER/g" ~/.stylelintrc.yml && perl -pi -e 's/\$NODE_VERSION|v\d.*\d(?=\/)/'"$(node -v)/g" ~/.stylelintrc.yml

git config --global core.editor nvim

changepass="CiDilojilojilojilojilojilojigIHilojilojigIEgIOKWiOKWiOKAgSDilojilojilojilojilojigIEg4paI4paI4paI4oCBICAg4paI4paI4oCBIOKWiOKWiOKWiOKWiOKWiOKWiOKAgSDilojilojilojilojilojilojilojigIEgICAg4paI4paI4paI4paI4paI4paI4oCBICDilojilojilojilojilojigIEg4paI4paI4paI4paI4paI4paI4paI4oCB4paI4paI4paI4paI4paI4paI4paI4oCBCuKWiOKWiOKAgeKAgeKAgeKAgeKAgeKAgeKWiOKWiOKAgSAg4paI4paI4oCB4paI4paI4oCB4oCB4oCB4paI4paI4oCB4paI4paI4paI4paI4oCBICDilojilojigIHilojilojigIHigIHigIHigIHigIHigIEg4paI4paI4oCB4oCB4oCB4oCB4oCB4oCBICAgIOKWiOKWiOKAgeKAgeKAgeKWiOKWiOKAgeKWiOKWiOKAgeKAgeKAgeKWiOKWiOKAgeKWiOKWiOKAgeKAgeKAgeKAgeKAgeKAgeKWiOKWiOKAgeKAgeKAgeKAgeKAgeKAgQrilojilojigIEgICAgIOKWiOKWiOKWiOKWiOKWiOKWiOKWiOKAgeKWiOKWiOKWiOKWiOKWiOKWiOKWiOKAgeKWiOKWiOKAgeKWiOKWiOKAgSDilojilojigIHilojilojigIEgIOKWiOKWiOKWiOKAgeKWiOKWiOKWiOKWiOKWiOKAgSAgICAgIOKWiOKWiOKWiOKWiOKWiOKWiOKAgeKAgeKWiOKWiOKWiOKWiOKWiOKWiOKWiOKAgeKWiOKWiOKWiOKWiOKWiOKWiOKWiOKAgeKWiOKWiOKWiOKWiOKWiOKWiOKWiOKAgQrilojilojigIEgICAgIOKWiOKWiOKAgeKAgeKAgeKWiOKWiOKAgeKWiOKWiOKAgeKAgeKAgeKWiOKWiOKAgeKWiOKWiOKAgeKAgeKWiOKWiOKAgeKWiOKWiOKAgeKWiOKWiOKAgSAgIOKWiOKWiOKAgeKWiOKWiOKAgeKAgeKAgeKAgSAgICAgIOKWiOKWiOKAgeKAgeKAgeKAgeKAgSDilojilojigIHigIHigIHilojilojigIHigIHigIHigIHigIHigIHilojilojigIHigIHigIHigIHigIHigIHilojilojigIEK4oCB4paI4paI4paI4paI4paI4paI4oCB4paI4paI4oCBICDilojilojigIHilojilojigIEgIOKWiOKWiOKAgeKWiOKWiOKAgSDigIHilojilojilojilojigIHigIHilojilojilojilojilojilojigIHigIHilojilojilojilojilojilojilojigIEgICAg4paI4paI4oCBICAgICDilojilojigIEgIOKWiOKWiOKAgeKWiOKWiOKWiOKWiOKWiOKWiOKWiOKAgeKWiOKWiOKWiOKWiOKWiOKWiOKWiOKAgQog4oCB4oCB4oCB4oCB4oCB4oCB4oCB4oCB4oCB4oCBICDigIHigIHigIHigIHigIHigIEgIOKAgeKAgeKAgeKAgeKAgeKAgSAg4oCB4oCB4oCB4oCB4oCBIOKAgeKAgeKAgeKAgeKAgeKAgeKAgSDigIHigIHigIHigIHigIHigIHigIHigIEgICAg4oCB4oCB4oCBICAgICDigIHigIHigIEgIOKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK4paI4paI4"
echo $changepass"paI4paI4paI4paI4oCBICDilojilojilojilojilojilojigIEgIOKWiOKWiOKWiOKWiOKWiOKWiOKAgSDilojilojilojilojilojilojilojilojigIEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCuKWiOKWiOKAgeKAgeKAgeKWiOKWiOKAgeKWiOKWiOKAgeKAgeKAgeKAgeKWiOKWiOKAgeKWiOKWiOKAgeKAgeKAgeKAgeKWiOKWiOKAgeKAgeKAgeKAgeKWiOKWiOKAgeKAgeKAgeKAgSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK4paI4paI4paI4paI4paI4paI4oCB4oCB4paI4paI4oCBICAg4paI4paI4oCB4paI4paI4oCBICAg4paI4paI4oCBICAg4paI4paI4oCBICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIArilojilojigIHigIHigIHilojilojigIHilojilojigIEgICDilojilojigIHilojilojigIEgICDilojilojigIEgICDilojilojigIEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCuKWiOKWiOKAgSAg4paI4paI4oCB4oCB4paI4paI4paI4paI4paI4paI4oCB4oCB4oCB4paI4paI4paI4paI4paI4paI4oCB4oCBICAg4paI4paI4oCBICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIArigIHigIHigIEgIOKAgeKAgeKAgSDigIHigIHigIHigIHigIHigIHigIEgIOKAgeKAgeKAgeKAgeKAgeKAgeKAgSAgICDigIHigIHigIEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAo=" | base64 -d
sudo passwd root
echo $changepass"oCBICAg4paI4paI4oCB4paI4paI4paI4paI4paI4paI4paI4oCB4paI4paI4paI4paI4paI4paI4paI4oCB4paI4paI4paI4paI4paI4paI4oCBICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIArilojilojigIEgICDilojilojigIHilojilojigIHigIHigIHigIHigIHigIHilojilojigIHigIHigIHigIHigIHigIHilojilojigIHigIHigIHilojilojigIEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK4paI4paI4oCBICAg4paI4paI4oCB4paI4paI4paI4paI4paI4paI4paI4oCB4paI4paI4paI4paI4paI4oCBICDilojilojilojilojilojilojigIHigIEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK4paI4paI4oCBICAg4paI4paI4oCB4oCB4oCB4oCB4oCB4oCB4paI4paI4oCB4paI4paI4oCB4oCB4oCB4oCBICDilojilojigIHigIHigIHilojilojigIEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK4oCB4paI4paI4paI4paI4paI4paI4oCB4oCB4paI4paI4paI4paI4paI4paI4paI4oCB4paI4paI4paI4paI4paI4paI4paI4oCB4paI4paI4oCBICDilojilojigIEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKIOKAgeKAgeKAgeKAgeKAgeKAgeKAgSDigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIEgIOKAgeKAgeKAgSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK" | base64 -d
passwd

rm -fv ~/.zlogin ~/user.sh #~/.zshrc.pre-oh-my-zsh 
#startx
reboot
