# Grub Filesystem Error Fix

Assuming that we are in grub rescue mode here:

```
ls (results in list of partitions)
ls (partition_1_name)/ (don't forget slash here)
ls (partition_2_name)/
... (do until discovering linux partition)
set root=(linux_partition_name)
set prefix=(linux_partition_name)/boot/grub
insmod normal
normal
```

Linux is then booted here, as soon as started start terminal and type the following:
```
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo grub-install /dev/sda (make sure sda is correct, usually is but might be different)
```
