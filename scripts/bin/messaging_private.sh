#!/usr/bin/env sh
firefox -P default web.whatsapp.com mail.google.com/mail/u/0 &
sleep 2
i3-msg 'move window to workspace 10'
