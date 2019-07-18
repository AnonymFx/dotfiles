#!/bin/sh
case $1 in
	w ) # Work
		i3-msg "workspace 1" &&
		keepassxc "$HOME/Drive_work/pettinger@cqse.kdbx" & sleep 1
		terminator -x /usr/bin/zsh -i -c cqse

		i3-msg "exec --no-startup-id spotify & sleep 1.5 && i3-msg move scratchpad"
		sleep 1

		firefox cqse.slack.com "https://mail.google.com/mail/u/1" &
		sleep 2
		i3-msg "move window to workspace 10"

		firefox calendar.google.com/b/0 calendar.google.com/b/1 todoist.com 'https://dev.azure.com/apps-munichre/QualityTools/_sprints'
		sleep 1
		i3-msg "move window to workspace 9"

		if [ -e $HOME/.config/i3/custom_autostart.sh ]; then
			$HOME/.config/i3/custom_autostart.sh w
		fi
		;;
	p ) # Private
		i3-msg "exec --no-startup-id spotify & sleep 1.5 && i3-msg move scratchpad"

		firefox web.whatsapp.com mail.google.com &
		sleep 3
		i3-msg "move window to workspace 10"

		firefox calendar.google.com/b/0 todoist.com &
		sleep 3
		i3-msg "move window to workspace 9"

		if [ -e $HOME/.config/i3/custom_autostart.sh ]; then
			$HOME/.config/i3/custom_autostart.sh p
		fi
		;;
esac

i3-msg "workspace 1" && keepassxc "$HOME/Drive/Documents/References/passwords.kdbx" &
# Default
if [ -e $HOME/.config/i3/custom_autostart.sh ]; then
	$HOME/.config/i3/custom_autostart.sh d
fi
