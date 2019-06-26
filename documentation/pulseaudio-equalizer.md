# Setup pulseaudio-equalizer-ladspa
1. Install `pulseaudio-equalizer-ladspa`
2. Enable it with `pulseaudio-euqalizer enable` or via front-end `pulseaudio-equalizer-gtk`
3. Maybe add it to autostart

# Set up pulseaudio equalizer [old way, better way above]

1. Install pulseaudio-equalizer
2. Load required pulseaudio modules
```
pactl load-module module-equalizer-sink
pactl load-module module-dbus-protocol
```
3. Run GUI frontend: `qpaeq`
4. To start the equalizer on startup, add
```
load-module module-equalizer-sink
load-module module-dbus-protocol
```
to `/etc/pulse/default.pa` or `~/.config/pulse/default.pa/`

## Troubleshooting
* Equalizer not working:
    1. Install `pavucontrol` (GUI settings) 
    2. change "ALSA Playback on" to "FFT based equalizer on" for the media player (under playback)
