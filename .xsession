#!/bin/bash
if [ -x "$(command -v picom)" ]; then
    picom -b;
fi
test -f ~/.fehbg && ~/.fehbg;

# @todo these dont work automatically because they need sudo (atleast systemctl does, cant remember if netctl does)
# should probably move these
systemctl start bluetooth.service;
netctl start eduroam; # connects to university wifi (you should remove this line if you dont have the same network profile installed)
netctl start ethernet; # ethernet

if [ -x "$(command -v dwmblocks)" ] && [ "$XDG_SESSION_DESKTOP" == "dwm" ]; then
    dwmblocks;
fi

