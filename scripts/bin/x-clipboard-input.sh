#!/bin/bash

sh -c 'sleep 0.2; xdotool type "$(xclip -o -selection clipboard)"'

echo '' | xclip -selection clipboard -in
