#!/bin/bash

if ! command -v pamixer &> /dev/null; then
    . "volume_fallback.sh" "$1"
    exit
fi

usage() {
    echo "Usage: volume.sh [option]"
    echo "Options:"
    echo "  --up       Set the sound volume one step higher"
    echo "  --down     Set the sound volume one step lower"
    echo "  --mute     Toggle the mute state"
    echo "  --help     Show this menu"
}

STEP=5

unmute() {
    pamixer --unmute
}

toggle_mute() {
    pamixer --toggle-mute
    is_mute="$(pamixer --get-mute)"

    if [ "$is_mute" = "true" ];
    then
        notify-send -e -u low -t 2000 "Volume: muted" -h string:x-canonical-private-synchronous:volume
    else
        notify
    fi
}

increase() {
    pamixer --increase "$STEP"
}

decrease() {
    pamixer --decrease "$STEP"
}

notify() {
    volume="$(pamixer --get-volume)"
    notify-send -e -u low -t 2000 -h int:value:"$volume" "Volume: $volume%" -h string:x-canonical-private-synchronous:volume
}

case "$1" in
    --up)
        unmute
        increase
        notify
        ;;
    --down)
        unmute
        decrease
        notify
        ;;
    --mute)
        toggle_mute
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
