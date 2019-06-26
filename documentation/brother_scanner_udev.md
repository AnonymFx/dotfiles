# Fix IO error for Brother scanners
Add the following at the bottom of the file and reboot:
```
/usr/lib/udev/rules.d/49-sane.rules
------------------------------------
# Brother scanners
ATTRS{idVendor}=="04f9", ENV{libsane_matched}="yes"
```
