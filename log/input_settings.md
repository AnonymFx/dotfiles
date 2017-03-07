# Input Settings

## Natural Scrolling
```
/etc/X11/xorg.conf.d/30-libinput.conf
-------------------------------------
Section "InputClass"
    Identifier "Natural Scrolling"
    MatchIsPointer "on"
    Driver "libinput"
    Option "Natural Scrolling" "true"
EndSection
```

## Switch Caps Lock and Escape
Add ```setxkbmap -option "caps:swapescape"``` to start script of WM
