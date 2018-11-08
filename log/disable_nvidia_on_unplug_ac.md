# Automatically enable/disable Nvidia card when plugging/unplugging AC

1. Create scripts for loading/unloading:

	```
	/usr/bin/nvidia-load
	--------------------
	#!/bin/sh
	systemctl stop tlp
	echo 1 > /sys/bus/pci/rescan
	systemctl start tlp
	```

	```
	/usr/bin/nvidia-unload
	----------------------
	#!/bin/sh
	echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
	```
	Make sure they can be executed (`chmod +x $file`)

2. Create udev rules to trigger them

	```
	/etc/udev/rules.d/80-nvidia_power.rules
	---------------------------------------
	SUBSYSTEM=="power_supply", KERNEL=="AC", ATTR{online}=="1" RUN+="/usr/bin/nvidia-load"

	SUBSYSTEM=="power_supply", KERNEL=="AC", ATTR{online}=="0" RUN+="/usr/bin/nvidia-unload"

	```
	Make sure, to add the newlines after the rules and to adapt the name of the power supply (search under `/sys/class/power_supply`).
