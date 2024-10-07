---
Date: 2024-10-04
Platform: PG-Practice
Category: Linux
Difficulty: Intermediate
Status: Complete
IP: 192.168.137.231
Writeup: https://medium.com/@raj.patel33605/boolean-offsec-proving-groundswriteup-8f626bbb1b3f
---
# Boolean
This was an absolute slog, and even the walkthroughs didn't help at the end. It was good to identify that BurpSuite would be used early on, but picking up and changing the "confirmed" element was tricky. Having the PHP reverse shell not work was incredibly frustrating too, but it was obvious something else would be needed when GoBuster wasn't showing where the uploaded files were being stored (obviously download only and not directly web accessible).

The real challenge here was figuring out the SSH keys. It's not something I've done a lot with so far, so figuring out how to generate them, renaming them `authorized_keys`, and uploading the correct one (public not private) was a challenge in itself. The truly frustrating part came from trying to switch to `root@127.0.0.1` and being told there'd been too many authentication failures. A little more research showed that it could be bypassed with the `-o IdentitesOnly=yes` option, but after so much frustration trying to sort the keys in the first place, I probably should have just walked away for awhile and come back to find answers instead of getting more frustrated.

On the plus side though, this box helped me sort out a lot of my internal notes so that they would be better used as cheat sheets in the future. Going through these boxes is certainly helping imbed the lessons I learned from the modules, so keep doing the boxes, keep taking notes, and keep refining your processes. 
# Resolution summary
- Nmap to find port 22, 80 & 3000
- Navigated to HTML site, registered user, used BurpSuite Repeater to bypass email authentication
- Uploaded PHP to attempt reverse shell but no success
- Used directory traversal to view `/etc/passwd` & identify user `remi`
- Used directory traversal to access `/home/remi/.ssh` and upload SSH key
- Used SSH to login as `remi` and print `local.txt`
- Navigated to `/home/remi/.ssh/keys` to find `root` SSH key
- Used `root` SSH key to switch to `root` user and print `proof.txt`
## Improved skills
- Generating and handling SSH keys, especially adding `-o IdentitesOnly=yes` and switching internally with `127.0.0.1`
- Identifying vulnerabilities with BurpSuite
## Used tools
- nmap
- BurpSuite Repeater
- MSFVenom
- SSH

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN boolean.nmap 192.168.137.231 -v
```

Enumerated open TCP ports:
```bash
PORT     STATE  SERVICE VERSION
22/tcp   open   ssh     OpenSSH 7.9p1 Debian 10+deb10u2 (protocol 2.0)
| ssh-hostkey: 
|   2048 37:80:01:4a:43:86:30:c9:79:e7:fb:7f:3b:a4:1e:dd (RSA)
|   256 b6:18:a1:e1:98:fb:6c:c6:87:55:45:10:c6:d4:45:b9 (ECDSA)
|_  256 ab:8f:2d:e8:a2:04:e7:b7:65:d3:fe:5e:93:1e:03:67 (ED25519)
80/tcp   open   http
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-favicon: Unknown favicon MD5: D41D8CD98F00B204E9800998ECF8427E
| http-title: Boolean
|_Requested resource was http://192.168.137.231/login
| fingerprint-strings: 
|   DNSStatusRequestTCP, DNSVersionBindReqTCP, GenericLines, Help, JavaRMI, Kerberos, LANDesk-RC, LDAPBindReq, LDAPSearchReq, LPDString, NCP, NotesRPC, RPCCheck, RTSPRequest, SIPOptions, SMBProgNeg, SSLSessionReq, TLSSessionReq, TerminalServer, TerminalServerCookie, WMSRequest, X11Probe, afp, giop, ms-sql-s, oracle-tns: 
|     HTTP/1.1 400 Bad Request
|   FourOhFourRequest, GetRequest, HTTPOptions: 
|     HTTP/1.0 403 Forbidden
|     Content-Type: text/html; charset=UTF-8
|_    Content-Length: 0
3000/tcp closed ppp
1 service unrecognized despite returning data.
```

---
# Enumeration

## Port 22 - SSH (OpenSSH 7.9p1)
No enumeration conducted
## Port 80 - HTTP
- Navigated to `http://192.168.137.231`, redirected to `http://192.168.137.231/login`
![[Pasted image 20241007115750.png]]
- Ran `gobuster` to enumerate directories: `gobuster dir -u  http://192.168.137.231 -w //usr/share/dirb/wordlists/big.txt`
![[Pasted image 20241007122544.png]]
- Used `gobuster` to further enumerate `filemaneger` directory with no results
![[Pasted image 20241007122952.png]]

---
# Exploitation
- Created user with credentials `offsec:password` & email `offsec@offsec.com`
![[Pasted image 20241007120904.png]]
- Presented with email confirmation page, so tried changing email to `kali@offsec.com` & inspected request in Burpsuite, identifying `"confirmed":false,` in response
![[Pasted image 20241007121135.png]]
- Modified request to include `&user%5Bconfirmed=True` and bypassed email confirmation
Request (Burpsuite)
![[Pasted image 20241007121404.png]]
Response (Browser)
![[Pasted image 20241007121501.png]]
- Identified upload facility, so created reverse shell with MSFVenom
![[Pasted image 20241007122001.png]]
- Successfully uploaded shell.php to target
![[Pasted image 20241007122029.png]]
- File path: `http://192.168.137.231/?cwd=&file=shell.php&download=true`
- Modified file path to `http://192.168.137.231/?cwd=&file=shell.php` - No change or shell established
- Attempted directory traversal to `/etc/passwd` file: `http://192.168.137.231/?cwd=../../../../../../../../../etc/&file=passwd&download=true`
![[Pasted image 20241007123838.png]]
- Identified user `remi`, and attempted to access user's `.ssh` directory: `http://192.168.137.231/?cwd=../../../../../../../home/remi&file=.ssh&download=true`
![[Pasted image 20241007124641.png]]
- Identified `local.txt` and accessed `.ssh/keys`
![[Pasted image 20241007124722.png]]
- Downloaded `root`, `id_rsa`, `id_rsa.1`, `id_rsa.2` SSH keys & attempted to crack password
![[Pasted image 20241007125655.png]]![[Pasted image 20241007130100.png]]
- Used `ssh-keygen` to generate an authorized key
![[Pasted image 20241007134705.png]]
- Uploaded newly generated key `authorized_keys` to target
![[Pasted image 20241007134727.png]]
- Used newly generated SSH key to login as `remi` user
![[Pasted image 20241007134925.png]]
---
# Lateral Movement to user
## Local Enumeration
- Found and printed `local.txt` = `c31ba66829a7cf0167219e30ea8d0f4f`
---
# Privilege Escalation
## Privilege Escalation vector
- Navigated to previously identified `/.ssh/keys` to find `root` SSH key
![[Pasted image 20241007141337.png]]
- Used SSH to switch to `root`: `ssh -i root root@127.0.0.1 -o IdentitiesOnly=yes`
![[Pasted image 20241007141449.png]]
- Navigated to `/root` to find `proof.txt`
![[Pasted image 20241007141603.png]]
---
# Trophy & Loot
`local.txt` = `c31ba66829a7cf0167219e30ea8d0f4f`
`root.txt` = `bc3be029a2e748ca228d49e7270d7a78`