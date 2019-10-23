#!/bin/bash
export PATH=$HOME/bin:$PATH

export EDITOR="nvim"
export TERMINAL="st"
export READER="zathura"
export BROWSER="firefox"
export CLICOLOR=1
export PAGER=less
export LESS='-iMRS -x2'

# use UTF-8 everywhere
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# specify location of bashrc
export ENV=$HOME/.bashrc

# load Xresources file
xmodmap ~/.Xmodmap
xrdb -merge $HOME/.Xresources

# disable system beep
xset b off

# Set your background color
xsetroot -solid "#1d2021"
# Set your background wallpaper
xwallpaper --center $HOME/pics/raspberry-pi-wallpapers-1920x1080.jpg
# Hide cursore
unclutter -root -idle 3 -noevents &
# Run notification-daemon
dunst &
# Turns NumLock on in X
numlockx on &
# Pi4 outputs audio over the 3.5mm audio port
amixer cset numid=3 2 &

# Start dwm
while true
do
    dwmstatus
    sleep 2s
done &
exec dwm
