#!/bin/bash

qdbus-qt5 org.kde.kglobalaccel /component/kwin invokeShortcut "Walk Through Windows"
sh -c 'sleep 0.2; xdotool type "$(xclip -o -selection clipboard)"'

echo '' | xclip -selection clipboard -in
