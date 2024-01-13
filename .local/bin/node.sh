#!/bin/bash

if [ -d "$HOME/.local/share/nvm/versions" ]; then
    cd $HOME/.local/share/nvm/versions/node
    latest_version=$(ls -d -- */ | tail -n 1)
    cd
    PATH="$PATH:$HOME/.local/share/nvm/versions/node/$latest_version/bin/"
else
    echo "Node is not installed."
    echo "You have to uncomment nvm in .zshrc to install it."
fi
