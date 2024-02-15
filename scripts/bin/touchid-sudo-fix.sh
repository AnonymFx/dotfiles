#!/usr/bin/env zsh
# Add required string after the first line of the sudo file
sudo_file="/etc/pam.d/sudo"
backup_location="/Users/pete/Downloads"
if [[ ! -f "$sudo_file" ]]; then
	echo "sudo file $sudo_file does not exist. Aborting."
fi

if [[ ! -d "$backup_location" ]]; then
	echo Backup location "$backup_location does not exist or is not a folder. Aborting."
fi

echo "Backing up $sudo_file to $backup_location"
sudo cp "$sudo_file" "$backup_location"

touchid_sudo_text="auth sufficient pam_tid.so"
second_line=`cat $sudo_file | head -2 | tail -1`
if [[ ! $second_line == $touchid_sudo_text ]]; then
	# Add line after first line (so 2nd line)
	sudo sed -i "1a\\auth sufficient pam_tid.so" "$sudo_file"
else
	echo "Sudo with TouchID is already set up."
fi

echo "New content of the sudo file at $sudo_file"
cat "$sudo_file"
