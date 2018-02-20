# Intel Video Tearing

```
/etc/X11/xorg.conf.d/10-intel.conf
-----------------------------------
Section "Device"
	Identifier "Intel Graphics"
	Driver "intel"
	Option "TearFree" "true"
EndSection
```
