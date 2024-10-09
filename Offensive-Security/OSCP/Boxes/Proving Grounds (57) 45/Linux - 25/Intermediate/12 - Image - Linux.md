---
Date: 2024-10-09
Platform: PG-Practice
Category: Linux
Difficulty: Intermediate
Status: Complete
IP: 192.168.201.178
Writeup: https://medium.com/@vineeth.dj/proving-grounds-image-walkthrough-cf7e0b09ba93
---
# Image
This box was objectively quite easy, however the issues I had *around* it made things far more complicated/frustrating than they needed to be. 

Prior to starting this box I'd tried to setup a shared folder on the VM that would also upload to Google drive (with the intent being I could pull the box folder to any desktop/laptop I was working from). However when I started running the exploit to try to create the `.png` with the reverse shell in the name, I started getting an error message saying the file didn't exist. 

Trying to rename an existing file threw the same error, and it took me way too long to realise the issue was with the shared folder's Google Drive sync - the moment I tried to rename the file outside of that shared folder it worked perfectly.

The next issue came from Firefox itself - for some reason it decided that it would try to send me everytime to the non-existent https page instead of http. After playing around with Firefox's config and still having the same issue, I ended up resetting my Kali VM and Firefox worked perfectly after the reboot. 

Once the Firefox issue was resolved and I had initial access on the `image` box, it quickly became apparent that I'd abruptly lost the ability to copy out of the VM - I ended up typing out both the `local.txt` & `proof.txt` flags by hand. 

The biggest lesson out of this though came from looking at [a different walkthrough](https://medium.com/@robertip/oscp-practice-image-proving-ground-practice-47a18735fa20) and learning about the [SUID3NUM script](https://github.com/Anon-Exploiter/SUID3NUM) for enumerating the SUID bins with GTFObins. Being able to quickly and easily identify binaries that have entries on GTFObins (and the command to test it with!) is exceedingly cool, and definitely something I'll try before `Linpeas.sh` in the future.

# Resolution summary
- Ran Nmap to identify ports `22` & `80`
- Visited http (`80`) & identified ImageMagick v6.9.6-4
- Created `.png` file with base64-encoded reverse shell in filename
- Uploaded file and achieved initial access
- Checked `strace` privileges and found SUID bit set
- Used GTFObins to achieve privilege escalation to `root`
## Improved skills
- Creating/managing malicious image files
- Finding privesc through GTFObins
## Used tools
- nmap
- gobuster

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN image.nmap 192.168.201.178 -v
```

Enumerated open TCP ports:
```bash
PORT   STATE SERVICE VERSION                                                                                      
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.7 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 62:36:1a:5c:d3:e3:7b:e1:70:f8:a3:b3:1c:4c:24:38 (RSA)
|   256 ee:25:fc:23:66:05:c0:c1:ec:47:c6:bb:00:c7:4f:53 (ECDSA)
|_  256 83:5c:51:ac:32:e5:3a:21:7c:f6:c2:cd:93:68:58:d8 (ED25519)
80/tcp open  http    Apache httpd 2.4.41 ((Ubuntu))
|_http-server-header: Apache/2.4.41 (Ubuntu)
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-title: ImageMagick Identifier
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
```

---
# Enumeration
## Port 22 - SSH (OpenSSH 7.9p1)
No enumeration conducted
## Port 80 - HTTP (Apache 2.4.41)
- Navigated to `192.168.201.178:80` and identified ImageMagick
![[Pasted image 20241009194802.png]]
- Attempted to "Upload and Identify" .jpg file, and received upload confirmation along with ImageMagick version (6.9.6-4)
	- Identified [potential RCE exploit](https://github.com/overgrowncarrot1/ImageTragick_CVE-2023-34152) for this version [(CVE-2016-5118)](https://github.com/advisories/GHSA-6w95-mr48-gp8c)
![[Pasted image 20241009200137.png]]
- Ran `gobuster dir -u  http://192.168.201.178 -w //usr/share/dirb/wordlists/big.txt` to try to identify other web directories
![[Pasted image 20241009195235.png]]
---
# Exploitation
## Malicious File Upload
- Ran `nc -nvlp 4444` to start NetCat listener on port `4444`
- Created `.png` file with base64-encoded reverse shell in the filename
![[Pasted image 20241009210327.png]]
- Uploaded file to `ImageMagick` web server
![[Pasted image 20241009210359.png]]
- Caught reverse shell as `www-data` user
![[Pasted image 20241009210445.png]]
---
# Privilege Escalation
## Local Enumeration
- Navigated to `/var/www` and printed `local.txt`
![[Pasted image 20241009210850.png]]
## Privilege Escalation vector
- Ran `which strace` and `ls -lah /usr/bin/strace` to check `strace` privilege, finding SUID bit is set
![[Pasted image 20241009211719.png]]
- Checked GTFObins to find `strace` with SUID bit set can be used for privilege escalation, and used it to achieve root
![[Pasted image 20241009211835.png]]
---
# Trophy & Loot
`local.txt` = `8c86bb3b1bf55b83b43ad8a382009f33`
`root.txt` = `157b35b189136d01cd1fd6f2854683a9`
