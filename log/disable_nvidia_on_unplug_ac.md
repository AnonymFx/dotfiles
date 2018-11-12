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

3. For proper detection after hibernate, add another script:

	```
	/usr/bin/nvidia-auto-detect
	---------------------------
	#!/usr/bin/env sh
	AC_ON=$(cat /sys/class/power_supply/AC/online)
	if [[ $AC_ON == 0 ]]; then
		nvidia-unload
		echo unloaded nvidia
	else
		nvidia-load
		echo loaded nvidia
	fi
	```
	
	and create and enable the following service in systemd
	```
	/etc/systemd/system/nvidia-auto-detect.service
	----------------------------------------------
	[Unit]
	Description=Detect AC state to enable or disable Nvidia card after suspension
	After=suspend.target

	[Service]
	User=root
	Type=oneshot
	ExecStart=/usr/bin/nvidia-auto-detect
	TimeoutSec=0
	StandardOutput=syslog

	[Install]
	WantedBy=suspend.target
	```
	
