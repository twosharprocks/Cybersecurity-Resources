Tags: [[Cyber]]

---
# Networking
**Network security** is the practices and policies used to protect and monitor a computer network’s resources against threats and risks.

**Client-server model** is a network computing model that defines how resources and services are shared across a network. Uses a **<span style="text-decoration:underline;">“request and response”</span>** method of device communication.

**Network threats and risks**
* Unauthorized access into networks
* Denial of service (DoS) attacks
* Eavesdropping
* Data modification (eg attacker steals your data & modifies without your knowledge)

**Local Area Network (LAN)** is a private computer network that connects devices in smaller physical areas like a room or single building, such as a small office or home network.
* Advantages: Network speed/performance, security, versatility
* Disadvantages: Limited to only sharing within their own network

**Wide Area Network (WAN)** is a network used to connect multiple LANs (Internet is a WAN)
* Disadvantages: Security Issues, Troubleshooting is challenging
## Open Systems Interconnection (OSI) Model

**Mnemonic: “Please do not throw sausage pizza away”
**Layer 1 - Physical**: Cables & Hubs. Pinouts, Cable Specs, Network Interface Cards
**Layer 2 - Data Link**: Ethernet. Uses frames, MAC address
**Layer 3 - Network**: IP Address. Uses packets, Transfer address to physical, network routing
**Layer 4 - Transport**: TCP, UDP. Split communication into packages
**Layer 5 - Session**: Traffic Control. Establish, Manage, Terminate, Coordinate comms
**Layer 6 - Presentation**:** **Format Data (ASCII, jpg, ect). Encryption/Decryption
**Layer 7 - Application**: End User. Data Presentation. Enables Apps to access the net (SMTP, HTTP, FTP)
## Network Devices
**Router** Used to connect two different LANS, two different WANs, or a LAN to a WAN 
**Switch** Forwards resources within a network (connects devices within a LAN)
* Typically in large businesses with many computers
* Typically feed into routers and can be programmed for resource management
**Bridge** Same as switch but only two connections, often used to tie two LANs together
**Hub** (OUTDATED) Same as a switch but **cannot** be programmed
**Network Interface Controller (NIC)** Connects Computer to a network
* Usually a circuit board or a chip
* Each computer must have a NIC to receive/send resources
**Modem (Modulator-DeModulator)** Converts data to a format for the network
* Computer speaks digital, ISP speaks analog
**Wireless Access Point (WAP)** Provides wireless devices network connectivity
**All-in-One Devices** Integrate Modems, WAPs, routers, and more.
* Advantages: Easy to use, less equipment to setup/maintain
* Disadvantages: Single point of failure, difficult to troubleshoot.
## Network Security Devices
**Firewall** Monitors & manage incoming/outgoing traffic
* Typically placed right at LAN entry point to protect confidentiality & integrity
**Load Balancers** Distributes incoming traffic across multiple servers
* Ensures no single server has too much traffic, protecting resource availability
* Typically placed right after the firewall
**Demilitarised Zone (DMZ)** Smaller subnetwork within a LAN to protect internal data
* Typically has it’s own network security devices to detect/block before reaching internal networks
## Network Topology
**Linear** Each device is connected to the next via two-way link
* Advantages: Adding devices to the network is easy.
* Disadvantages: Single device failure can interrupt entire network. Variable latency between devices
**Ring** Each device is connected to the next in the loop (uni or bi-directional)
* Advantages: Simple, no central node, adding is easy
* Disadvantages: Every device is a failure point, variable latency
**Star** Each device is attached to a central node (eg. a server)
* Advantages: Consistent latency, easy to extend, node failure has no effect on network
* Disadvantages: Network size limited by central node connections, difficult if central node is far from end devices \
**Bus** Each device is attached to a central data link
* Advantages: Fast transmission, easy to expand
* Disadvantages: Bandwidth waste, devices cannot transmit simultaneously
**Tree** Each device has only one connection between any only connected 
* Advantages: Easy to expand
* Disadvantages: If a node fails all devices below are effected
**Fully Connected** Every device is connected to every other device
* Advantages: High redundancy, fast transmission
* Disadvantages: Complicated setup/management, expensive to establish
* [Calculating the number of wires for a fully meshed network](https://x-engineer.org/wires-fully-meshed-network/)
**Mesh** 	Many (but not <span style="text-decoration:underline;">all)</span> devices are connected to find shortest path to forward data
* Advantages/Disadvantages: Same as fully connected
**Hybrid** Mixture of different network topologies
* Advantages/Disadvantages: Depend on network types being combined
## IP Addresses
**Internet Protocol (IP)** is a numerical network address associated with a device such as a computer, printer, router or server. 
* [www.whatsmyip.org](http://www.whatsmyip.org) 
* [iplocation.io](https://iplocation.io/) [Significant info from multiple sources, inc geolocation & ASN]
* [Binary to IP Converter (for IPv4](https://www.browserling.com/tools/bin-to-ip))

### IP Types
**IPv4** Four Octets (8 binary bits = one byte) ranging 0-255, separated by decimals (eg. 10.4.79.254)
**IPv6** Eight groups of 2 bytes encoded in hexidecimal (hex) separated by colon (eg. 2001:0db8:85a3:0000:0000:8a2e:0370:7334)
* IPv6 has <span style="text-decoration:underline;">not</span> been widely adopted and many devices need to be updated before accepting IPv6 addresses
### IP Categories
**Private IP addresses** are NOT exposed to the internet (typically within a LAN)
* Assigned by LAN’s network administrator
* Can be reused, won’t conflict across different networks, more secure
* Private IPv4 ranges fall within:
    * Class A Private = 10.0.0.0 - 10.255.255.255 (16,777,216 available)
    * Class B APIPA = 169.254.0.0 - 169.254.255.255
        * Microsoft Windows feature automatically assigns this range if a Dynamic Host Configuration Protocol (DHCP) server is not available
    * Class B Private = _172.16.0.0 - 172.31.255.255_ (1,048,576 available)
    * Class C Private = _192.168.0.0 - 192.168.255.255_	(65,536 available)
**Public IP addresses** can be accessed over the internet
* Assigned in IP ranges by an Internet Service Provider (ISP)
* Any address **<span style="text-decoration:underline;">not</span>** within the Private IP4 ranges is **public**
* Public IPv4 can also be classed:
    * Class A (Large Org) 	    = 1.0.0.0 - 127.0.0.0 (1oct = 1-127)
    * Class B (Medium Org)      = 128.0.0.0 - 191.0.0.0 (1oct = 128-191)
    * Class C (Small LAN) 	    = 192.0.0.0 - 223.255.255.0 (1oct = 192-223)
    * Class D (Multicasting)	= 224.0.0.0 - 239.255.255.255 (1oct = 224-239)
    * Class E (Research) 	    = 240.0.0.0 - 255.255.255.255 (1oct = 240-255)
**Loop-back addresses** are for network testing
* Range 127.0.0.1 - 127.255.255.255
* These are virtual IP addresses that cannot be assigned to a device, but are used to ping a computer’s TCP/IP network software driver
## Subnetting
**Subnetting** is the process of breaking up an IP address range into smaller, more specific networks of grouped devices.
* [IPv4 Subnet Calculator](https://www.vultr.com/resources/subnet-calculator/)
* [IPv6 Subnet Calculator](https://www.vultr.com/resources/subnet-calculator-ipv6/)

**Classless Inter-Domain Routing (CIDR)** is a format fixing the number of bits which are static for the network. [CIDR-IP Range Calculator](https://www.ipaddressguide.com/cidr)
* CIDR replaces the older A, B and C classes of IP addresses
* 0 & 255 are reserved for the subnet ID and broadcasting respectively
* <span style="text-decoration:underline;">Example:</span> 192.243.3.0 /24 = 24 bits of the address (eg. 1st 3 octets) are static, so 192.243.3 are fixed and up to 255 IP addresses are available with the final octet
## MAC Address
**Media Access Control (MAC) Addresses** are burned-in addresses assigned to network interface cards which must be unique to each NIC on the same network.
* MAC addresses have 6 sets of alphanumeric characters separated by colons
* First 24-bits (1st 3 octets) identify the device vendor/manufacturer
* Example: 00:0a:95:9d:68:16 where 00:0a:95 is Apple, Inc.
* [MAC Address Lookup](https://macaddress.io/)

**Address Resolution Protocol (ARP)** maps the MAC address to an IP address within a LAN
* **ARP cache poisoning** or **ARP spoofing** is a MitM attack that allows attackers to intercept communication between network devices. [[ARP Spoofing Explainer]](https://www.imperva.com/learn/application-security/arp-spoofing/)
## DNS
**Domain Name System (DNS)** translates domain names to IP addresses, eg. facebook.com translates to the IP address 31.13.65.36 
* [Cisco DNS Best Practice, Network Protections, and Attack Identification](https://sec.cloudapps.cisco.com/security/center/resources/dns_best_practices)
* [DNS Records Explained (A, AAAA, CNAME, DNAME, MX, NS, PTR, SPF, ect)](https://ns1.com/resources/dns-records-explained)
**DNS Lookup** directs the browser to search a series of caches to find the IP address associated with the domain name. This search process is;
1. Browser cache
2. Operating System cache (stored in hosts file)
3. Internet Service Provider (ISP) cache
4. Top-Level Domain (TLD) cache

**Reverse DNS Lookup** provides the domain name for a given IP address, and is stored as a **PTR (Pointer) record** on the special **_.arpa_** domain name.
* [Reverse DNS Lookup](https://www.whatsmydns.net/reverse-dns-lookup)
* IPv4 “A” records are stored under the subdomain_ <code>.in-addr.arpa</code></em>
* IPv6 “AAAA” records are stored under the subdomain <code><em>.ip6.arpa</em></code>

<strong>DNS hijacking</strong> Type of network attack that exploits DNS vulnerabilities to divert web traffic away from legitimate servers and to fake/malicious servers.
**Uniform Resource Locatior (URL)** is the specific location of a resource in a domain
* Syntax: [URI scheme]://[subdomain].[domain].[TLD][/path/][filename]
* Example: https://www.facebook.com/photos/catpicture.jpg
    * https_ = Uniform Resource Identifer for “Secure Hypertext Transfer Protocol”
    * www = subdomain
    * facebook = primary domain
    * .com = Top-Level Domain 
    * /photos/ = path where the resource is located
    * catpicture.jpg_ = resource being requested
## Network Protocols
**Network Protocols** ensure messages are fully sent and understood.
* Example: `FIN` is used by TCP messages to indicate the end of a message
* Common Protocols
    * HTTP: Hypertext Transfer Protocol (Web traffic)
    * FTP: File Transfer Protocol (File transfer) **[INSECURE]**
    * PAP: Password Authentication Protocol (User authentication)
    * SMB: Server Message Block (Windows file sharing)
    * NetBIOS: Network Basic Input/Output System (LAN communication)
**Network Packet** is a binary message adhering to protocol rules.
* Example IPv4 is up to 65,535 bytes including **Header** (20-60 bytes) + **Payload**
* Headers may contain protocol name/version, destination address, packet length
* Version is defined 

**Transmission Control Protocol** requires acknowledgement to ensure all data is transmitted without error and in the correct order.
*  **TCP three-way handshake** is the process of establishing a reliable connection to transmit data between devices. 
    * Setup = SYN → | SYN-ACK ← | ACK → (then data →)
    * Terminate = FIN → | ACK ← FIN ← | ACK → 

**User Datagram Protocol (UDP)** is useful for situations when it’s not necessary for all data to reach the destination.

**Dynamic Host Configuration Protocol ([DHCP](https://whatismyipaddress.com/dhcp))** is a protocol used for automatically setting different configurations (including IP-addresses).
* **DHCP Four-way handshake**: Discover, Offer, Request, Acknowledge
* **DHCP Starvation** is a type of DDos attack where a DHCP Server is flooded with Discover requests, and the DHCP server runs out of internal IP addresses to assign to legitimate users. 
* **DHCP Spoofing** can follow _DHCP Starvation_ in order to provide a false DHCP server to allocate IP addresses to create a Man-In-The-Middle situation

**Network Address Translation (NAT)** is a method of mapping a private IP address to a public IP address and vice versa.
**Routing** is the act of choosing the path that traffic takes in or across networks.
* **Unicast:** A single device delivers a message to another single, specific device.
* **Broadcast:** A single device broadcasts a message to all devices on that network.
* **Multicast**: A device sends a message to devices that have expressed interest in receiving the message.

Routing can also be either static or dynamic
* **Static routing** is the manual configuration of a network route, typically done by a network administrator.
    * <span style="text-decoration:underline;">Advantages</span>: Lower router CPU, admin has full control of routing behavior.
    * <span style="text-decoration:underline;">Disadvantages</span>: Fault tolerance, meaning if a device on a manually created path fails, the route can’t be adjusted.
* **Dynamic Routing**
[Types of Routing Protocols](https://www.comparitech.com/net-admin/routing-protocol-types-guide/) [Comprehensive]
## Ports
**Ports** are access points for transmitting and receiving data
**Internet Assigned Numbers Authority (IANA)** is the entity officially responsible for assigning port numbers for a designated purpose.
**Port Numbers** range from 0 to 65535
* **System ports** (0-1023) Restricted to the OS or administrator
    * [Well-Known Ports](https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers#Well-known_ports): 
        * 20 (FTP - Transfer) 
        * 21 (FTP - Commands) 
        * 22 (SSH) 
        * 23 (TELNET) 
        * 25 (SMTP) 
        * 53 (DNS) 
        * 67 (DHCP - Data to Server) 
        * 68 (DHCP Data to Client) 
        * 80 (HTTP) 
        * 81 (TorPark)
        * 88 (Kerberos Authenticate)
        * 109 (POP2)
        * 110 (POP3) 
        * 123 (NTP) 
        * 143 (IMAP) 
        * 264 (BGMP) 
        * 443 (HTTPS) 
        * 464 (Kerberos Change/Set Password)
        * 543 (Kerberos login)
        * 545 (Kerberos Remore Shell)
        * 546 (DHCPv6 Client)
        * 565 (DHCPv6 server)
* **[Registered/User ports](https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers#Registered_ports)** (1024-49151) Normal users launching services
    * 3389 (RDP) 
    * 8005 (Tomcat Remote Shutdown)
    * 8333 (Bitcoin)
* **[Dynamic/Private ports](https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers#Dynamic,_private_or_ephemeral_ports)** (49152-65535) “Source” ports for machine→machine
## Network Tools {#network-tools}
<span style="text-decoration:underline;">NMap</span> - IP address & Port scanner
* [NMap Cheat Sheet](https://www.stationx.net/nmap-cheat-sheet/)
### Wireshark
* [Wireshark User Manual](https://www.wireshark.org/docs/wsug_html_chunked/)
* [Wireshark Learning Resources](https://www.wireshark.org/#learnWS)
* [General Wireshark Filters](https://www.wifi-professionals.com/2019/03/wireshark-display-filters)
* [Wireshark MAN Page](https://www.wireshark.org/docs/man-pages/wireshark-filter.html)
* [Wireshark Filters (WifiNinjas Blog)](https://wifininjas.net/2019/05/29/wn-blog-002-wireshark-filters/)
* [Wireshark Cheat Sheet](https://cdn.comparitech.com/wp-content/uploads/2019/06/Wireshark-Cheat-Sheet-1.jpg) [Important Cheat Sheet]

frame contains “string” Searches all frames for a specific string
frame.number in {frame#, frame#...} Displays the frames listed 
### UFW

* `ufw version` Determine what version of UFW is installed.
* `sudo ufw reset` Reset all UFW rules to factory defaults.
* `sudo ufw status` Check the current status of the firewall.
* `sudo ufw enable` Start the firewall and update rules.
* `sudo ufw default deny incoming` Block all incoming connections.
* `sudo ufw default allow outgoing` Allow all outgoing connections.
* `sudo ufw allow` Open specific ports (eg. 80, 22, 443)
* `sudo ufw deny` Close specific ports.
* `sudo ufw delete` Delete rules.
* `sudo ufw disable` Shut down the firewall.
* `sudo ufw reload` Reload the UFW firewall.
* `sudo apt remove ufw` Uninstall ufw
### Firewalld

* `sudo /etc/init.d/firewalld start` start firewalld.
* `sudo service firewalld stop` stop firewalld
* `sudo service firewalld status` firewalld status
* `sudo firewall-cmd --list-all-zones` list all current zones.
* `sudo firewall-cmd --zone=home --change-interface=eth0` bind together interfaces.
* `sudo firewall-cmd --get-services` list currently configured services.
* `sudo firewall-cmd --zone=home --list-all` list all currently configured services for a specific zone.
* `sudo firewall-cmd --zone=home --add-rich-rule=` add specific rules to specific zones

**Network security monitoring** Uses a variety of data analysis tools to detect and stop threats after most front-end layers are compromised.
## SIEM and SOAR

### ELK Stack

* Elasticsearch - Storage engine for storing and indexing data
* Logstash - Log aggregator
* Kibana - Visualisation
### Splunk
* [Splunk Quick Reference Guide](https://www.splunk.com/pdfs/solution-guides/splunk-quick-reference-guide.pdf)
* [Splunk Fundamentals 1,2,3](https://www.splunk.com/en_us/training/splunk-fundamentals.html?301=/en_us/training/free-courses/splunk-fundamentals-1.html)
### Snort (NIDS)
Snort uses rules to detect and prevent intrusions. Snort operates by:
1. Reading a configuration file.
2. Loading the rules and plugins.
3. Capturing packets and monitoring traffic for patterns specified in the loaded rules.
4. When traffic matches a rule pattern, generating an alert and/or logging the matching packet for later inspection.

Rules can direct Snort to monitor the following information:
* OSI layer: Watches for IP vs. TCP data.
* Source and destination address: Where the traffic is flowing from and to.
* Byte sequences: Patterns contained in data packets that might indicate malware, etc. 

Consider the following Snort rule:
* alert ip any any -> any any {msg: "IP Packet Detected";}
* This rule logs the message "IP Packet Detected" whenever it detects an IP packet. 

Example:
`alert tcp any 21 -> 10.199.12.8 any {msg: "TCP Packet Detected";}`
* This rules triggers an alert whenever a TCP packet from port 21, with any source IP address, is sent to the IP 10.199.12.8. With each alert, it will print the message "TCP Packet Detected." \

* Rule Header
    * `alert`: The action that Snort will take when triggered.
    * `tcp`: Applies the rule to all TCP packets.
    * `any`: Applies the rule to packets coming from any source IP address.
    * `21`: Applies the rule to packets from port 21.
    * `->`: Indicates the direction of traffic.
    * `10.199.12.8`: Applies the rule to any packet with this destination IP address.
    * `any`: Applies the rule to traffic to any destination port.
* Rule Option
    * `{msg: "TCP Packet Detected";}` The message printed with the alert.
* Snort provides many additional actions and protocols, which can be combined to design rules for almost any type of packet.
