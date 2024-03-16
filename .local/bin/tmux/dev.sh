#!/bin/bash

session="dev"

# set up tmux
tmux start-server

# create a new tmux session, give the default window a name and execute a command
tmux new-session -d -s $session -n vim "lf -command cd ~/projects"

# create a new window 
tmux new-window -t $session:1 -n server "lf -command cd ~/projects"

# return to main vim window
tmux select-window -t $session:0

# attach to the tmux session
tmux attach-session -t $session
