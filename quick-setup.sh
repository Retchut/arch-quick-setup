
#!/bin/bash
#echo "read the readme or something might go wrong and that's very very no good bad bad :(((("
#echo "have you read the readme?"
#if no quit
#if yes do:

curr_dir=$(pwd)

sudo pacman -Syyu --noconfirm
# install iGPU drivers
sudo pacman -S --noconfirm xf86-video-intel xf86-video-vesa xf86-video-fbdev
# install proprietary dGPU nvidia drivers
sudo pacman -S --noconfirm nvidia
sudo pacman -S --noconfirm xorg-server xorg-xinit libx11 libxinerama libxft webkit2gtk

# set keymap and layout
sudo localectl --no-ask-password set-keymap pt-latin1

echo "\n\n-----------------------------------MOVING DOTFILES/WM/DMENU/TERMEMU-------------------------------------"
# move config files that don't depend on anything
mkdir ~/packages
mkdir ~/.config
cp -rvf dmenu/ dwm/ st/ ~/packages
cp -rvf .moc/ wallpapers/ ~
cp -vf .bashrc .bash_aliases .bash_profile .fehbg .xbindkeysrc .xprofile .Xresources ~
cp -vf redshift.conf ~/.config
sudo cp -vf logind.conf /etc/systemd/logind.conf
mkdir ~/.local/
mkdir ~/.local/bin

echo "\n\n------------------------------------------------SCRIPTS-------------------------------------------------"
#move scripts
sudo cp -rvf scripts/* /usr/local/bin


echo "\n\n-----------------------------------------BUILD WM/DMENU/TERMEMU-----------------------------------------"
# build st and dwm
cd ~/packages/st
sudo make clean install
sudo make clean
cd ~/packages/dmenu
sudo make clean install
sudo make clean
sudo pacman -S --noconfirm xorg-xsetroot
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

echo "\n\n-------------------------------------------------------------LIGHTDM------------------------------------"
# setup lightdm
sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter
sudo cp -vf lightdm.conf /etc/lightdm
sudo mkdir /usr/share/xsessions
sudo cp -vf dwm.desktop /usr/share/xsessions
sudo systemctl --no-ask-password enable lightdm

echo "\n\n-----------------------------------------------------------UTILITIES------------------------------------"
# partition mounting utility
echo "\n\n-----------------------------------------------------------Partition Mounting------------------------------------"
sudo pacman -S --noconfirm udisks2 ntfs-3g
# backlight control
echo "\n\n-----------------------------------------------------------Backlight------------------------------------"
sudo pacman -S --noconfirm brightnessctl
# blue light filter
echo "\n\n-----------------------------------------------------------Redshift------------------------------------"
sudo pacman -S --noconfirm redshift
# install audio and bluetooth
echo "\n\n-----------------------------------------------------------Audio------------------------------------"
sudo pacman -S --noconfirm pulseaudio pulseaudio-alsa pavucontrol
echo "\n\n-----------------------------------------------------------Bluetooth------------------------------------"
sudo pacman -S --noconfirm bluez bluez-plugins bluez-utils pulseaudio-bluetooth
sudo systemctl --no-ask-password enable bluetooth.service
# trackpad and mouse config
echo "\n\n-----------------------------------------------------------Trackpad/Mouse------------------------------------"
sudo cp -vf 30-touchpad.conf /usr/share/X11/xorg.conf.d/
# screenshots
echo "\n\n-----------------------------------------------------------Screenshots------------------------------------"
sudo pacman -S --noconfirm scrot
mkdir ~/screenshots

# OPTIONAL
# automounting shared
echo "\n\n-----------------------------------------------------------Automounting Shared Partition------------------------------------"
sudo cp -vf run-media-retchut-shared.mount /etc/systemd/system   # edit this line
sudo systemctl --no-ask-password daemon-reload
sudo systemctl --no-ask-password start run-media-retchut-shared.mount # make sure there was no issue starting the service
sudo systemctl --no-ask-password enable run-media-retchut-shared.mount

# load my pacman configuration (enabled multilib (for steam and other goodies) and G14 repo (for asusctl))
echo "\n\n-----------------------------------------------------------Multilib------------------------------------"
sudo cp -vf pacman.conf /etc
sudo pacman -Syyu --noconfirm

# load keybindings (audio control, asus fan control, screenshots, trackpad)
echo "\n\n-----------------------------------------------------------Keybindings------------------------------------"
sudo pacman -S --noconfirm xbindkeys xorg-xinput
xbindkeys --poll-rc

# yay
echo "\n\n-----------------------------------------------------------YAY------------------------------------"
cd /tmp/;
git clone https://aur.archlinux.org/yay.git;
cd yay;
makepkg --noconfirm -si;
cd $curr_dir

# other apps
echo "\n\n-----------------------------------------------------------System Utils------------------------------------"
sudo pacman -S --noconfirm man-db man-pages xclip zip unzip bc calc baobab neofetch mpv mesa-demos nm-connection-editor networkmanager-pptp android-file-transfer # utilities 
yay -S --nocleanmenu --nodiffmenu --noeditmenu --noupgrademenu --removemake --cleanafter --nopgpfetch --noprovides --sudoloop --noconfirm xinput-toggle rar
echo "\n\n-----------------------------------------------------------Fonts------------------------------------"
yay -S --nocleanmenu --nodiffmenu --noeditmenu --noupgrademenu --removemake --cleanafter --nopgpfetch --noprovides --sudoloop --noconfirm ttf-ms-fonts ttf-font-awesome-5
echo "\n\n-----------------------------------------------------------Multimedia Utils------------------------------------"
sudo pacman -S --noconfirm firefox nautilus vlc discord gimp libreoffice-still vlc
echo "\n\n-----------------------------------------------------------Development Utils------------------------------------"
sudo pacman -S --noconfirm docker docker-compose nodejs npm python-pip # development
yay -S --nocleanmenu --nodiffmenu --noeditmenu --noupgrademenu --removemake --cleanafter --nopgpfetch --noprovides --sudoloop --noconfirm visual-studio-code-bin


# gaming
echo "\n\n-----------------------------------------------------------Gaming------------------------------------"
sudo pacman -S --noconfirm steam lutris # steam needs the Arial font
yay -S --nocleanmenu --nodiffmenu --noeditmenu --noupgrademenu --removemake --cleanafter --nopgpfetch --noprovides --sudoloop --noconfirm pcsx2 bottles

# import moc-pulse's gpg key
echo "\n\n-----------------------------------------------------------mocp------------------------------------"
# gpg --recv-keys F3121E4F2885A7AA
yay -S --nocleanmenu --nodiffmenu --noeditmenu --noupgrademenu --removemake --cleanafter --nopgpfetch --noprovides --sudoloop --noconfirm  moc-pulse
sudo pacman -S --noconfirm wavpack

# OPTIONAL
# install japanese input utilities
echo "\n\n-----------------------------------------------------------Japanese Study------------------------------------"
yay -S --nocleanmenu --nodiffmenu --noeditmenu --noupgrademenu --removemake --cleanafter --nopgpfetch --noprovides --sudoloop --noconfirm anki visual-studio-code-bin
sudo pacman -S --noconfirm fcitx-im fcitx-configtool fcitx-mozc adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts
echo "export GTK_IM_MODULE='fcitx'" | sudo tee -a /etc/profile
echo "export QT_IM_MODULE='fcitx'" | sudo tee -a /etc/profile
echo "export SDL_IM_MODULE='fcitx'" | sudo tee -a /etc/profile
echo "export XMODIFIERS='@im=fcitx'" | sudo tee -a /etc/profile

# install droidcam
echo "\n\n-----------------------------------------------------------Droidcam------------------------------------"
sudo pacman -S --noconfirm wget linux-headers
cd /tmp/
wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.7.3.zip
unzip droidcam_latest.zip -d droidcam
cd droidcam && sudo ./install-client && sudo ./install-video
sudo pacman -S --noconfirm libappindicator-gtk3

# asus laptop (asusctl)
# read more at https://asus-linux.org/wiki/arch-guide/
echo "\n\n-----------------------------------------------------------Asusctl------------------------------------"
sudo pacman -S --noconfirm asusctl
sudo pacman -S --noconfirm lib32-nvidia-utils # some games on steam are still 32 bit

echo "\n\n-----------------------------------------------------------Prime GPU switching------------------------------------"
sudo pacman -S --noconfirm nvidia-prime # for prime gpu switching
yay -S --nocleanmenu --nodiffmenu --noeditmenu --noupgrademenu --removemake --cleanafter --nopgpfetch --noprovides --sudoloop --noconfirm optimus-manager # for prime gpu switching
sudo cp optimus-manager.conf /etc/optimus-manager/optimus-manager.conf

echo "\n\n"
echo "after rebooting:"
echo "--> run 'setxkbmap -layout pt' if X is not using the pt keymap"
echo "--> you need to configure mozc using the fcitx-config tool afterwards"
echo "--> add yourself to the video, audio and input user groups"

echo ""
echo "don't forget to add \"prime-run %command%\" to the launch options of games on steam"
