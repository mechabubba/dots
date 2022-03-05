#!/bin/bash
if [ -x "$(command -v picom)" ]; then
    picom -b;
fi
test -f ~/.fehbg && ~/.fehbg;

systemctl start bluetooth.service;
netctl start eduroam; # connect to university wifi (you should remove this line if you dont have the same network profile installed)

dwmblocks;

# dwm status bar script
if [ "$XDG_SESSION_DESKTOP" == "dwm" ]; then
    ~/bin/dwm_status.sh &;
fi

