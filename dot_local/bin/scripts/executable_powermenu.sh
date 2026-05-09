#!/bin/bash

option=$(printf "  Reboot\n  Shutdown\n󰖔  Suspend\n󰍃  Logout\n  Lock" | rofi -dmenu -config "$XDG_CONFIG_HOME/rofi/generic_menu.rasi")

case "$option" in
	"  Reboot") reboot ;;
	"  Shutdown") shutdown now ;;
	"󰖔  Suspend") systemctl suspend ;;
    "󰍃  Logout") pkill -KILL -u "$USER" ;;
	"  Lock") lockscreen.sh ;;
	*) exit 1 ;;
esac
