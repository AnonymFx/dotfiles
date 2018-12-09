#!/bin/sh
new_session_name=''
new_session_number=0
base_session_name='default-'
checking_session_name="$base_session_name$new_session_number"

function list_unattached_sessions() {
	tmux list-sessions | grep --perl-regexp "$base_session_name\d+" | grep --perl-regexp --invert-match "attached" | sed -e 's/:.*$//'
}

function session_exists_and_client_connected() {
	for session in $(tmux list-sessions -F '#S'); do
		if [[ "$session" == "$1" ]] && [[ $(tmux list-clients -t "$1") ]]; then
			return 0
		fi
	done

	return 1
}

# Attach to an active default session (that is no necessarily the one with the lowest index)
active_unattached_sessions=( $(list_unattached_sessions) )
if [[ ! -z "$active_unattached_sessions" ]]; then
	tmux attach-session -t "${active_unattached_sessions[0]}"
	exit
fi


while [[ ! "$new_session_name" ]]; do
	if  session_exists_and_client_connected "$checking_session_name"; then
		new_session_number=$((new_session_number+1))
		checking_session_name="$base_session_name$new_session_number"
		continue
	fi
	new_session_name="$checking_session_name"
done
tmux new-session -A -s "$new_session_name"

