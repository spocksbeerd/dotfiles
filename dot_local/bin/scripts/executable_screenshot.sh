#!/bin/bash

if pgrep -x "slurp" > /dev/null
then
    exit 0
fi

screenshot_path=~/Pictures/screenshots/$(date +%Y-%m-%d_%H-%M-%S-%3N).png

usage() {
    echo "Usage: screenshot.sh [option]"
    echo "Options:"
    echo "  --fullscreen    Take a screenshot of the entire screen"
    echo "  --selection     Take a screenshot of the selected area"
    echo "  --help          Show this menu"
}

quality_of_life() {
    paplay "$HOME/.local/share/sfx/screenshot.mp3"
    wl-copy < "$screenshot_path"
    option=$(notify-send "Screenshot saved" -i $screenshot_path -a "Screenshot" -A open="Open" --wait)
    if [ "$option" = "open" ]; then
        qview "$screenshot_path" &
    fi
}

case "$1" in 
    --fullscreen)
        grim "$screenshot_path"
        quality_of_life
        ;;
    --selection)
        grim -g "$(slurp -w 1 -b "#00000080" -c "#A7C080")" "$screenshot_path"
        if [[ $? -eq 0 ]]; then
            quality_of_life
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
