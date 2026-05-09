#!/bin/bash

usage() {
    echo "Usage: wallpaper.sh [option]"
    echo "Options:"
    echo "  --restore      Apply the last set wallpaper"
    echo "  --set          Set a new wallpaper"
    echo "  --help         Show this menu"
}

case "$1" in
    --restore)
        current_wallpaper=$(cat "$HOME/.cache/wallpaper")
        swaybg -m fill -i "$HOME/Pictures/wallpapers/$current_wallpaper" &
        ;;
    --set)
        wallpaper=$(ls "$HOME/Pictures/wallpapers" | rofi -dmenu -config "$XDG_CONFIG_HOME/rofi/generic_menu.rasi")

        if [ "$wallpaper" = "" ]; then
            exit 1
        fi

        pkill swaybg
        swaybg -m fill -i "$HOME/Pictures/wallpapers/$wallpaper" &
        echo "$wallpaper" > "$HOME/.cache/wallpaper"
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
