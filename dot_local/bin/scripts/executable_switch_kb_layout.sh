#!/bin/bash

kb_name=$(hyprctl devices -j | jq -r ".keyboards[] | select(.main == true) | .name" )
hyprctl switchxkblayout "$kb_name" next > /dev/null
# layout=$(hyprctl devices -j | jq -r ".keyboards[] | select(.main == true) | .active_keymap")
# notify-send -e -u low "$layout" -t 1000 -h string:x-canonical-private-synchronous:kblayout
# dms notify --app "Keyboard Layout" --timeout 1000 "$layout"
