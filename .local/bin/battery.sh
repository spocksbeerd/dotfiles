#!/bin/bash

percentage=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

echo "Battery Information"
echo ""
echo "Percentage:" $percentage"%"
echo "Status:" $battery_status
