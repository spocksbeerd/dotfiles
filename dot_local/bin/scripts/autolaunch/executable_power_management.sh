#!/bin/bash

idle_daemon=hypridle

killall swayidle
killall hypridle

if [ "$idle_daemon" = "swayidle" ]; then
    swayidle -w \
        timeout 300 "hyprctl dispatch dpms off" \
        timeout 305 "lockscreen.sh" \
        timeout 600 "systemctl suspend" \
        before-sleep "lockscreen.sh" \
        after-resume "hyprctl dispatch dpms on" &
else
    hypridle > $HOME/.cache/hypridle.log 2>&1 &
fi
