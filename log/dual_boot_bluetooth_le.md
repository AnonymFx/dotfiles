# Configuring a BLE device to be used on Linux and Windows (dual boot) with the same keys
Kudos to [MisterTea](https://bbs.archlinux.org/viewtopic.php?pid=1678405#p1678405)

## Initial setup
Pair the device once with Linux and Windows (this order!)

## Windows :
1. Download [PSExec](https://docs.microsoft.com/en-us/sysinternals/downloads/psexec)
2. CMD/Powershell as Admin: `PSExec.exe -s -i regedit`
3. Go to HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BTHPORT\Parameters\Keys\Your Bluetooth Controller' s MAC\Your Device' s MAC
Don't export the registry key, it will be misguiding because of reverse values)
4. Note down your device's  MAC
5. Note down the values for CSRK, LTK without commas and in upper case
6. Note down the values for EDIV and ERand as decimal value (open key and select decimal)


## Linux :

1. `sudo -i`
2. `cd /var/lib/bluetooth/Your Bluetooth controller's MAC/`
3. If the Windows device's MAC is different:  
	`mv /var/lib/bluetooth/Your Bluetooth controller' s MAC/ Old device's MAC /var/lib/bluetooth/Your Bluetooth controller' s MAC/New device's MAC`
4. `vim /var/lib/bluetooth/Your Bluetooth controller's MAC' s/New device' s MAC/info`
5. Changes to be made :
	- LocalSignatureKey Key = Windows CSRK
	- LongTermKey EDIV = Windows EDIV
	- LongTermKey Rand = Windows Rand
	- LongTermKey Key = Windows LTK
4. Save file
5. `systemctl restart bluetooth.service`

