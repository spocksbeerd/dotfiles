#!/bin/bash

layout_dir=~/.local/bin/layouts
current_layout=$(cat $layout_dir/currentlayout)

if [ "$current_layout" = "focused" ]; then
    cp -r $layout_dir/i3pretty ~/.config/i3/appearance
    picom -b &
    echo "pretty" > $layout_dir/currentlayout
else
    cp -r $layout_dir/i3focused ~/.config/i3/appearance
    pkill picom
    echo "focused" > $layout_dir/currentlayout
fi

i3-msg restart
