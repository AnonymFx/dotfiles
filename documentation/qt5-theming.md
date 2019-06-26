# Qt5 Theming
1. Install qt5-styleplugins and qt5ct
2. Set environment variable in /etc/environment and add the following line:
`QT_QPA_PLATFORMTHEME=qt5ct`
3. Restart the system
4. Start qt5ct from terminal and select gtk2
5. Start one more time qt5ct from terminal with sudo rights (for qt apps which required sudo rights like manjaro-settings-manager) and select gtk2
