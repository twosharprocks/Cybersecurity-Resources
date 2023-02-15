## UFW

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

## Firewalld

* `sudo /etc/init.d/firewalld start` start firewalld.
* `sudo service firewalld stop` stop firewalld
* `sudo service firewalld status` firewalld status
* `sudo firewall-cmd --list-all-zones` list all current zones.
* `sudo firewall-cmd --zone=home --change-interface=eth0` bind together interfaces.
* `sudo firewall-cmd --get-services` list currently configured services.
* `sudo firewall-cmd --zone=home --list-all` list all currently configured services for a specific zone.
* `sudo firewall-cmd --zone=home --add-rich-rule=` add specific rules to specific zones

**Network security monitoring** Uses a variety of data analysis tools to detect and stop threats after most front-end layers are compromised.


## Snort

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
