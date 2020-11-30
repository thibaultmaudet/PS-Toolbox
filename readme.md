# PS-Toolbox

This module contains a collection of functions than you can use to enhance your powershell utilisation. Most of commands availables are cross-plateform and usable in the Core and Desktop version of Powershell.

## System Tools
### Get-OsVersion
The `Get-OsVersion` function is an equivalent to `winver.exe` to display the OS version informations.

```powershell
Get-OsVersion


ProductName            : Windows 10 Pro
EditionId              : Professional
ReleaseId              : 2004
Build                  : 19041
InstallDate            : 03/09/2020 10:16:00
RegisteredOrganization : 
RegisteredOwner        : 
```

### Get-WifiProfiles

This command list all Wi-Fi profiles saved in your computer.

```powershell
Get-WifiProfiles


SSID
----
Network1
Network2
Network3
```

### Get-WifiPassword

Display all Wi-Fi profile passwords saved in your computer.

```powershell
Get-WifiPassword


SSID     Pasword
----     -------
Network1 Password1
Network2 Password2
Network3 Password3
```

You can also display only some of the saved networks.

```powershell
Get-WifiPassword -ListAvailable Network1, Network3


SSID     Pasword
----     -------
Network1 Password1
Network3 Password3
```

## Other tools
### Convert-DataBytes

Use this function to convert a stockage unit to an another.

```powershell
Convert-DataBytes -Value 1 -From KB -To Bytes


1024
```

You can also pass the value by a pipeline.

```powershell
1 | Convert-DataBytes -From KB -To Bytes


1024
```