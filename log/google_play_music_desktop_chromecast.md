# Chromecast support for Google Play Music

- Install `avahi` and `nss-mdns`
- Enable `avahi-daemon.service` and `avahi-daemon.socket` with systemd:
```
sudo systemctl enable --now avahi-daemon.service avahi-daemon.socket
```
- If it still does not work, change the following line in nsswitch configuration
```
/etc/nsswitch.conf
~~~~~~~~~~~~~~~~~~~
...
hosts: files mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] dns myhostname
...
```
Note the `mdns_minimal [NOTFOUND=return]` part
