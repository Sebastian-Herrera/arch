#!/bin/sh
set -euo pipefail

if [ -d ~/.oh-my-zsh/ ]
then
        echo "..."
else
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc

echo '0' | sudo -S chown -Rv herrera:herrera ~/
echo '0' | sudo -S pacman -Syyu

echo 'Server = http://repo.archlinux.fr/$arch' | sudo tee -a /etc/pacman.conf
sudo pacman -Sy

git clone https://aur.archlinux.org/yay.git
(cd yay && makepkg -si --noconfirm)
rm -rfv yay/

yay -Sy --noconfirm xorg-server xorg-xinit mesa mesa-demos nvidia-340xx-lts
#nvidia-340xx-settings 
#nvidia-340xx-utils
#opencl-nvidia-340xx
sudo sed -i 's/MODULES=()/MODULES=(nvidia)/' /etc/mkinitcpio.conf
sudo mkinitcpio -p linux-lts
#sudo nvidia-xconfig

echo '0' | sudo pacman -Sy --noconfirm numlockx xdg-user-dirs neofetch noto-fonts-emoji unzip qtile picom hsetroot gtk2 gtk3 alacritty rofi dunst xdg-utils perl-file-mimeinfo ranger nautilus pulseaudio playerctl unrar fzf catimg redshift ntfs-3g wget gnome-keyring uget
curl -sS https://download.spotify.com/debian/pubkey.gpg | gpg --import - && gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
yay -Sy --noconfirm zsh-theme-powerlevel10k-git nautilus-open-any-terminal escrotum-git bottom google-chrome visual-studio-code-bin notion-app spotify spicetify-cli uget-integrator-chrome
#localectl set-locale LANG=en_US.UTF-8

#echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search && bindkey '^[[A' history-substring-search-up && bindkey '^[[B' history-substring-search-down
#perl -pi -e 's/(?<=plugins=).*/(zsh-syntax-highlighting zsh-autosuggestions archlinux colored-man-pages history-substring-search git)/g' ~/.zshrc

xdg-user-dirs-update

gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal keybindings '<Ctrl><Alt>t'
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal new-tab true

#mkdir -p ~/.config/qtile/
#cp /usr/share/doc/qtile/default_config.py ~/.config/qtile/config.py
chmod +x ~/.config/qtile/autostart.sh
echo -e '#!/bin/sh\nexec qtile' > ~/.xinitrc

echo "0" | sudo -S localectl set-x11-keymap es

bash -c "$(wget -q -O - https://linux.kite.com/dls/linux/current)"

#echo -e 'defaults.pcm.card 2\ndefaults.ctl.card 2' | sudo tee -a /etc/asound.conf
#pactl set-default-sink 'alsa_output.usb-Focusrite_Scarlett_6i6_USB_00011521-00.analog-surround-51'
#pactl set-default-source 'alsa_input.usb-Focusrite_Scarlett_6i6_USB_00011521-00.multichannel-input'

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

#mkdir .config/gtk-3.0/
#echo -e "[Settings]\ngtk-application-prefer-dark-theme=1" > .config/gtk-3.0/settings.ini

TELEGRAM_URL=$(curl -s https://api.github.com/repos/telegramdesktop/tdesktop/releases/latest | grep "h.*p\..*tar\.xz" | cut -d '"' -f 4)
curl -LJo tsetup.tar.xz $TELEGRAM_URL
sudo mkdir -p /opt/telegram/
sudo tar -xvf tsetup.tar.xz -C /opt/telegram/
sudo ln -s /opt/telegram/Telegram/Telegram /usr/bin/telegram
rm -rfv tsetup.tar.xz

mkdir ~/Applications/

JITSI_URL=$(curl -s https://api.github.com/repos/jitsi/jitsi-meet-electron/releases/latest | grep "h.*\.AppImage" | cut -d '"' -f 4)
curl -LJo jitsi-meet.AppImage $JITSI_URL
mv jitsi-meet.AppImage ~/Applications
chmod +x ~/Applications/jitsi-meet.AppImage

RESPONSIVELY_URL=$(curl -s https://api.github.com/repos/responsively-org/responsively-app/releases/latest | grep "h.*\.AppImage" | cut -d '"' -f 4)
curl -LJo ResponsivelyApp.AppImage $RESPONSIVELY_URL
mv ResponsivelyApp.AppImage ~/Applications/
chmod +x ~/Applications/ResponsivelyApp.AppImage

MARKTEXT_URL=$(curl https://api.github.com/repos/marktext/marktext/releases/latest | grep "ht.*\.AppImage" | cut -d '"' -f 4)
curl -LJo marktext.AppImage $MARKTEXT_URL
mv marktext.AppImage ~/Applications
chmod +x ~/Applications/marktext.AppImage

sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
spicetify
spicetify backup apply enable-devtool

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
sudo unzip ngrok-stable-linux-amd64.zip -d /usr/bin/ && rm -fv ngrok-stable-linux-amd64.zip

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | zsh
nvm install --lts

npm i -g prettier
npm i -g stylelint stylelint-config-standard stylelint-order stylelint-value-no-unknown-custom-properties stylelint-use-nesting postcss stylelint-declaration-block-no-ignored-properties stylelint-group-selectors stylelint-high-performance-animation postcss-value-parser stylelint-8-point-grid stylelint-a11y stylelint-selector-bem-pattern
npm i -g eslint eslint-config-airbnb-base eslint-plugin-import
npm i -g @babel/core @babel/cli @babel/preset-env core-js regenerator-runtime
npm i -g webpack webpack-cli webpack-dev-server babel-loader

changepass="CiDilojilojilojilojilojilojigIHilojilojigIEgIOKWiOKWiOKAgSDilojilojilojilojilojigIEg4paI4paI4paI4oCBICAg4paI4paI4oCBIOKWiOKWiOKWiOKWiOKWiOKWiOKAgSDilojilojilojilojilojilojilojigIEgICAg4paI4paI4paI4paI4paI4paI4oCBICDilojilojilojilojilojigIEg4paI4paI4paI4paI4paI4paI4paI4oCB4paI4paI4paI4paI4paI4paI4paI4oCBCuKWiOKWiOKAgeKAgeKAgeKAgeKAgeKAgeKWiOKWiOKAgSAg4paI4paI4oCB4paI4paI4oCB4oCB4oCB4paI4paI4oCB4paI4paI4paI4paI4oCBICDilojilojigIHilojilojigIHigIHigIHigIHigIHigIEg4paI4paI4oCB4oCB4oCB4oCB4oCB4oCBICAgIOKWiOKWiOKAgeKAgeKAgeKWiOKWiOKAgeKWiOKWiOKAgeKAgeKAgeKWiOKWiOKAgeKWiOKWiOKAgeKAgeKAgeKAgeKAgeKAgeKWiOKWiOKAgeKAgeKAgeKAgeKAgeKAgQrilojilojigIEgICAgIOKWiOKWiOKWiOKWiOKWiOKWiOKWiOKAgeKWiOKWiOKWiOKWiOKWiOKWiOKWiOKAgeKWiOKWiOKAgeKWiOKWiOKAgSDilojilojigIHilojilojigIEgIOKWiOKWiOKWiOKAgeKWiOKWiOKWiOKWiOKWiOKAgSAgICAgIOKWiOKWiOKWiOKWiOKWiOKWiOKAgeKAgeKWiOKWiOKWiOKWiOKWiOKWiOKWiOKAgeKWiOKWiOKWiOKWiOKWiOKWiOKWiOKAgeKWiOKWiOKWiOKWiOKWiOKWiOKWiOKAgQrilojilojigIEgICAgIOKWiOKWiOKAgeKAgeKAgeKWiOKWiOKAgeKWiOKWiOKAgeKAgeKAgeKWiOKWiOKAgeKWiOKWiOKAgeKAgeKWiOKWiOKAgeKWiOKWiOKAgeKWiOKWiOKAgSAgIOKWiOKWiOKAgeKWiOKWiOKAgeKAgeKAgeKAgSAgICAgIOKWiOKWiOKAgeKAgeKAgeKAgeKAgSDilojilojigIHigIHigIHilojilojigIHigIHigIHigIHigIHigIHilojilojigIHigIHigIHigIHigIHigIHilojilojigIEK4oCB4paI4paI4paI4paI4paI4paI4oCB4paI4paI4oCBICDilojilojigIHilojilojigIEgIOKWiOKWiOKAgeKWiOKWiOKAgSDigIHilojilojilojilojigIHigIHilojilojilojilojilojilojigIHigIHilojilojilojilojilojilojilojigIEgICAg4paI4paI4oCBICAgICDilojilojigIEgIOKWiOKWiOKAgeKWiOKWiOKWiOKWiOKWiOKWiOKWiOKAgeKWiOKWiOKWiOKWiOKWiOKWiOKWiOKAgQog4oCB4oCB4oCB4oCB4oCB4oCB4oCB4oCB4oCB4oCBICDigIHigIHigIHigIHigIHigIEgIOKAgeKAgeKAgeKAgeKAgeKAgSAg4oCB4oCB4oCB4oCB4oCBIOKAgeKAgeKAgeKAgeKAgeKAgeKAgSDigIHigIHigIHigIHigIHigIHigIHigIEgICAg4oCB4oCB4oCBICAgICDigIHigIHigIEgIOKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgeKAgQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK4paI4paI4"
echo $changepass"paI4paI4paI4paI4oCBICDilojilojilojilojilojilojigIEgIOKWiOKWiOKWiOKWiOKWiOKWiOKAgSDilojilojilojilojilojilojilojilojigIEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCuKWiOKWiOKAgeKAgeKAgeKWiOKWiOKAgeKWiOKWiOKAgeKAgeKAgeKAgeKWiOKWiOKAgeKWiOKWiOKAgeKAgeKAgeKAgeKWiOKWiOKAgeKAgeKAgeKAgeKWiOKWiOKAgeKAgeKAgeKAgSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK4paI4paI4paI4paI4paI4paI4oCB4oCB4paI4paI4oCBICAg4paI4paI4oCB4paI4paI4oCBICAg4paI4paI4oCBICAg4paI4paI4oCBICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIArilojilojigIHigIHigIHilojilojigIHilojilojigIEgICDilojilojigIHilojilojigIEgICDilojilojigIEgICDilojilojigIEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCuKWiOKWiOKAgSAg4paI4paI4oCB4oCB4paI4paI4paI4paI4paI4paI4oCB4oCB4oCB4paI4paI4paI4paI4paI4paI4oCB4oCBICAg4paI4paI4oCBICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIArigIHigIHigIEgIOKAgeKAgeKAgSDigIHigIHigIHigIHigIHigIHigIEgIOKAgeKAgeKAgeKAgeKAgeKAgeKAgSAgICDigIHigIHigIEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAo=" | base64 -d
sudo passwd root
echo $changepass"oCBICAg4paI4paI4oCB4paI4paI4paI4paI4paI4paI4paI4oCB4paI4paI4paI4paI4paI4paI4paI4oCB4paI4paI4paI4paI4paI4paI4oCBICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIArilojilojigIEgICDilojilojigIHilojilojigIHigIHigIHigIHigIHigIHilojilojigIHigIHigIHigIHigIHigIHilojilojigIHigIHigIHilojilojigIEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK4paI4paI4oCBICAg4paI4paI4oCB4paI4paI4paI4paI4paI4paI4paI4oCB4paI4paI4paI4paI4paI4oCBICDilojilojilojilojilojilojigIHigIEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK4paI4paI4oCBICAg4paI4paI4oCB4oCB4oCB4oCB4oCB4oCB4paI4paI4oCB4paI4paI4oCB4oCB4oCB4oCBICDilojilojigIHigIHigIHilojilojigIEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK4oCB4paI4paI4paI4paI4paI4paI4oCB4oCB4paI4paI4paI4paI4paI4paI4paI4oCB4paI4paI4paI4paI4paI4paI4paI4oCB4paI4paI4oCBICDilojilojigIEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKIOKAgeKAgeKAgeKAgeKAgeKAgeKAgSDigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIHigIEgIOKAgeKAgeKAgSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK" | base64 -d
passwd

echo '' | sudo tee ~/.zlogin
rm -fv ~/user.sh #~/.zshrc.pre-oh-my-zsh 
#startx
reboot
