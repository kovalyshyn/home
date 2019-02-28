xset -b

[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -f ~/.Xdefaults ] && xrdb -merge ~/.Xdefaults

# GNOME keyring
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Autostart section
nm-applet &
unclutter &
dunst &
mpd &
redshift &
setbackground &
setscreenlayout &

while true
do
    dwmstatus
    sleep 2s
done &

exec dwm
