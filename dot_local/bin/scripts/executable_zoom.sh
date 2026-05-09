#!/bin/bash

usage() {
    echo "Usage: zoom.sh [option]"
    echo "Options:"
    echo "  --in        Zoom in"
    echo "  --out       Zoom out"
    echo "  --reset     Reset the zoom level"
    echo "  --help      Show this menu"
}

get_zoom_factor() {
    hyprctl getoption cursor:zoom_factor | awk -F ":" '/float/ {print $2}'
}

ZOOM_STEP=0.2
MAX_ZOOM=5.0
MIN_ZOOM=1.0

case "$1" in
    --in)
        current_zoom="$(get_zoom_factor)"
        new_zoom=$(echo "$current_zoom + $ZOOM_STEP" | bc -l)
        if (( $(echo "$new_zoom <= $MAX_ZOOM" | bc -l) )); then
            hyprctl keyword cursor:zoom_factor "$new_zoom"
        fi
        ;;
    --out)
        current_zoom="$(get_zoom_factor)"
        new_zoom=$(echo "$current_zoom - $ZOOM_STEP" | bc -l)
        if (( $(echo "$new_zoom >= $MIN_ZOOM" | bc -l) )); then
            hyprctl keyword cursor:zoom_factor "$new_zoom"
        fi
        ;;
    --reset)
        hyprctl keyword cursor:zoom_factor 1.0
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
