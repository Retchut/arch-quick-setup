# arch-quick-setup

# How to use
First of all install arch (duh).
Now simply clone this repository, navigate to it and run the quick-setup.sh script.

There shouldn't be any issue with running this script on a non-clean install, but I cannot guarantee nothing will break. Please notify me if you come across any bugs, or want to roast my god awful shell scripts.

***Note: Some things this script does do not particularly interest most people. Read the next section for details***

If you are still here after reading the wall of text that follows, go forth, friendo, no more tweaking required! Run the script, let it do its thing, and, most importantly, be happy =)

# Tweaks / Optional shenanigans
The relevant portions of the script are marked with a, quite appropriate, in my opinion, "OPTIONAL" comment.

## dwm keybindings
I took the liberty of slightly modifying the dwm keybindings (and quite possibly also st and dmenu's).

One such modification which instantly springs to mind is the modkey. On my build, the modkey is set to the windows key, instead of the left alt.

If I remember any more changes, I'll be sure to update this section.

## monitor scripts
I made a few scripts to easily configure the output to an external monitor. Right now, I only have one to mirror the output of both screens (which will work even between monitors with different resolutions), but it needs to be configured before it can be run.

To configure a script, edit said script and fill in the square brackets with the correct information. They're all inside the scripts folder, and will all be copied to /usr/local/bin

## Auto mounting a partition on start up:
I sometimes find the necessity to have a shared partition, hence this.

The file run-media-retchut-shared.mount contains data related to the partition that will be mounted on startup.

Its name must be the same as the directory it will be mounted in. (or so a little bird online told me).

As such, the aforementioned file shall be mounted at /run/media/retchut/shared.

If you are interested in setting this up, you must:

	1)Edit the aforementioned file and change its values according to the partition you are trying to mount

	2)Edit the file name to reflect the path in the file

If this doesn't interest you, simply comment out this portion of the script.

## Asusctl
If you don't have an asus gaming laptop just comment out this portion of the script. Furthermore, if it helps you sleep tonight, feel free to remove the G14 repo entry from the pacman.conf file. It's just the repo holding these utilities.

Also, do yourself a favour and don't buy an asus gaming laptop if you intend to use linux, at least for now.

If you do have an asus gaming laptop and have never used this tool, I have no idea how you're still sane.

For this last demogrphic, there is no tweaking necessary, you can just let the script do its thing. The script will install helpful utilities, and from thereon out you should get your nvidia drivers from the nvidia-dkms package.

I do recommend reading their website, however: https://asus-linux.org/

## Keybindings
The keybindings inside the .xbindkeysrc file were setup for my hardware. I recommend commenting them out before you're sure the keys that trigger the commands are the ones you are accustomed to.
You can check your keys' keycodes by running `xbindkeys --key/--multikey`.

## Fcitx japanese input with mozc
If this doesn't interest you, just uncomment this portion of the script.

Additionally, you ought to edit two dotfiles:

	1).xprofile 	--> remove the line that starts fcitx
	2).bash_profile --> remove the 4 lines setting the input method global variables

#

The sections that follow enumerate what this script does right now, what it doesn't do yet, but might when I stop being lazy, and the last section contains a full(-ish) list of the programs this script will install.

# What this script will do
- Update the keymap to the pt-latin1 keymap (best keymap, don't @ me)
- Copy my dotfiles, each to its respective directory
- Install my version of the suckless dwm, st and dmenu utilities
- Move my status bar script to /usr/local/bin (for now this will do)
- Setup picom compositor, feh (background) and Xresources loading
- Setup lightdm login manager (not themed yet)
- Load my trackpad configuration (basically allowing natural scrolling on the trackpad, normal scrolling on the mouse)
- Setup automounting a partition on startup
- Load my pacman configuration (enables multilib and G14 repos)
- Installs the asusctl laptop utility (allows controlling the leds, cpu and gpu fans, gpu switching, among other things, in asus gaming laptops)
- Loads a custom kernel for use with the above utility
- Loads my keybindings (still quite incomplete)
- Installs yay
- Sets up fcitx mozc (japanese input)
- Sets up droidcam (my laptop does not have a webcam ;_; )
- Installs other programs I use

Whenever possible, systemd is used to auto-start services.
Some of these operations require some manual configuration afterwards, which is written to the stdout after the script finishes running

# Not yet implemented
- Still missing some keybindings
- Making everything prettier

Read the TODO.md file for more details.

# Notable utilities and programs installed
- dwm
- st
- dmenu
- lightdm (with the gtk greeter)
- picom
- feh
- udisks2 and ntfs-3g (easier way of mounting disks, including ntfs file systems)
- xorg-xbacklight (backlight control)
- pulseaudio (audio control - with bluetooth support)
- bluez	(bluetooth control)
- scrot (printscreens)
- mocp (cli music player)
- xbindkeys
- asusctl
- nvidia drivers, and gpu switching utilities
- yay
- nautilus (I don't like it, but eh)
- vlc
- anki (and mpv for audio in flashcards)
- discord
- gimp
- libreoffice
- neofetch
- unzip, unrar
- bc
- firefox
- steam
- vs code
- audacity
- fcitx-im (and its config tool)
- droidcam
