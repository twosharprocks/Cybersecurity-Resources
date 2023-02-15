Windows
=====

[Task Manager Complete Guide](https://www.howtogeek.com/405806/windows-task-manager-the-complete-guide/)

[Commands for Cmd Shell & PowerShell [COMPREHENSIVE]](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/windows-commands)

[Helpful Command Line Commands](https://www.freecodecamp.org/news/command-line-commands-cli-tutorial/)

# **Basics**
----------

`cd` or `chdir` Change directory (Linux = cd)
`dir` List directory contents (Linux = ls)
`md` or `mkdir` Create directory (Linux = mkdir)
`copy` Copy file (Linux = cp)
`move` Move (Cut/Paste) files (Linux = mv)
`clip`  Copies to Clipboard
`del` or `erase` Delete files/directories (Linux = rm or shred)
`rd` or `rmdir` Remove directory if empty (Linux = rm)
`find` Search a file for a specific string (Linux = grep)
`exit` Close CMD (Linux = exit)
`type` Show contents of file (Linux = cat)
`cls` Clear screen
`findstr` Find string
`clip` - Add to clipboard

Environment Variables

* `set` Shows all PC Environment Variables
* `%CD%`	 Current Directory
* `%DATE%` Current Date
* `%OS%` Windows
* `%ProgramFiles%` C:\Program Files
* `%ProgramFiles(x86)%` C:\Program Files (x86)
* `%TIME%` Current Time
* `%USERPROFILE%` C:\Users\{username}
* `%SYSTEMDRIVE%` C:\
* `%SYSTEMROOT%` C:\Windows

Network

* `ipconfig` IP Config (Options: /all /release /renew /displaydns /flushdns)
* `getmac` MAC Info (Options: /v)
* `netsh` 
    * `netsh wlan` show wlanreport
    * `netsh interface` show interface
    * `netsh interface` ip show address
    * `netsh advfirewall` set allprofiles state off Turn off Windows defender
* `ping` ping website.address
    * Options: `-t` (continuous pinging)
* `fping` ping multiple ip addresses at once
    * Options: `-g` (ping all IPs in the following range)
* `tracert` “trace route”
    * Options: `-d` (no domain names)
* `netstat` (Options: -o to list PIDs, -e -t 5 to show sent/recieved stats every 5 seconds)
* `route` print [computer routing table] (add _to add specific route_, delete)
* `netsh wlan show profile wifiname key=clear` Show saved wifi password
* `nslookup` 
    * nslookup `-type=ptr` networkname.com

System Management



* `systeminfo` Provides system information
* `driverquery` List all drivers (even drivers not in device manager)
* `powercfg` (Option <span style="text-decoration:underline;">required</span>: /energy /batteryreport)
* `assoc` File associations
    * _eg. assoc .mp4=vlc (Set .mp4 association to VLC)_
* `chkdsk` Check disk
    * Options /f (error search & fix) /r (check physical sectors)
* `sfc` System file check
    * Options /scannow
* `DISM` Deployment Image Servicing and Management
    * Options: /Online /Cleanup-Image /CheckHealth OR /ScanHealth OR /RestoreHealth
* `cipher` Wipe empty disk space and encrypts files
* `tasklist` List tasks
    * tasklist | findstring script To find “script”
* `taskkill` Kill task
    * taskkill /f /pid## /f to force /pid to identify process by id#
* `shutdown`
    * `shutdown /r /fw /f /t 0` (reboot into BIOS)
* `wmic` Windows Management Instrumentation Command-Line (Process management)
    * [wmic is being replaced with Powershell](https://research.nccgroup.com/2022/03/10/microsoft-announces-the-wmic-command-is-being-retired-long-live-powershell/)
    * wmic Starts interactive mode (shell-like), commas used for multiple properties
    * Input format: wmic [global switches] [alias] [verbs] [properties]
        * eg. _wmic /APPEND:report.txt logicaldisk get caption, filesystem, freespace_
    * `Global Switches`
        * /APPEND
    * `Alias`
        * os, Logicaldisk, 
    * `verbs`
        * get
    * `properties`
        * caption, /value, buildnumber, filesystem, freespace, size, volumeserialnumber
* `net` Manage user accounts, groups, and password policies


### Common PowerShell Commands {#common-powershell-commands}

[Powershell 101 Reference](https://learn.microsoft.com/en-us/powershell/scripting/learn/ps101/00-introduction?view=powershell-7.3)


* `Set-Location` Changes to specified directory (Linux = cd)
* `Get-ChildItem` Return current directory contents (Linux = ls, dir)
* `New-Item` Makes a new file or directory (Linux = touch, mkdir)
* `Remove-Item` Deletes a file or directory (Linux = rm, rmdir)
* `Copy-Item` Copies a file from one given location to another (Linux = cp)
* `Move-Item` Moves a file from one given location to another (Linux = mv) \

* `Get-Location` Retrieves path to current directory (Linux = pwd)
* `Get-Content` Returns file contents (Linux = cat, type)
* `Write-Output` Prints output (Linux = echo)
* `Get-Alias` Shows aliases for the current session (Linux = alias)
* `Get-Help` Retrieves information about PowerShell commands (Linux = man)
* `Get-Process` Gets processes running on local machine (Linux = ps)
* `Stop-Process` Stops one or more defined processes (Linux = kill)
* `Get-Service` Gets a list of services service --status-all


### Useful Cmdlets for Monitoring Suspicious Activity {#useful-cmdlets-for-monitoring-suspicious-activity}



* `Get-WmiObject`
* `Invoke-WmiMethod`
* `Register-WmiEvent`
* `Remove-WmiObject`
* `Set-WmiInstance`


### Cmdlets to monitor as replacements for WMIC {#cmdlets-to-monitor-as-replacements-for-wmic}

* `Export-BinaryMiLog`
* `Get-CimAssociatedInstance`
* `Get-CimClass`
* `Get-CimInstance`
* `Get-CimSession`
* `Import-BinaryMiLog`
* `Invoke-CimMethod`
* `New-CimInstance`
* `New-CimSession`
* `New-CimSessionOption`
* `Register-CimIndicationEvent`
* `Remove-CimInstance`
* `Remove-CimSession`
* `Set-CimInstance`


### Chocolatey {#chocolatey}



* `choco install <package>` to install package
    * `-y` parameter to auto-confirm
* `choco uninstall <package>` to uninstall a package


### Active Directory {#active-directory}

[Understanding Active Directory](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc781408(v=ws.10)) [General Reference]

[Active Directory Best Practices](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc778219(v=ws.10))

[Securing Active Directory](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc728372(v=ws.10))
