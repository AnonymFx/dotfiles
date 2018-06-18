# Input Settings

## Natural Scrolling
```
/etc/X11/xorg.conf.d/30-libinput.conf
-------------------------------------
Section "InputClass"
    Identifier "Natural Scrolling Mouse"
    MatchIsPointer "on"
    Driver "libinput"
    Option "Natural Scrolling" "true"
EndSection
```

```
/etc/X11/xorg.conf.d/30-libinput.conf
-------------------------------------
Section "InputClass"
    Identifier "Natural Scrolling Touchpad"
    MatchIsTouchpad "on"
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
    Driver "libinput"
    MatchIsKeyboard "on"
    Option "XkbLayout" "us"
    Option "XkbVariant" "intl"
    Option "XkbOptions" "caps:swapescape"
EndSection
```
