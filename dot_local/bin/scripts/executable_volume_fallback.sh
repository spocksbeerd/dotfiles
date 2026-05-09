#!/bin/bash

usage() {
    echo "Usage: volume_fallback.sh [option]"
    echo "Options:"
    echo "  --up       Set the sound volume one step higher"
    echo "  --down     Set the sound volume one step lower"
    echo "  --mute     Toggle the mute state"
    echo "  --help     Show this menu"
}

get_volume() {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1
}

set_volume() {
    pactl set-sink-volume @DEFAULT_SINK@ "$1"
}
    
notify() {
    volume="$(get_volume)"
    notify-send -e -u low -t 2000 -h int:value:"$volume" "Volume: $volume%" -h string:x-canonical-private-synchronous:volume
}

set_mute() {
    pactl set-sink-mute @DEFAULT_SINK@ "$1"
}

toggle_mute() {
    set_mute toggle
    mute_state="$(pactl get-sink-mute @DEFAULT_SINK@)"

    if [ "$mute_state" = "Mute: yes" ];
    then
        notify-send -e -u low -t 2000 "Volume: muted" -h string:x-canonical-private-synchronous:volume
    else
        notify
    fi
}

case "$1" in
    --up)
        set_mute 0
        set_volume +5%
        notify
        ;;
    --down)
        set_mute 0
        set_volume -5%
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
