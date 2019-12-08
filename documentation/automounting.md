# Automount USB devices
* Install `usisks2` and `udevil`
* Add file
```
/etc/udev/rules.d/99-udisks2.rules
----------------------------------
echo 'ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1'
```
* Enable devmon for user `sudo systemctl enable --now devmon@thomas`
