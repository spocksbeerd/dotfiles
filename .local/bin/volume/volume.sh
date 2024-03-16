#!/bin/bash

if ! command -v pamixer &> /dev/null; then
    . "$HOME/.local/bin/changevol_fallback.sh" "$1"
    exit
fi

step=5

unmute() {
    pamixer --unmute
}

toggle_mute() {
    pamixer --toggle-mute
    is_mute="$(pamixer --get-mute)"

    if [ "$is_mute" = "true" ];
    then
        dunstify -u low -r 2345 "Volume: muted" -t 2000
    else
        notify
    fi
}

increase() {
    pamixer --increase "$step"
}

decrease() {
    pamixer --decrease "$step"
}

notify() {
    volume="$(pamixer --get-volume)"
    dunstify -u low -r 2345 -h int:value:"$volume" "Volume: $volume%" -t 2000 
}

case "$1" in
    up)
        unmute
        increase
        notify
	;;

    down)
        unmute
        decrease
        notify
	;;
    mute)
        toggle_mute
	;;
esac
