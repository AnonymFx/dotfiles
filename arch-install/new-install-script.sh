#!/usr/bin/env sh
echo "Setting timezone to Europe/Berlin"
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

echo "Setting hardware clock to UTC"
hwclock --systohc

echo "Generating locale for en_US.UTF-8 UTF-8"
sed --in-place --expression="s/#en_US.UTF-8 UTF=8/en_US.UTF-8 UTF-8/" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "Please enter the hostname for the machine:"
read HOSTNAME
echo "Saving hostname $HOSTNAME"
echo "$HOSTNAME" > /etc/hostname

echo "Writing host entries"
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1	localhost" >> /etc/hosts
echo "127.0.0.1	$HOSTNAME.localdomain	$HOSTNAME" >> /etc/hosts

echo "Installing networkmanager and iputils"
pacman -S networkmanager iputils

echo "Re-run initramfs"
mkinitcpio -P

echo "Changing the root password"
passwd

echo "Installing grub"
pacman -S grub efibootmgr os-prober
# TODO Handle better. User cannot do that during execution of the script
echo "Please specify the EFI partition. Create one if it doesn't exist yet"
read UEFI_PARTITION

echo "Mounting EFI partition $UEFI_PARTITION to /mnt"
mount $UEFI_PARTITION /mnt

echo "Installing grub"
grub-install --target=x86_64-efi --efi-directory=/mnt --bootloader-id=GRUB

echo "Generating config"
grub-mkconfig -o /boot/grub/grub.cfg

#TODO enable microcode updates
