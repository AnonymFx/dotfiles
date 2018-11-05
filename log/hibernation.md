# Hibernation
[Source](https://wiki.archlinux.org/index.php/Power_management/Suspend_and_hibernate#Hibernation)
1. Add a swap partition/file
2. Add the `resume=<swap>` boot parameter (when using swap file, the partition the swap file is located)  
	`<swap>` can be 'UUID=...' or '/dev/sd...'
3. If using a swap file, also add the `resume_offset=<offset>` parameter  
	The <offset> can be determinded by running `filefrag -v <swapfile>` and using the first physical_offset value (row 0)
4. Add `resume` to HOOKS in `/etc/mkinitcpio.conf`
5. Rebuild the initramfs using `mkinitcpio`

## Adding boot parameters to grub
[Source](https://wiki.archlinux.org/index.php/Kernel_parameters#GRUB)
1. Edit `/etc/default/grub` and add parameters to `GRUB_CMDLINE_LINUX_DEFAULT`
2. Regenerate grub.cfg by running `grub-mkconfig -o /boot/grub/grub.cfg`

## Screen lock before hibernate
- Create a systemd service file `/etc/systemd/system/suspend@.service` with the following contents 

```
[Unit]
Description=User suspend actions
Before=sleep.target

[Service]
User=%I
Type=simple
Environment=DISPLAY=:0
# Required for playerctl or light-lock for example, might be necessary to adapt
Environment=DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus 
ExecStart=/home/thomas/.config/i3/lock.sh
ExecStartPost=/usr/bin/sleep 1

[Install]
WantedBy=sleep.target
```

- Enable with `systemctl enable suspend@<user>.service`
