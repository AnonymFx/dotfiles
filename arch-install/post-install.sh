#!/usr/bin/env sh
echo "installing zsh"
pacman -S zsh

echo "Please enter a username:"
read USERNAME

echo "Creating user $USERNAME and setting login shell to zsh"
useradd --create-home -aG wheel --shell /usr/bin/zsh $USERNAME

echo "Setting password for user $USERNAME"
passwd $USERNAME

echo "Installing sudo"
pacman -S sudo

echo "Configuring sudo. C.f. https://wiki.archlinux.org/index.php/Sudo#Configuration"
read
sed --in-place --expression="s/# %wheel	ALL=(ALL) ALL/%wheel	ALL=(ALL) ALL/" /etc/sudoers

echo "Installing makepgk dependencies"
pacman -S fakeroot base-devel

echo "Installing git"
pacman -S git

echo "Installing yay"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

echo "Installing udevil and udisks2"
pacman -S udevil udisks2

echo "Creating udisks2 config (mounting to /media)"
echo 'ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1' >> /etc/udev/rules.d/99-udisks2.rules

echo "Enabling automounting for user $USERNAME"
systemctl enable devmon@$USERNAME
