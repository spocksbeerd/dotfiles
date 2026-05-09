#!/bin/bash

file=~/.cache/counter

usage() {
    echo "Usage: counter [option]"
    echo "Options:"
    echo "  start     Start the counter"
    echo "  show      Show the counter"
    echo "  clear     Clear the counter"
    echo "  help      Show this menu"
}

start() {
    local count
    if [ -e "$file" ];
    then
        count=$(head -1 "$file")
        count=$(( count +1 ))
    else
        count=1
    fi

    echo "$count" > "$file"
    echo $(date +"%B %d, %H:%M") >> "$file"
}

show() {
    if [ ! -e "$file" ];
    then
        echo "There is no counter set yet."
        exit 1
    fi

    count=$(sed -n '1p' "$file")
    date=$(sed -n '2p' "$file")
    echo
    echo "Count: $count"
    echo "$date"
    echo
    cal -3
}

case "$1" in
    start)
        start
        show
        ;;
    show)
        show
        ;;
    clear)
        rm "$file"
        echo "Counter cleared."
        ;;
    help)
        usage
        ;;
    *)
        echo "Invalid option: \"$1\"" >&2
        echo
        usage
        exit 1
        ;;
esac
