#!/usr/bin/env sh
firefox -P Work calendar.google.com/b/0 todoist.com &
sleep 2
i3-msg 'move window to workspace 9'
