#!/bin/bash

if pgrep -x "slurp" > /dev/null
then
    exit 0
fi

output=$(slurp -d -w 1 -b "#00000080" -c "#A7C080" -f "width: %w
height: %h")

if [[ ! $? -eq 0 ]]; then
    exit 1
fi

notify-send -e -u low -t 2000 "$output" -h string:x-canonical-private-synchronous:ruler
wl-copy "$output"
