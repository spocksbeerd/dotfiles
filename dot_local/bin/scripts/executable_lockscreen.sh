#!/bin/bash

lockscreen=hyprlock

if ! pgrep -x "$lockscreen" > /dev/null
then
    "$lockscreen"
fi
