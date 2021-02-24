#!/usr/bin/env sh
case $1 in
	w ) # Work
		spotify &
		sleep 1
		i3-msg "move scratchpad"

		$HOME/bin/messaging_work
		sleep 2
		i3-msg "move workspace 10"

		$HOME/bin/organization_work
		sleep 1
		i3-msg "move workspace 9"

		i3-msg "workspace 1" &&
		keepassxc "$HOME/Drive_work/pettinger@cqse.kdbx" & sleep 1
		terminator -x /usr/bin/zsh -i -c cqse &
		sleep 1

		if [ -e $HOME/.config/i3/custom_autostart.sh ]; then
			$HOME/.config/i3/custom_autostart.sh w
		fi
		;;
	p ) # Private
		spotify &
		sleep 1
		i3-msg "move scratchpad"

		$HOME/bin/messaging_private
		sleep 2
		i3-msg "move workspace 10"

		$HOME/bin/organization
		sleep 1
		i3-msg "move workspace 9"

		if [ -e $HOME/.config/i3/custom_autostart.sh ]; then
			$HOME/.config/i3/custom_autostart.sh p
		fi
		;;
esac

i3-msg "workspace 1" && keepassxc "$HOME/Drive/Documents/passwords.kdbx" &
# Default
if [ -e $HOME/.config/i3/custom_autostart.sh ]; then
	$HOME/.config/i3/custom_autostart.sh d
fi
