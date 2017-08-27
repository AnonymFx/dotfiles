# Bluetooth Audio Installation

## Install packages 
Source: [Bluetooth Headset Arch Wiki](https://wiki.archlinux.org/index.php/Bluetooth_headset) 

1. Install packages: pulseaudio-alsa, pulseaudio-bluetooth, bluez, bluez-libs, bluez-utils, bluez-firmware
2. Pair and connect to speaker/headset via bluetoothctl
3. Set as output (e.g. in gnome settings GUI or via pactl set-default-sink)

## Connect on startup
1. enable switch-on-connect module in pulseaudio:
```
/etc/pulse/default.pa
-------------------------------
# automatically switch to newly-connected devices
load-module module-switch-on-connect
```
2. Trust bluetooth device:
```
bluetoothctl (executable)
-------------------------------
trust MAC_ADDRESS_OF_DEVICE
```
3. Power on bluetooth after boot
```
/etc/bluetooth/main.conf
-------------------------------
[Policy]
AutoEnable=true
```

## Troubleshooting

### No audio playing when using GDM
Source: [Bluetooth Headset Arch Wiki](https://wiki.archlinux.org/index.php/Bluetooth_headset) 

```
mkdir -p ~gdm/.config/systemd/user
ln -s /dev/null ~gdm/.config/systemd/user/pulseaudio.socket
```

### Audio choppy/laggy
Source: [Pulse Audio Troubleshooting Arch Wiki](https://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting)

```
/etc/pulse/daemon.conf
-------------------------
enable-lfe-remixing = yes
```

