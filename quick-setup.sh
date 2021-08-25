#!/bin/bash
#echo "read the readme or something might go wrong and that's very very no good bad bad :(((("
#echo "have you read the readme?"
#if no quit
#if yes do:

curr_dir=$(pwd)

sudo pacman -Syyu --noconfirm
sudo pacman -S --noconfirm xorg-server xorg-xinit libx11 libxinerama libxft webkit2gtk

# set keymap and layout
sudo localectl --no-ask-password set-keymap pt-latin1

# move config files that don't depend on anything
mkdir ~/packages
mkdir ~/.config
cp -rf dmenu dwm st ~/packages
cp -rf wallpapers ~
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
sudo pacman -S --noconfirm firefox nautilus vlc mpv anki discord gimp libreoffice-still neofetch unzip unrar bc audacity shotcut
sudo pacman -S --noconfirm steam pcsx2 # steam needs the Arial font
yay -S --nocleanmenu --nodiffmenu --noeditmenu --noupgrademenu --removemake --cleanafter --nopgpfetch --noprovides --sudoloop visual-studio-code-bin ttf-ms-fonts
# import moc-pulse's gpg key
# TODO: this is probably a HUGE security risk, I should look into this
gpg --recv-keys F3121E4F2885A7AA
yay -S --nocleanmenu --nodiffmenu --noeditmenu --noupgrademenu --removemake --cleanafter --nopgpfetch --noprovides --sudoloop moc-pulse
sudo pacman -S --noconfirm wavpack

# OPTIONAL
# install japanese input utilities
sudo pacman -S --noconfirm fcitx-im fcitx-configtool fcitx-mozc adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts

# install droidcam
sudo pacman -S --noconfirm wget linux-headers
cd /tmp/
wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.7.3.zip
unzip droidcam_latest.zip -d droidcam
cd droidcam && sudo ./install-client && sudo ./install-video
sudo pacman -S --noconfirm libappindicator-gtk3

# asus laptop (asusctl) read more at https://asus-linux.org/wiki/arch-guide/
sudo pacman -S --noconfirm asusctl
sudo pacman -S --noconfirm linux-g14 linux-g14-headers  # load custom kernel
sudo grub-mkconfig -o /boot/grub/grub.conf       # regenerate grub configuration
sudo pacman -S --noconfirm nvidia-dkms      # install nvidia drivers

echo ""
echo "keybindings were setup for my hardware, so I recommend you edit the .xbindkeysrc with the keys you wish to bind to the commands in the file (and change the devices mentioned by some commands), which was copied to your home folder, then run xbindkeys --poll-rc"
echo "you can use xbindkeys --multikey or xbindkeys --key to get a key's keycode"
echo "the format of .xbindkeysrc is as follows"
echo "\"command\""
echo "\tkeycode"

echo ""
echo "after rebooting:"
echo "--> run 'feh --bg-scale ~/wallpapers/wallpaper.jpg' to apply a wallpaper"
echo "--> run 'setxkbmap -layout pt' if X is not using the pt keymap"
echo "--> you need to configure mozc using the fcitx-config tool afterwards"
echo "--> to use mozc with the suckless simple terminal, add the following lines to your /etc/profile file:"
echo "export GTK_IM_MODULE='fcitx'"
echo "export QT_IM_MODULE='fcitx'"
echo "export SDL_IM_MODULE='fcitx'"
echo "export XMODIFIERS='@im=fcitx'"
