# Disable IPv6 on Ubuntu
* Add the following to

```
/etc/sysctl.conf
-----------------------------------
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
```

* Run `# sysctl -p ` to load the configuration
* Run `cat /proc/sys/net/ipv6/conf/all/disable_ipv6` to check. 1 equals disabled, 0 enabled.

[Source](https://support.purevpn.com/how-to-disable-ipv6-linuxubuntu)
