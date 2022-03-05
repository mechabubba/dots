#!/bin/sh
# some helper functions for dwmblocks
get_battery() {
    # you might need to change this path depending on your device
    read -r bat_status < /sys/class/power_supply/BAT0/status;
    read -r bat_capacity < /sys/class/power_supply/BAT0/capacity;
    
    if [ $((bat_capacity <= 50)) ]; then
        symbol="";
    elif [ $((bat_capacity <= 20)) ]; then
        symbol="";
    elif [ $((bat_capacity <= 10)) ]; then
        symbol="";
    elif [ bat_status == "Charging" ] || [ bat_status == "Full" ]; then
        symbol="";
    else
        symbol="";
    fi

    echo "$symbol $bat_capacity%";
}

"$@";

