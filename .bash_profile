#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

startx

export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export SDL_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'
