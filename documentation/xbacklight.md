# Fixing xbacklight not working (no output with get, no change when calling set or inc/dec)

```
/etc/X11/xorg.conf.d/20-backlight.conf
-------------------------------------
Section "Device"
    Identifier  "Card0"
    Driver      "intel"
    Option      "Backlight"  "intel_backlight"
EndSection
```
