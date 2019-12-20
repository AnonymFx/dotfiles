#!/usr/bin/env sh
case $1 in
	w ) # Work
		i3-msg "workspace 1" &&
		keepassxc "$HOME/Drive_work/pettinger@cqse.kdbx" & sleep 1
		terminator -x /usr/bin/zsh -i -c cqse

		spotify &
		sleep 1
		i3-msg "move scratchpad"

		$HOME/bin/messaging_work

		$HOME/bin/organization

		if [ -e $HOME/.config/i3/custom_autostart.sh ]; then
			$HOME/.config/i3/custom_autostart.sh w
		fi
		;;
	p ) # Private
		spotify &
		sleep 1
		i3-msg "move scratchpad"

		$HOME/bin/messaging_private

		$HOME/bin/organization

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
