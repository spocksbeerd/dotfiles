#!/bin/bash

current_brightness=$(brightnessctl get)

if [ "$current_brightness" -le 15612 ]; then
    brightnessctl set 25%
elif [ "$current_brightness" -le 31225 ]; then
    brightnessctl set 50%
elif [ "$current_brightness" -le 46837 ]; then
    brightnessctl set 75%
elif [ "$current_brightness" -le 62450 ]; then
    brightnessctl set 100%
elif [ "$current_brightness" -le 62451 ]; then
    brightnessctl set 5%
fi
