#!/bin/bash
# small script that watches for monitors being plugged/unplugged and deals with them accordingly
# this is messy as hell but i didnt want to mess with udev stuff, felt easier to script
# https://unix.stackexchange.com/a/628067

# 03/04/22: for some fuckin reason my monitor is no longer detected by my linux install and i dont know why?
# this worked for a little bit but not sure if i can reccommend this script at all
# ah whatever im sure someone will get a use out of it

monitor_xevents() {
    local connected_monitors=();
    local monitor;
    for monitor in $(xrandr --listactivemonitors | awk '/^\s+[0-9]+:/ {print $4}'); do
        connected_monitors+=("$monitor")
    done

    xev -root -event randr -1 | stdbuf --output=L gawk --sandbox \
        --source "BEGIN{$(printf -- 'monitors["%s"]=1\n' ${connected_monitors[@]})}" \
        --source 'BEGIN {
            pat=@/output (.[^,]*),.*connection RR_(\w+),/
            for (monitor in monitors)
                print monitor, "connected"
        }
        !/crtc None/ && match ($0, pat, s) {
            # Newly discovered monitor at runtime
            if (!(s[1] in monitors)) {
                monitors[s[1]] = 1
                print s[1], "connected"
                next
            }
            switch (s[2]) {
                case "Connected":
                    if (!monitors[s[1]])
                        monitors[s[1]] = 1
                    else next
                    break
                case "Disconnected":
                    if (monitors[s[1]])
                        monitors[s[1]] = 0
                    else next
                    break
            }
            print s[1], tolower(s[2])
        }'
}

# this array acts like a stack of monitors.
# every time a monitor is detected, it gets added to this list and is placed to the right of the previous.
# it is initiated with the laptops screen (which you may need to change), as that one will never need to be disconnected or turned off.
monitors=("eDP1"); # eDP1 is the monitor of the laptop. we'll assume this one is always active.
while read output status; do
    printf "$output was $status\n";
    if [ $output != "eDP1" ]; then
        if [ $status == "connected" ]; then
            xrandr --output $output --right-of ${monitors[-1]} --auto;
            monitors+=("${output}");
        elif [ $status == "disconnected" ]; then
            xrandr --output $output --off;
            i=0;
            for value in "${monitors[@]}"; do
                if [ $value == $output ]; then
                    unset 'monitors[$i]';
                    break;
                fi
                #echo "infinite loop?";
                ((i++));
            done
        fi
        #echo $monitors;
    fi
done < <(monitor_xevents)

