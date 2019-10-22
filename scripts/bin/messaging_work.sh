#!/usr/bin/env sh
firefox cqse.slack.com https://chat.google.com/u/1 https://web.whatsapp.com/ mail.google.com/mail/u/0 mail.google.com/mail/u/1 &
sleep 1.25
i3-msg 'move window to workspace 10'
