#!/bin/sh
new_session_name=''
new_session_number=0
base_session_name='default-'
checking_session_name="$base_session_name$new_session_number"

function session_exists_and_client_connected() {
	for session in $(tmux list-sessions -F '#S'); do
		if [[ "$session" == "$1" ]] && [[ $(tmux list-clients -t "$1") ]]; then
			return 0
		fi
	done

	return 1
}

while [[ ! "$new_session_name" ]]; do
	if  session_exists_and_client_connected "$checking_session_name"; then
		new_session_number=$((new_session_number+1))
		checking_session_name="$base_session_name$new_session_number"
		continue
	fi
	new_session_name="$checking_session_name"
done
tmux new-session -A -s "$new_session_name"

