#!/bin/bash

if [ -d "$HOME/.local/share/nvm/versions" ]; then
    dir=$HOME/.local/share/nvm/versions/node
    latest_version=$(ls "$dir" | tail -n 1)
    PATH="$PATH:$dir/$latest_version/bin/"
else
    echo "Node is not installed."
    echo "You have to uncomment nvm in .zshrc to install it."
fi
