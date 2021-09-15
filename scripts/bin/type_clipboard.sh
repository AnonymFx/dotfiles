#!/usr/bin/env sh

INPUT=$(xclip -sel clip -o)

sleep 0.2 
xdotool type "$INPUT"
xdotool key Return
