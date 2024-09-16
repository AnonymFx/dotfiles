#!/usr/bin/env zsh

zmodload zsh/datetime
lock_folder="/tmp/system-update.lock"

function _current_epoch() {
	echo $(( $EPOCHSECONDS / 60 / 60 / 24 ))
}

function _update_system_update() {
	echo "LAST_EPOCH=$(_current_epoch)" >! $HOME/.system-update
}

function _upgrade_system() {
	# If linux needs an update we need to ask if user wants to restart later
	linuxNeedsUpdate=""
	if pacman_location="$(type -p pacman)" && [ -n "$pacman_location" ]; then
		sudo pacman -Sy
		linuxNeedsUpdate="$(pacman -Qu | grep 'linux ')"
	fi

	# Do system update, try AUR helpers first, fallback is pacman
	if brew_location="$(type -p brew)" && [ -n "$brew_location" ]; then
		if brew update && brew upgrade && brew autoremove; then
			# update the system update file
			_update_system_update
		fi
	elif yay_location="$(type -p yay)" && [ -n "$yay_location" ]; then
		if yay --combinedupgrade -Syu; then
			# update the system update file
			_update_system_update
		fi
	elif trizen_location="$(type -p trizen)" && [ -n "$trizen_location" ]; then
		if trizen -Syu --noedit; then
			# update the system update file
			_update_system_update
		fi
	elif yaourt_location="$(type -p yaourt)" && [ -n "$yaourt_location" ]; then
		if yaourt -Syua; then
			# update the system update file
			_update_system_update
		fi
		# otherwise use pacman
	elif pacman_location="$(type -p pacman)" && [ -n "$pacman_location" ]; then
		if sudo pacman -Syu; then
			# update the system update file
			_update_system_update
		fi
	fi

	# Check if Linux was actually updated
	linuxStillNeedsUpdate=""
	if pacman_location="$(type -p pacman)" && [ -n "$pacman_location" ]; then
		linuxStillNeedsUpdate="$(pacman -Qu | grep 'linux ')"
	fi
	
	if [[ ! -z "$linuxNeedsUpdate" ]] && [[ -z "$linuxStillNeedsUpdate" ]]; then
		echo "Linux was updated, would you like to restart now? [(y)es/(N)o]: \c"
		read line
		if [[ "$line" == Y* ]] || [[ "$line" == y* ]]; then
			reboot
		fi

	fi
}

epoch_target=$UPDATE_SYSTEM_DAYS
if [[ -z "$epoch_target" ]]; then
	# Default: one week
	epoch_target=7
fi

if mkdir "$lock_folder" 2>/dev/null; then
	# Remove lock file on interrupt
	trap 'rmdir "$lock_folder" 2>/dev/null; exit' INT
	if [ "$1" = "-f" ]; then
	 	_upgrade_system
	elif [ -f ~/.system-update ]; then
		# Source the file with the LAST_EPOCH variable
		. ~/.system-update

		if [[ -z "$LAST_EPOCH" ]]; then
			# if variable does not exist in the file, override it and exit
			_update_system_update && return 0;
		fi

		# Check if last update was longer than epoch_target days ago and do update if necessary
		epoch_diff=$(($(_current_epoch) - $LAST_EPOCH))
		if [ $epoch_diff -ge $epoch_target ]; then
			if [ "$DISABLE_UPDATE_PROMPT" = "true" ]; then
				_upgrade_system
			else
				echo "[System Update] Would you like to check for updates? [(Y)es/(n)o/(p)ostpone]: \c"
				read line
				if [[ "$line" == Y* ]] || [[ "$line" == y* ]] || [ -z "$line" ]; then
					_upgrade_system
				elif [[ "$line" == P* ]] || [[ "$line" == p* ]]; then
					_update_system_update
				fi
			fi
		fi
	else
		# create the system update file
		_update_system_update
	fi

	rmdir "$lock_folder"
	# Restore default interrupt
	trap - INT
fi
