#!/bin/sh
case $1 in
	w ) # Work
		i3-msg "workspace 10; exec gpmdp"
		sleep 3
		i3-msg "workspace 9"
		sleep 0.1
		google-chrome-beta --new-window messenger.com web.whatsapp.com cqse.slack.com "https://inbox.google.com/u/0/?pli=1" "https://inbox.google.com/u/1/?pli=1" &
		sleep 8
		i3-msg "workspace 8"
		sleep 0.1
		google-chrome-beta --new-window calendar.google.com todoist.com &
		sleep 6
		i3-msg "workspace 7"
		google-chrome-beta --new-window &
		sleep 6
		i3-msg "workspace 1; exec terminator"
		sleep 1
		if [ -e $HOME/.config/i3/custom_autostart.sh ]; then
			$HOME/.config/i3/custom_autostart.sh w
		fi
		;;
	p ) # Private
		i3-msg "workspace 10; exec gpmdp"
		sleep 3
		i3-msg "workspace 9"
		sleep 0.1
		google-chrome-beta --new-window messenger.com web.whatsapp.com &
		sleep 6
		i3-msg "workspace 8"
		sleep 0.1
		google-chrome-beta --new-window calendar.google.com todoist.com &
		sleep 6
		i3-msg "workspace 7"
		google-chrome-beta --new-window &
		sleep 6
		i3-msg "workspace 1; exec terminator"
		sleep 1
		if [ -e $HOME/.config/i3/custom_autostart.sh ]; then
			$HOME/.config/i3/custom_autostart.sh p
		fi
		;;
esac

# Default
if [ -e $HOME/.config/i3/custom_autostart.sh ]; then
	$HOME/.config/i3/custom_autostart.sh d
fi
