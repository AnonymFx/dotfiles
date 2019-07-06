# Faster mouse
```
/etc/X11/x.org.conf.d/30-libinput.conf
--------------------------------------
Section "InputClass"
	Identifier		"Speed up MX Master 2S"
	MatchDriver		"libinput"
	MatchProduct		"MX Master 2S"
	Option 			"TransformationMatrix" "3 0 0 0 3 0 0 0 1"
EndSection
```
Adapt the 3's in the matrix for faster/slower mouse speed
