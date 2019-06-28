# Set screen timeout for X server
```
/etc/X11/xorg.conf.d/00-server-flags.conf
----------------------------------------
Section "Server Flags"
	Option "blank time" "10"
EndSection
```

This sets the screen timeout to 10 minutes
