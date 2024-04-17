#!/bin/bash

theme=$(printf "catppuccin\ndracula\ngruvbox\nnord\nrosepine" | rofi -dmenu)
themedir=~/.local/bin/themes

if [ "$theme" = "" ]; then 
    exit 1
fi

# i3
if [ -d "$HOME/.config/i3" ];
then
    cp -f ${themedir}/i3/${theme} ~/.config/i3/colors
fi
    
# polybar
if [ -d "$HOME/.config/polybar" ];
then
    cp -f ${themedir}/polybar/${theme}.ini ~/.config/polybar/colors.ini
fi

# alacritty
if [ -d "$HOME/.config/alacritty" ];
then
    cp -f ${themedir}/alacritty/${theme}.toml ~/.config/alacritty/colors.toml
fi

# rofi
if [ -d "$HOME/.config/rofi" ];
then
    cp -f ${themedir}/rofi/${theme}.rasi ~/.config/rofi/colors.rasi
fi

# dunst
if [ -d "$HOME/.config/dunst" ];
then
    cp -f ${themedir}/dunst/${theme} ~/.config/dunst/colors
fi

i3-msg restart
