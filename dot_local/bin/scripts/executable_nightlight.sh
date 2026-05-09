#!/bin/bash

usage() {
    echo "Usage: nightlight.sh [option]"
    echo "Options:"
    echo "  --set [value]    Set the screen temperature in kelvin in the 1000:25000 range"
    echo "  --toggle         Toggle on/off"
    echo "  --help           Show this menu"
}

set_temperature() {
    gammastep -t "$1":"$1" -l 1.0:1.0 -r &
}

case "$1" in 
    --set)
        pkill gammastep
        set_temperature "$2"
        echo "$2" > "$HOME/.cache/nightlight"
        ;;
    --toggle)
        if pgrep -x "gammastep" > /dev/null
        then
            pkill gammastep
        else
            temperature=$(cat $HOME/.cache/nightlight)
            set_temperature "$temperature"
        fi
        ;;
    --help)
        usage
        ;;
    *)
        echo "Invalid option: \"$1\"" >&2
        usage
        exit 1
        ;;
esac
