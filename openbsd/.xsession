export PATH=$HOME/bin:$PATH

export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="chrome"
export READER="zathura"
export CLICOLOR=1
export PAGER=less
export LESS='-iMRS -x2'

# use UTF-8 everywhere
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# specify location of kshrc
export ENV=$HOME/.kshrc

# load Xresources file
xmodmap ~/.Xmodmap
xrdb -merge $HOME/.Xresources

# set your background color
xsetroot -solid "#1d2021"

# hide cursore
unclutter -root -idle 2 -noevents &

# xidle will lock your display after a period of inactivity
xidle &

# disable system beep
xset b off

# use caps lock as ctrl key
#setxkbmap -option ctrl:nocaps

# mute microphone
mixerctl record.volume.mute=on

# if you have a ThinkPad, the following lines enable TrackPoint
# deactivate touchpad
# synclient TouchpadOff=1
# activate scroll wheel button
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation" 1
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Axes" 6 7 4 5
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Button" 2
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Timeout" 50
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Inertia" 3
# increase pointer speed
xinput set-prop "/dev/wsmouse" "Device Accel Constant Deceleration" 0.4

# Run notification-daemon
dunst &

# start cwm
exec cwm
