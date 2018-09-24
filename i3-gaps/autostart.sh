#!/bin/sh
case $1 in
	w ) # Work
		i3-msg "workspace 10; exec spotify"
		sleep 3
		i3-msg "workspace 9"
		sleep 0.1
		google-chrome-beta --new-window messenger.com web.whatsapp.com cqse.slack.com "https://mail.google.com/mail/u/0" "https://mail.google.com/mail/u/1" cqse.highrisehq.com &
		sleep 8
		i3-msg "workspace 8"
		sleep 0.1
		google-chrome-beta --new-window calendar.google.com/b/0 calendar.google.com/b/1 todoist.com trello.com 'https://intra.cqse.eu/pdash2/#/' & 
		sleep 5
		if [ -e $HOME/.config/i3/custom_autostart.sh ]; then
			$HOME/.config/i3/custom_autostart.sh w
		fi
		;;
	p ) # Private
		i3-msg "workspace 10; exec spotify"
		sleep 3
		i3-msg "workspace 9"
		sleep 0.1
		google-chrome-beta --new-window messenger.com web.whatsapp.com &
		sleep 5
		i3-msg "workspace 8"
		sleep 0.1
		google-chrome-beta --new-window calendar.google.com/b/0 todoist.com &
		sleep 5
		if [ -e $HOME/.config/i3/custom_autostart.sh ]; then
			$HOME/.config/i3/custom_autostart.sh p
		fi
		;;
esac

# Default
if [ -e $HOME/.config/i3/custom_autostart.sh ]; then
	$HOME/.config/i3/custom_autostart.sh d
fi
