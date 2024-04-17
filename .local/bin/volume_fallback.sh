#!/bin/bash

get_volume() {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1
}

set_volume() {
    pactl set-sink-volume @DEFAULT_SINK@ "$1"
}
    
notify() {
    volume="$(get_volume)"
    dunstify -u low -r 2345 -h int:value:"$volume" "Volume: $volume%" -t 2000 
}

set_mute() {
    pactl set-sink-mute @DEFAULT_SINK@ "$1"
}

toggle_mute() {
    set_mute toggle
    mute_state="$(pactl get-sink-mute @DEFAULT_SINK@)"

    if [ "$mute_state" = "Mute: yes" ];
    then
        dunstify -u low -r 2345 "Volume: muted" -t 2000
    else
        notify
    fi
}

case "$1" in
    up)
        set_mute 0
        set_volume +5%
        notify
	;;

    down)
        set_mute 0
        set_volume -5%
        notify
	;;
    mute)
        toggle_mute
	;;
esac
