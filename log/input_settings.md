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
```
/etc/X11/xorg.conf.d/30-libinput.conf
-------------------------------------
Section "InputClass"
    Identifier "Keyboard"
    Driver "kbd"
    MatchIsKeyboard "on"
    Option "XkbLayout" "us"
    Option "XkbVariant" "intl"
    Option "XkbOptions" "caps:swapescape"
EndSection
```
