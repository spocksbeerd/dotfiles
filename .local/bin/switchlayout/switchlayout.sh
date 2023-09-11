#!/bin/bash

scriptdir=~/.local/bin/switchlayout
current_layout=$(cat $scriptdir/currentlayout)

if [ "$current_layout" = "focused" ]; then
    cp -r $scriptdir/i3pretty ~/.config/i3/appearance
    picom -b &
    echo "pretty" > $scriptdir/currentlayout
else
    cp -r $scriptdir/i3focused ~/.config/i3/appearance
    pkill picom
    echo "focused" > $scriptdir/currentlayout
fi

i3-msg restart
