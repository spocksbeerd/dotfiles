#!/bin/bash

scriptdir=~/.local/bin/switchlayout
current_layout=$(cat $scriptdir/currentlayout)

if [ "$current_layout" = "focused" ]; then
    cp -r $scriptdir/i3pretty ~/.config/i3/appearance
    cp -r $scriptdir/polybarpretty ~/.config/polybar/border.ini
    picom -b &
    echo "pretty" > $scriptdir/currentlayout
else
    cp -r $scriptdir/i3focused ~/.config/i3/appearance
    cp -r $scriptdir/polybarfocused ~/.config/polybar/border.ini
    pkill picom
    echo "focused" > $scriptdir/currentlayout
fi

i3-msg restart
