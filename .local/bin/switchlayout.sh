#!/bin/bash

layout_dir=~/.local/bin/layouts
current_layout=$(cat $layout_dir/currentlayout)

if [ "$current_layout" = "focused" ]; then
    cp -r $layout_dir/i3pretty ~/.config/i3/appearance

    bspc config window_gap 8
    bspc config borderless_monocle false

    picom -b &
    echo "pretty" > $layout_dir/currentlayout
else
    cp -r $layout_dir/i3focused ~/.config/i3/appearance

    bspc config window_gap 0
    bspc config borderless_monocle true

    pkill picom
    echo "focused" > $layout_dir/currentlayout
fi

i3-msg restart
