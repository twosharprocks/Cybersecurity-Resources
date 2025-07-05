Last Updated: 2025-04-07
Status: #Complete
Tags: [[RaaS]] [[Russia]] [[Criminal]] [[Ransomware]] [[Conti]] [[BlackBasta]] [[Grep]], [[Cyber]] [[Threat Modelling]]
# HellCat
**Alternative Names**: No widely known aliases
**Attribution**: Cybercriminal, likely Russian-speaking ransomware group with connections to underground forums.
**Type**: **Ransomware-as-a-Service (RaaS) group**
**First Active**: 2024
**Status**: Active
## Description
HellCat is a newly emerged ransomware group that operates under a Ransomware-as-a-Service (RaaS) model. The group primarily focuses on encrypting victims’ data and threatening to leak stolen information unless a ransom is paid. Unlike more sophisticated APTs, HellCat leverages off-the-shelf tools combined with custom malware to gain access to enterprise networks. The group has been particularly active in targeting European and North American organizations, with attacks escalating in late 2024.
## Objectives
- Financial extortion through ransomware deployment.
- Data theft and double extortion tactics.
- Potential resale of stolen data on dark web forums.
## Target Sectors
- Energy & industrial sectors
- Financial institutions.
- Technology firms
- Government agencies.
## Notable Campaigns and Incidents
- **Schneider Electric Cyberattack (2024)**: HellCat, in collaboration with the threat actor Grep, compromised Schneider Electric’s internal tracking platform. The attackers stole 40GB of sensitive data, including 75,000 unique email addresses and full names of employees and customers, demanding a ransom of US$125,000 in baguettes.
- **Underground Forum Activity (2024)**: HellCat has been observed selling access credentials to compromised networks, indicating potential Initial Access Broker (IAB) behavior.
## Relationships
- **Conti (2024)**: Some indicators suggest that former Conti ransomware affiliates may have rebranded as HellCat.
- **Black Basta (2024)**: Possible overlaps in ransomware infrastructure, suggesting shared operational tactics.
- **Grep (2024)**: HellCat reportedly collaborated with Grep in the Schneider Electric breach, leveraging access to infiltrate systems and demand ransom.
---
### Tactics, Techniques, and Procedures (TTPs)
#### Initial Access
- Spear-phishing campaigns delivering malicious attachments.
- Exploitation of unpatched vulnerabilities in web applications.
- Credential stuffing and brute-force attacks.
#### Execution
- Deployment of custom ransomware payloads.
- Execution via PowerShell and batch scripts.
#### Persistence
- Use of stolen credentials to maintain long-term access.
- Modification of registry keys and scheduled tasks.
#### Defence Evasion
- Encrypting payloads to bypass antivirus and endpoint detection.
- Disabling security software upon execution.
#### Credential Access
- Harvesting credentials using tools like Mimikatz.
- Exploiting cached credentials from compromised machines
#### Discovery
- Network reconnaissance to identify high-value targets.
- Use of built-in Windows commands for system enumeration.
#### Lateral Movement
- Exploiting RDP and SMB vulnerabilities
- Moving laterally using compromised admin accounts.
#### Collection
- Exfiltrating sensitive corporate and industrial control data.
#### Command and Control (C2)
- Use of TOR and bulletproof hosting for C2 infrastructure.
- Leveraging cloud storage services to transfer stolen data.
#### Exfiltration
- Compressing and encrypting data before transmission.
- Uploading stolen data to dark web leak sites.
---
### Known Exploited Vulnerabilities
- CVE-2023-23397: Microsoft Outlook privilege escalation vulnerability.
- CVE-2024-23897: Confluence Data Center and Server Path Traversal.
- CVE-2024-26083: Java vulnerability allowing RCE.
### Indicators of Compromise (IoCs)

#### File Hashes
- **Ransomware (SHA256)**: d93a45d5e3f4c218a672f8d9b47c46b7e3a9b5c67f88a51e0c27c1e7f5b69a72
#### IP Addresses
- **Known C2 Servers**: 144.202.120.24, 185.101.34.71
#### Domains/URLs
Frequently used domains
- hellcat-leaks.net   
- securedata-breach.info
#### Email Addresses
Known ransom demand contacts:
- support@hellcat-leaks.net
- admin@securedata-breach.info
