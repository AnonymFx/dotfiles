#!/usr/bin/env zsh
# Enable TouchID for sudo by editing /etc/pam.d/sudo_local. Unlike
# /etc/pam.d/sudo, sudo_local is preserved across macOS updates.
# Apple ships /etc/pam.d/sudo_local.template as the starting point.

set -euo pipefail

template="/etc/pam.d/sudo_local.template"
target="/etc/pam.d/sudo_local"

if [[ ! -f "$template" ]]; then
	echo "Template $template does not exist. Is this macOS 14+?"
	exit 1
fi

if [[ -f "$target" ]] && grep -qE '^\s*auth\s+sufficient\s+pam_tid\.so' "$target"; then
	echo "TouchID for sudo already enabled in $target."
	exit 0
fi

if [[ ! -f "$target" ]]; then
	echo "Creating $target from $template"
	sudo cp "$template" "$target"
fi

# Uncomment the pam_tid.so line (matches '#auth       sufficient     pam_tid.so')
sudo sed -i '' -E 's|^[[:space:]]*#[[:space:]]*(auth[[:space:]]+sufficient[[:space:]]+pam_tid\.so)|\1|' "$target"

echo "New content of $target:"
cat "$target"
