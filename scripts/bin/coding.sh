#!/bin/bash

# Set session name
if [[ -z "$1" ]]; then
    # Default session name if no argument is specified
    SESSIONNAME="coding"
else
    # From argument otherwise
    SESSIONNAME="$1"
fi

# Currently not that important
MAINWINDOW="main"

# Check if session already exists
tmux has-session -t "$SESSIONNAME" &>/dev/null
if [[ $? -eq 1 ]]; then
    # If yes, create a new session
    tmux new-session -s $SESSIONNAME -n $MAINWINDOW -d

    # Load layout
    tmux send-keys -t "$SESSIONNAME" 'tmux source-file $HOME/.tmux.layouts/coding.conf' 'C-m'
fi

# Switch to coding session
tmux switch-client -t $SESSIONNAME
