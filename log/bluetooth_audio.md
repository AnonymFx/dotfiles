# Bluetooth Audio Installation

## Install packages 
Source: [Bluetooth Headset Arch Wiki](https://wiki.archlinux.org/index.php/Bluetooth_headset) 

1. Install packages: pulseaudio-alsa, pulseaudio-bluetooth, bluez, bluez-libs, bluez-utils, bluez-firmware
2. Pair and connect to speaker/headset via bluetoothctl
3. Set as output (e.g. in gnome settings GUI)

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

