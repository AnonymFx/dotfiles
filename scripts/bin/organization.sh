#!/usr/bin/env sh
firefox calendar.google.com/b/0 calendar.google.com/b/1 todoist.com &
sleep 2
i3-msg 'move window to workspace 9'
