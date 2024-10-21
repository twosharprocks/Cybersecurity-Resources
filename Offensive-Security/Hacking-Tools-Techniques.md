# OSINT

Easy lookup data
* [OSINT Framework](https://osintframework.com/) - Comprehensive site referrer
* [Nmmapper - Multiple OSINT Tools](https://www.nmmapper.com/)
* [IP Lookup](https://iplocation.io/)
* [Registrar & DNS Lookup](https://www.nslookup.io/)
* [SSL Certs](crt.sh)
* Finding Subdomains
    * [Subdomain Finder c99](https://subdomainfinder.c99.nl/)
    * [sublist3r (Linux)](https://www.kali.org/tools/sublist3r/) [[Using sublist3r tutorial]](https://null-byte.wonderhowto.com/how-to/discover-hidden-subdomains-any-website-with-subfinder-0341687/)
* [MAC Address Lookup](https://macaddress.io/)

Google Dorking
[Google Search Operators: The Complete List](https://ahrefs.com/blog/google-advanced-search-operators/)

Easy dorks
* Exclude boring pages with -ves, eg. `site:<domain> -www -shop -otherboringshit`
* Combine dorks with | (include both ) or & (require both)
* Leftover code
   * `site:pastebin.com "targetsite.com"`
   * `site:jsfiddle.net "targetsite.com"`
   * `site:codebeautify.org "targetsite.com"`
   * `site:codepen.io "targetsite.com"`
* Find php files with ext:php, eg. `site:targetsite.com ext:php inurl:?`
* Check Disclosed Bug Bounties with openbugbounty.org, eg. `site:openbugbounty.org inurl:reports intext:"targetsite.com"`
## OSINT Tools
* [Maltego](https://www.maltego.com/) - Relationships among people, companies, domains and publicly accessible information
* [Mitaka](https://chrome.google.com/webstore/detail/mitaka/bfjbejmeoibbdpfdbmbacmefcbannnbg) - Chrome Extension that searches IP addresses, domains, URLs, hashes, ASNs, Bitcoin wallet addresses, and various indicators of compromise (IOCs) from your web browser.
    * Alternative [“Sputnik”](https://github.com/mitchmoser/sputnik)
* [SpiderFoot](https://github.com/smicallef/spiderfoot) - Run from Commandline or Web-based GUI
* [Spyse](https://spyse.com/) - internet assets registry for cybersecurity professionals. Relied on by OWASP, IntelligenceX, and SpiderFoot
* [BuiltWith](https://builtwith.com/) - Detect whether a website is using WordPress, Joomla, or Drupal as its CMS and provide further details.
    * Combine with [WPScan](https://github.com/wpscanteam/wpscan) and [WordPress Vulnerability Database API](https://wpscan.com/api) to find common security vulnerabilities
* [Intelligence X](https://intelx.io/) - Wayback Machine but for everything 
* [DarkSearch.io](https://darksearch.io/) - Good platform for starting with Dark web research activities
    * Alternative - [Ahmia](https://ahmia.fi/)
* [Grep.app](https://grep.app/) - Search code snippets across all GitHub repositories
* [Recon-ng](https://github.com/lanmaster53/recon-ng) - Python to automate OSINT activities (eg. copy/paste)
* [theHarvester](https://github.com/laramies/theHarvester) - Gathers organistional emails, names, subdomains, IPs and URLs
* [Shodan](https://www.shodan.io/) - Device intelligence (eg. IOT) including open ports & vulnerabilities
* [Metagoofil](https://github.com/laramies/metagoofil) - Optimized to extract metadata from public documents, returns usernames, file paths, server names, shared resources and directory tree information
* [Searchcode](https://searchcode.com/) - Source code search engine; returns usernames, security flaws like [eval $_GET calls](https://owasp.org/www-community/attacks/Direct_Dynamic_Code_Evaluation_Eval%20Injection), active functions like re.compile, special characters for code injection
* [Babel X](https://babelstreet.com/) - Multilingual search tool for the public internet, including blogs, social media, message boards and news sites. Also searches dark web, including Onion sites, and some deep web content.
* [Osmedeus](https://www.osmedeus.org/) - A Workflow Engine for recon in offensive security
* [PhoneInfoga](https://github.com/sundowndev/phoneinfoga) - Scanning international phone numbers for information
* [Sherlock](https://github.com/sherlock-project/sherlock) - Searching social networks
* [Social Analyzer](https://github.com/qeeqbox/social-analyzer) - Searching social networks

# Network Exploitation Techniques
* [Setting up a reverse shell [Network Chuck]](https://www.youtube.com/watch?v=bXCeFPNWjsM&list)
   * [Online Reverse SHell Generator](https://www.revshells.com/)   
* [NullByte HowTo [Huge Resource]](https://null-byte.wonderhowto.com/)
* [HackTricks - HUGE resource](https://book.hacktricks.xyz/welcome/readme)

* [MFA Fatigue](https://www.bleepingcomputer.com/news/security/mfa-fatigue-hackers-new-favorite-tactic-in-high-profile-breaches/amp/) - Spamming a login that requires MFA until a user approves to stop the notifications, or follow up with a call pretending to be IT requesting approval
* [Domain Shadowing](https://www.bleepingcomputer.com/news/security/domain-shadowing-becoming-more-popular-among-cybercriminals/amp/) - Subcategory of DNS hijacking, where threat actors compromise the DNS of a legitimate domain to host their own subdomains for use in malicious activity but do not modify the legitimate DNS entries that already exist. These subdomains are then used to create malicious pages on the cybercriminals' servers while the domain owner's site's web pages and DNS records remain unchanged, and the owners don't realize they have been breached.

* [Man In The Middle (MITM)](https://www.techtarget.com/iotagenda/definition/man-in-the-middle-attack-MitM)
    * [Spoofing Hotel Wifi ](https://www.lookout.com/blog/spoofed-wifi-60-minutes)
* [Bypass Software Registration](https://null-byte.wonderhowto.com/how-to/hacks-behind-cracking-part-1-bypass-software-registration-0132568/) - Run program in a debugger
* [Phishing Windows Credentials](https://pentestlab.blog/2020/03/02/phishing-windows-credentials/)
    * [FakeLogonScreen](https://github.com/bitsadmin/fakelogonscreen)

# References

* [Pentesttools.net](https://pentesttools.net/)
* [Hacking Tools RESOURCE](https://en.m.wikibooks.org/wiki/Hacking/Tools) - Comprehensive Resource
* [SecLists](https://github.com/danielmiessler/SecLists) - Comprehensive security lists for fuzzing, username/password, payloads, ect 
* [Wordlists & Rainbow Tables for WEP/WPA/WPA2](https://wifi0wn.wordpress.com/wepwpawpa2-cracking-dictionary/)
* [Book of Secret Knowledge](https://github.com/trimstray/the-book-of-secret-knowledge#hackingpenetration-testing-toc) - Huge reference for various IT
### Operating Systems
* [Kali Linux](https://www.kali.org/)
    * [Kali’s Default Credentials (and tools shipped with)](https://www.kali.org/docs/introduction/default-credentials/)
* [ParrotOS]
* [BlackArch] 
### Brute Force Tools
* Cracking
   * [John the Ripper](https://www.openwall.com/john/) Brute-force password tester
       - [Usage Examples with John the Ripper](https://www.openwall.com/john/doc/EXAMPLES.shtml)
       - [John the Ripper Tips and Tutorials](https://www.varonis.com/blog/john-the-ripper)
   * [Hashcat](https://hashcat.net/hashcat/) - Hash cracker
       - [How to crack passwords with Hashcat](https://geekflare.com/password-cracking-with-hashcat/) 
       - [CrackQ on GitHub](https://github.com/f0cker/crackq)
       - [CrackQ (GUI Interface with automation)](https://www.helpnetsecurity.com/2019/12/04/password-cracking-pentesters/)
   * [Aircrack-ng](https://www.aircrack-ng.org/doku.php?id=getting_started) - WiFi DeAuth attack
       - [How To Use Aircrack-ng](https://techofide.com/blogs/how-to-use-aircrack-ng-aircrack-ng-tutorial-practical-demonstration/)
       - [wikiHow - Cracking WPA/WPA2](www.wikihow.com/Hack-WPA/WPA2-Wi-Fi-with-Kali-Linux)
* Logins
	- [Hydra](https://www.kali.org/tools/hydra/) 
		- [Using Hydra - SSH Password Spraying, Dictionary Attacks, ect](https://www.freecodecamp.rg/news/how-to-use-hydra-pentesting-tutorial/)
		- [Hydra to Brute-Force SSH Connections](https://www.geeksforgeeks.org/how-to-use-hydra-to-brute-force-ssh-connections/)
		- [Hydra Cheatsheet](https://github.com/frizb/Hydra-Cheatsheet)   
	- [Medusa](https://github.com/jmk-foofus/medusa) - Speedy, parallel, and modular, login brute-forcer
###  Web Vulnerability Scanning
* [Nessus](https://www.tenable.com/products/nessus/nessus-professional) - Vulnerability scanner
   * [Nessus Docker Image](https://hub.docker.com/r/tenableofficial/nessus)
* [OpenVAS](https://www.openvas.org/) - Open Source Vulnerability Scanner
   * [Installing OpenVAS on Kali](https://www.geeksforgeeks.org/installing-openvas-on-kali-linux/)
* [OWASP ZAP - Zed Attack Proxy](https://www.zaproxy.org/)
* [sqlmap](https://sqlmap.org/) - Automated scanning & exploitation of SQL injection vulnerabilities
* [W3AF](https://w3af.org/) - Web Application Attack and Audit Framework
* [Burp Suite](https://portswigger.net/burp)
* [Amass](https://github.com/owasp-amass/amass) - In-depth attack surface mapping and asset discovery

### API Hacking
* [API Security Testing Checklist](https://danaepp.com/an-api-security-testing-checklist-with-a-twist) [START HERE]
   * [Shieldfy API Security Checklist on Github](https://github.com/shieldfy/API-Security-Checklist)
* [8 Common API Vulnerabilities](https://apimike.com/api-vulnerabilities)
* [Using Common Attack Patterns against an API](https://danaepp.com/3-ways-to-use-common-attack-patterns-to-abuse-an-api)
* [API Discovery with CeWL](https://danaepp.com/a-cewl-way-for-api-discovery) - Custom Word List generator for API discovery
   * [CeWL on Github](https://github.com/digininja/CeWL)

### Web Fuzzing
* [Dirsearch](https://github.com/maurosoria/dirsearch) - Brute force web path scanning
* [ffuf](https://github.com/ffuf/ffuf) - "Fuzz Faster U Fool" Go-based fast web fuzzing tool
* [GoBuster](https://github.com/OJ/gobuster) - Go-based fuzzing tool (Default with Kali)
* [FuzzDB](https://github.com/fuzzdb-project/fuzzdb) - Database of attack patterns, wordlists, dictionaries, ect for fuzzing

### Network Vulnerability Scanning
* [nmap](https://nmap.org/) - Network and vulnerability discovery
    * [How to use Nmap for vulnerability scanning - NSE](https://geekflare.com/nmap-vulnerability-scan/)
    * [NMap Switches & Scan Types](https://www.digitalocean.com/community/tutorials/nmap-switches-scan-types)
    * [ncat](https://nmap.org/ncat/) - Built into NMap for reading and writing data across networks 
    * [Zenmap](https://nmap.org/book/zenmap.html) - GUI version of NMap
* [Sn1per](https://github.com/1N3/Sn1per) - Discover attack surfaces & vulnerabilities, automate exploits
    *  GBHaclers Sn1per Demo](https://gbhackers.com/sn1per/)
* [Commix](https://commixproject.com/) - Automated scanning & exploitation of command injection vulnerabilities
    * [Commix on GitHub](https://github.com/commixproject/commix)
* [Karkinos](https://github.com/helich0pper/Karkinos) - Pentesting multitool
    * Encode/Decode, encrypt/decrypt, generate/crack hashes, 
    * Port scanning, reverse shell handling, file busting
* [Sifter](https://github.com/whiterabb17/sifter) - OSINT, recon & vulnerability scanning/exploitation
    * Tutorial - [How Sifter stacks and automates useful pentesting tools](https://www.hackingloops.com/sifter/)
* [HackTools](https://github.com/LasCC/Hack-Tools) - Web extension with tools & cheat sheets (works with Metaspoilt)
    * SQLi, XSS, Local File Inclusion
    * Dynamic Reverse Shell Generator
    * Data Exfil & download to remote machines
    * Hash Generator for SHA1, SHA256, SHA512, MD5, SM3, etc.
    * MSFVenom for payload creation
* [Modlishka](https://github.com/drk1wi/Modlishka) - Automated HTTP reverse proxy
    * Poison HTTP 301 browser cache
    * Hijack non-TLS URLs
    * Identify/Highlight 2FA vulnerabilities

### Exploitation
* [BeEF](https://beefproject.com/) - Browser Exploitation Framework using client-side attack vectors
    * [BeEF on GitHub](https://github.com/beefproject/beef)
* [Metasploit](https://www.metasploit.com/) - TCP port scanning & vulnerability identifcation/exploitation
    * Default credentials: Username - postgres, Password - postgres
    * [What is Metasploit?](https://www.csoonline.com/article/3379117/what-is-metasploit-and-how-to-use-this-popular-hacking-tool.html)
    * [Installing Metaspoilt on Ubuntu](https://adamtheautomator.com/install-metasploit-on-ubuntu/)
    * [Basic Metaspoilt Commands](https://www.tutorialspoint.com/metasploit/metasploit_basic_commands.htm)
    * [Rapid 7 Quick Start Guide](https://docs.rapid7.com/metasploit/)
    * [Metaspoilt Unleashed [Free Course]](https://www.offensive-security.com/metasploit-unleashed/)
    * [Metasploit for Pentesters](https://www.hackingarticles.in/metasploit-for-pentester-sessions/)
    * Modules
        * [Kerberos Domain Username Enumeration](https://www.attackdebris.com/?p=311)
        * [500 Most Common Usernames](https://www.attackdebris.com/?p=364)
        * [Meterpreter Tips & Tricks](https://medium.com/@rob.mccarthy31/meterpreter-tips-tricks-17877dda10fa)
* [Mimikatz (on GitHub)](https://github.com/gentilkiwi/mimikatz/wiki)
    * [Unofficial Guide & Command Reference](https://adsecurity.org/?page_id=1821)
    * [Blog - What is Mimikatz (Beginners Guide)](https://www.varonis.com/blog/what-is-mimikatz)
* [Ettercap](https://www.ettercap-project.org/) - Man in the middle attack platform
### C2 Platforms
* [Merlin](https://github.com/Ne0nd0g/merlin) 
## Linux Specific Techniques

### Privilege Escalation
* [Basic Linux Privilege Escalation [Cheat sheet]](https://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation/)

**<span style="text-decoration:underline;">Kernel Exploits </span>**
For a kernel exploit attack to succeed, four conditions are required:
* A vulnerable kernel
* A matching exploit
* The ability to transfer the exploit onto the target
* The ability to execute the exploit on the target

_Example_: Dirty Cow Exploit replaces “root” with “rash” by editing the /etc/passwd file
* [DirtyCow variants on GitHub](https://github.com/dirtycow/dirtycow.github.io/wiki/PoCs)

_Example_: [Dirty Pipe Exploit](https://arstechnica.com/information-technology/2022/03/linux-has-been-bitten-by-its-most-high-severity-vulnerability-in-years/) [[Link to code](https://haxx.in/files/dirtypipez.c) that hijacks SUID binary for root access]

Kernel exploits can be searched through Kali using “searchspoilt”
* $ searchspoilt Linux Kernel 2.6.24 (← Kernel number found by running uname -a)

**<span style="text-decoration:underline;">Root-Service Exploits</span>**
Exploits that operate through services running as root. 
Check open and active ports by running netstat -antup [[How to use netstat]](https://www.howtogeek.com/513003/how-to-use-netstat-on-linux/)

_Examples_: [EternalBlue](https://en.wikipedia.org/wiki/EternalBlue), [SambaCry](https://thehackernews.com/2017/05/samba-rce-exploit.html) 
_Example_: [PwnKit](https://arstechnica.com/information-technology/2022/01/a-bug-lurking-for-12-years-gives-attackers-root-on-every-major-linux-distro/) runs on the back of the PolKit daemon for system-policy management

[MySQL UDF Dynamic Library Exploit](https://www.exploit-db.com/exploits/1518/)
* Find services running as root: ps -aux | grep root
* From the mysql shell:
    * create function do_system returns integer so name ‘raptor_udf2.so’
    * select do_system(‘id > /tmp/out; chown smeagol.smeagol /tmp/out’);
    * \! sh

**<span style="text-decoration:underline;">SUID Executable Exploits</span>**

“Set user ID” executes file permissions with a specific user using ‘s’ instead of ‘x’ in the permission set (eg. -rwsr-xr-x allows low privilege users to execute with root privileges). 

Avoid this by:
* Never set SUID on any program that allows escape to shell
* Never set SUID on any editor/comiler/interpreter

**<span style="text-decoration:underline;">SUDO Exploits</span>**
Misconfigured SUDO rights can allow root access through programs that edit code or allow escape to the shell

Avoid this by:
* Never give SUDO to any program that allows escape to shell
* Never give SUDO to vi, more, less, nmap, perl, ruby, python, gdb and others

**<span style="text-decoration:underline;">cron job Exploits</span>**
cron jobs usually run with root privilege to poorly configured cron files can allow arbitrary code to be executed

<span style="text-decoration:underline;">World-writable cron script Exploit</span>
* Print world-writeable files `find / -perm -2 -type f 2>/dev/null`
* Confirm cron file is writeable `ls -la /usr/local/sbin/cron-logrotate.sh`
* Write C file in /tmp `cd /tmp` then `vi rootme.c`
* Compile C file `cat rootme.c`
* Change exec owner & group to root
`echo “chown root:root /tmp/rootme; chmod u+s /tmp/rootme;” >/usr/local/sbin/cron-logrotate.sh`
* After 5 mins confirm C file root privilege `ls -la rootme`
* Run file to spawn root shell `./rootme`

Avoid this by:
* Scripts & binaries in cron jobs should not be writable
* cron file should not be writable except for root
* cron.d directory should not be writable except for root

<span style="text-decoration:underline;">‘.’ User Path Exploits</span>
‘.’ allows the user to execute binaries/script from their current directory. If ‘.’ is removed, it allows attackers to rename a file as a command (eg. ls) that will execute as soon as someone (ideally with root privileges) uses it in the file’s directory.

ls “PATH Variable” Exploit
* Create a file in Home named “ls” with your malicious codename nano ls
* Add ‘.’ to the PATH variable PATH=.:${PATH}
* Root user executes ls and grants root privileges

<span style="text-decoration:underline;">Escaping rbash to bash</span>
[How-to escape rbash](https://gist.github.com/PSJoshi/04c0e239ac7b486efb3420db4086e290)
* List available commands `compgen -c`
* start bash without source'ing either ~/.bashrc or ~/.bash_profile 
* since such a shell wouldn't be a full login shell / have no tty attached, force ssh to attach a tty:
## Windows Specific

* [Windows Security Log Events](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/)
* [Teamviewer Flaw for cracking user passwords](https://threatpost.com/teamviewer-fhigh-severity-flaw-windows-app/158204/)
* [Remotely dumping Windows credentials](https://meriemlarouim.medium.com/credentials-in-windows-and-how-to-dump-them-remotely-b5c315bb76f4)
* [Using Impacket to Dump Windows Secrets](https://medium.com/@benichmt1/secretsdump-demystified-bfd0f933dd9b)
### M365 & Active Directory
* [Understanding Active Directory Attack Paths](https://thehackernews.com/2023/08/understanding-active-directory-attack.html)
* [Using Bloodhound CE to attack Active Directory](https://www.8com.de/cyber-security-blog/bloodhound-ce-and-automating-parts-of-ad-pentests)
* [Active directory pentesting](https://www.hackthebox.com/blog/active-directory-penetration-testing-cheatsheet-and-guide) - Cheatsheet and beginner guide
* [ScubaGear](https://github.com/cisagov/ScubaGear) - M365 security assessment tool, CISA-developed, run in Powershell
* [UntitledGooseTool](https://github.com/cisagov/untitledgoosetool) - AzureAD/M365 security assessment tool, Python-based, CISA-developed
# Cloud Techniques
## AWS 
* [HTB - AWS Penetration Testing Guide](https://www.hackthebox.com/blog/aws-pentesting-guide)
* [Infosec Writeups - Hacking AWS Cognito Misconfiguration](https://infosecwriteups.com/hacking-aws-cognito-misconfiguration-to-zero-click-account-takeover-36a209a0bd8a)
* [Not so secure - Hacking AWS Cognito Misconfigurations](https://notsosecure.com/hacking-aws-cognito-misconfigurations)
* [AdeliaRisk - 7 Ways I'd Hack You on AWS](https://adeliarisk.com/secure-cloud-computing-7-ways-id-hack-aws/)