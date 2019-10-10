#!/usr/bin/env sh
firefox calendar.google.com/b/0 calendar.google.com/b/1 todoist.com 'https://dev.azure.com/apps-munichre/QualityTools/_sprints' &
sleep 3
i3-msg 'move window to workspace 9'
