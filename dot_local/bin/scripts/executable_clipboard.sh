#!/bin/bash

usage() {
    echo "Usage: clipboard.sh [option]"
    echo "Options:"
    echo "  --show      Open the clipboard in a rofi menu"
    echo "  --clear     Clear the clipboard"
    echo "  --help      Show this menu"
}

case "$1" in 
    --show)
        output=$(cliphist list | rofi -kb-remove-char-forward "" -kb-custom-1 "Ctrl+d" -dmenu -config "$XDG_CONFIG_HOME/rofi/clipboard.rasi")
        if [ "$?" -eq 10 ]; then
            echo "$output" | cliphist delete
            clipboard.sh --show
        else
            echo "$output" | cliphist decode | wl-copy
        fi
        ;;
    --clear)
        notify-send -e -u low -t 2000 "Clipboard cleared" -h string:x-canonical-private-synchronous:clipboard
        wl-copy ""
        sleep 0.1
        rm "$XDG_CACHE_HOME/cliphist/db"
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
