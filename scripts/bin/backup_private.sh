#!/usr/bin/env sh
if [[ $# != 1 ]]; then
	echo "Usage: backup_private <location_of_borg_archive>"
	exit
fi
borg_archive=$1

echo "Backing up personal Drive folder"
cd $HOME/Drive

export BORG_PASSPHRASE=$(<$HOME/.borg_pw_private)
borg create --stats --progress "$borg_archive"::"$(date +%F)_drive" *
