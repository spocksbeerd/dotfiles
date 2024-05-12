#!/bin/bash

layout_dir=~/.local/bin/layouts
current_layout=$(cat $layout_dir/currentlayout)

if [ "$current_layout" = "focused" ]; then
    cp -r $layout_dir/alacritty_pretty.toml ~/.config/alacritty/window.toml
    cp -r $layout_dir/polybar_pretty.ini ~/.config/polybar/colors.ini
    cp -r $layout_dir/picom_pretty ~/.config/picom/picom.conf
    cp -r $layout_dir/bspwm_pretty ~/.config/bspwm/appearance

    echo "pretty" > $layout_dir/currentlayout
else
    cp -r $layout_dir/alacritty_focused.toml ~/.config/alacritty/window.toml
    cp -r $layout_dir/polybar_focused.ini ~/.config/polybar/colors.ini
    cp -r $layout_dir/picom_focused ~/.config/picom/picom.conf
    cp -r $layout_dir/bspwm_focused ~/.config/bspwm/appearance

    echo "focused" > $layout_dir/currentlayout
fi

bspc wm -r
