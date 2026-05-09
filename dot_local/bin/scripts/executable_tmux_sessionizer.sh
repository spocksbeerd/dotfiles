#!/bin/bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/Projects ~/.config ~/.local ~/Documents/notebooks -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z "$selected" ]]; then
    exit 0
fi

session_name=$(basename "$selected" | tr . _)
exec tmux new-session -s "$session_name" -c "$selected"
