#!/usr/bin/env sh
echo "Setting the keyboard layout to us"
loadkeys us

echo "Checking boot mode"
BOOT_MODE="bios"
if [[ -d "/sys/firmware/efi/efivars" ]]; then
	BOOT_MODE="uefi"
fi
echo "Boot mode is $BOOT_MODE"
# TODO Consequences?

echo "Checking Internet connection"
# TODO Extract function and execute in loop until there is a connection to the Internet
ping -c 1 archlinux.org
PING_EXIT_CODE=$?
if [[ ! $PING_EXIT_CODE -eq 0 ]]; then
	echo "Please connect to the Internet and execute the script again"
	exit 1
fi
echo "Successful"

echo "Updating system clock"
timedatectl set-ntp true

echo "Please enter the partition you want to install Arch onto. Please make sure you have created it before with fdisk or gdisk."
read PARTITION
# TODO extract function and execute in loop until partition is valid
if [[ -z "$PARTITION" ]] || [[ ! -e "$PARTITION" ]]; then
	echo "$PARTITION is not valid, exiting"
	exit
fi

echo "Creating ext4 filesystem on partition $PARTITION"
mkfs.ext4 "$PARTITION"

echo "Mounting new file system"
mount "$PARTITION" /mnt

echo "Pacstrapping base linux and linux-firmware"
pacstrap /mnt base linux linux-firmware vim man-db man-pages

echo "Generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab

echo "Changing root to newly setup arch installation"
arch-chroot /mnt
