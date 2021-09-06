#!/bin/bash
#echo "read the readme or something might go wrong and that's very very no good bad bad :(((("
#echo "have you read the readme?"
#if no quit
#if yes do:

curr_dir=$(pwd)

sudo pacman -Syyu --noconfirm
sudo pacman -S --noconfirm xf86-video-intel xf86-video-vesa xf86-video-fbdev
sudo pacman -S --noconfirm xorg-server xorg-xinit libx11 libxinerama libxft webkit2gtk

# set keymap and layout
sudo localectl --no-ask-password set-keymap pt-latin1

# move config files that don't depend on anything
mkdir ~/packages
mkdir ~/.config
cp -rf dmenu dwm st ~/packages
cp -rf .moc wallpapers ~
cp -f .bash_profile .fehbg .xbindkeysrc .xprofile .Xresources ~
mkdir ~/.local/bin

#move scripts
sudo cp -fa scripts/* /usr/local/bin

# build st and dwm
cd ~/packages/st
sudo make clean install
sudo make clean
cd ~/packages/dmenu
sudo make clean install
sudo make clean
sudo pacman -S --noconfirm xorg-xsetroot awesome-terminal-fonts
cd ~/packages/dwm
sudo make clean install
sudo make clean
cd $curr_dir
# picom compositor
sudo pacman -S --noconfirm picom
# background
sudo pacman -S --noconfirm feh
# reloading the Xresources config
sudo pacman -S --noconfirm xorg-xrdb
xrdb ~/.Xresources

# setup lightdm
sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter
sudo cp -f lightdm.conf /etc/lightdm
sudo mkdir /usr/share/xsessions
sudo cp -f dwm.desktop /usr/share/xsessions
sudo systemctl --no-ask-password enable lightdm

# install mounting utility
sudo pacman -S --noconfirm udisks2 ntfs-3g

# install backlight utility
sudo pacman -S --noconfirm xorg-xbacklight

# install audio and bluetooth utilities
sudo pacman -S --noconfirm pulseaudio pulseaudio-alsa pavucontrol
sudo pacman -S --noconfirm bluez bluez-utils pulseaudio-bluetooth
sudo systemctl --no-ask-password start bluetooth.service
sudo systemctl --no-ask-password enable bluetooth.service

# trackpad and mouse config
sudo cp -f 30-touchpad.conf /etc/X11/xorg.conf.d/

# screenshotting
sudo pacman -S --noconfirm scrot
mkdir ~/screenshots

# OPTIONAL
# automounting shared
sudo cp -f run-media-retchut-shared.mount /etc/systemd/system   # edit this line
sudo systemctl --no-ask-password daemon-reload
sudo systemctl --no-ask-password start run-media-retchut-shared.mount
sudo systemctl --no-ask-password enable run-media-retchut-shared.mount

# load my pacman configuration (enabled multilib (for steam) and G14 repo (for asusctl))
sudo cp -f pacman.conf /etc
sudo pacman -Syyu --noconfirm

# load keybindings (audio control, asus fan control, screenshots, trackpad)
sudo pacman -S --noconfirm xbindkeys xorg-xinput
xbindkeys --poll-rc

# yay
cd /tmp/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg --noconfirm -si
cd $curr_dir

# other apps
sudo pacman -S --noconfirm man-db man-pages unzip unrar bc neofetch mpv mesa-demos # utilities
sudo pacman -S --noconfirm firefox nautilus vlc anki discord gimp libreoffice-still audacity shotcut
yay -S --nocleanmenu --nodiffmenu --noeditmenu --noupgrademenu --removemake --cleanafter --nopgpfetch --noprovides --sudoloop --noconfirm visual-studio-code-bin ttf-ms-fonts xinput-toggle simple-mtpfs

# gaming
sudo pacman -S --noconfirm steam pcsx2 desmume # steam needs the Arial font

# import moc-pulse's gpg key
# TODO: this is probably a HUGE security risk, I should look into this
gpg --recv-keys F3121E4F2885A7AA
yay -S --nocleanmenu --nodiffmenu --noeditmenu --noupgrademenu --removemake --cleanafter --nopgpfetch --noprovides --sudoloop --noconfirm  moc-pulse
sudo pacman -S --noconfirm wavpack

# OPTIONAL
# install japanese input utilities
sudo pacman -S --noconfirm fcitx-im fcitx-configtool fcitx-mozc adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts
echo "export GTK_IM_MODULE='fcitx'" | sudo tee -a /etc/profile
echo "export QT_IM_MODULE='fcitx'" | sudo tee -a /etc/profile
echo "export SDL_IM_MODULE='fcitx'" | sudo tee -a /etc/profile
echo "export XMODIFIERS='@im=fcitx'" | sudo tee -a /etc/profile

# install droidcam
sudo pacman -S --noconfirm wget linux-headers
cd /tmp/
wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.7.3.zip
unzip droidcam_latest.zip -d droidcam
cd droidcam && sudo ./install-client && sudo ./install-video
sudo pacman -S --noconfirm libappindicator-gtk3

# asus laptop (asusctl)
# read more at https://asus-linux.org/wiki/arch-guide/
sudo pacman -S --noconfirm asusctl
sudo pacman -S --noconfirm nvidia-dkms # install nvidia drivers
sudo pacman -S --noconfirm lib32-nvidia-utils # some games on steam are still 32 bit
sudo pacman -S --noconfirm nvidia-prime # for prime gpu switching

echo ""
echo "after rebooting:"
echo "--> run 'setxkbmap -layout pt' if X is not using the pt keymap"
echo "--> you need to configure mozc using the fcitx-config tool afterwards"

echo ""
echo "don't forget to add `prime-run %command%` to the launch options of games on steam"
