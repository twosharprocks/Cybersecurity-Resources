# ACPO Guidelines
==Overarching Principle: Preserving Best Evidence and Evidential Integrity
- Don't change Data - No action taken should change data on a digital device
- Be competent - Where necessary to access original data, that person must be competent to do so
- Keep Records - A record of all actions taken should be created and preserved to allow an independent expert to recreate processes
- Responsibility - The Person in charge of the investigation has overall responsibility to ensure the law (and these principles) and adhered to.
## Digital Forensics vs Incident Respnse
There cannot be IR without DF
- Digital Forensics: Expert witnesses, Insider Threats, Regulatory, Court, Litigation, Human Resources, Law Enforcement
- Incident Response: Ransomware, Phishing & Business Email Compromise, Data Theft, Malware, Espionage, Botnets, Denial of Service

## Evidence Handling
- Photograph, Secure, Seize, Continuity, Transport, Acquire

Exhibit Bags
- Always label in capital letters in black ink (ideally ballpoint so it doesn't wash off)
- Secure courier transport

### Case Study
==Challenge==
- Client requests Unit 42 forensically preserve a laptop device that was identified as allegedly being involved in illegal activity related to computer misuse act 1990.
- Given the severity of the offense, client required external support to secure device appropriately.

==Prep 
- Identify device and storage size
- Prepare a suitable acquisition kit
- Identify a suitable location site to perform the forensic acquisition and setup
- Clarify what will happen with the device after acquisition

==Impact
- Device provided to Unit 42 employee in a secure on site location
- Photos, chain of custody document and notes commenced
- Acquisition completed, process comprehensively documented
- Device returned to client in sealed evidence bag

==Results==
Unit 42 acquisition of the device revealed evidence of criminal activity which was subsequently prosecuted. The continuity chain and acquisition processes were examined by the defence and not contested. The police relied upon the acquisition made by Unit 42 and the evidence recovered was used to secure a conviction.

# Importance of Volatile Data
## NIST Incident Response Lifecycle 
- Preparation - Establishing your capabilities, generating your response plans, and securing your system
- Detection & Analysis - Identifying a problem, analysing the attack vector and establish the extent of the incident
- Contain, Eradicate and Recover - Stop the spread, hunt the remove IOCs, begin to return the environment to minimum viable operations and beyond.
- Post-Incident Analysis - What worked? What didn't? What needs to change? How do we improve?

## Order of Volitility
IETF RFC 3227 - 'Guidelines for Evidence Collection and Archiving' 
1. Registers & Caches - CPU Caches, Registers, and Peripheral memory
2. Main Memory (RAM) - Temporary memory used by the system and a first responder goldimine
3. Disks and Virtual Disks - Main storage for a computer device 
4. Backups and Archives

## RAM
- Dump It! Get an acquisition of RAM as early as possible, 
	- Even days later get one anyway
- The nature of acquiring memory means you've having to change it 
	- Write down EVERYTHING
### RAM Capture/Imaging 
- Capture the state of the device: Current user details, current date/time, signs of legitimate encryption, signs of threat actor activity
- FTK Imager

## Collection
### Practicalities - A Good Toolkit
- Data Storage - Have a few spare portable Hard Drives (regular and encrypted)
- Notes Storage - Document your actions verbatim
- Photos/Help - If you can't notepad your actions, photograph them(or better, both)
- Evidence Storage - Keep hold of evidence bags or evidence tape where possible to maintain continuity of evidence items

### Forensic Imaging Basic Concepts
- ==Triage/Live Response Collection==: Quickest acquisition (Quick to obtain/process/analyse), extremely targeted, usually conducted by specialist forensic toolkits
- ==Logical Data Acquistion==: More comprehensive, takes all 'existing' files ad folders, doesn't necessarily allow recovery of deleted data from unallocated space, allows analyst to look at file contents
- ==Physical Data Acquistion==: Most comprehensive, bit-for-bit copy of the drive being examined, slowest acquisition method and slowest to process, may allow recovery of deleted data
# Forensic Acquisition
- Physical Full Disk Acquisition
- Targeted Logical Acquisition
## Physical Acquisition
- Hardware: Target Device, USB Thumb Device (8GB+), External Hard Drive (larger than the target HDD)
- Software: Rufus (WinOS), Paladin Forensic Suite
- Knowledge: How to access the BIOS/UEFI settings, How to boot target device from USB, Decryption Keys (if applicable)

### Paladin Forensic Suite
Preparation
- Download Paladin Edge ISO and Rufus
- Insert a clean USB drive, Launch Rufus, write PALADIN EDGE ISO to USB
- Questions
	- Is Secure Boot enabled in the target BIOS?
	- Can you document and reverse any BIOS modifications?
	- Can you immedaitely access the Boot menu and BIOS settings on the target?
	- Is there any encryption such as BitLocker?
	- Do you have the recovery key or password for an encrypted drive?
	- Do you have a power cable for the target device?

Start Paladin
	- Toolbox Icon -> Attach storage (Disk Manager)
	- Imager Setup: Select "Imager", Attach evidence storage (Disk Manager)
	- Select Source
	- Image Type: Select "EWF (EO1)" for security and compatibility
	- Select Destination
	- Label: Specify the name of the evidence item (IMPORTANT)
	- Verify after creation (Enable to generate hash values)
	- Segment Size: Recommend 4GB (4096)
	- Additional Imager: Enable to allow Paladin to write to a 2nd evidence storage drive (If used, recommend writing to two separate drives)
	- Hit Start

## Windows Forensics Artefacts
- ==Windows Forensics Artefacts==: Application Execution, File and Folder Knowdlege, External Device Usage, Network Activity
- ==Event Logs==: Event Log Location, Timeline Creation, Notable Event IDs

### Application Execution
- Which executables have been run?
	- When were they run? By who?
- Prefetch 
	- Prefetch files (.pf) store file and directory info referenced by an application within 10 seconds of when the application is first run in order to improve system performance
		- Applications known to have run on the host
		- Date & Time of last application execution
		- Date & Time of previous executions
		- Files and device handles referenced by the application
	- Location - C:\Windows\Prefetch
	- Prefetch must be enabled on the host to generate prefetch files (not enabled by default)
	- Prefetch Tools
		- PECmd (Zimmerman tool)
			- Powershell: .\PECmd.exe -d pf-file-directory --csv output-directory --csvf CSV-filename 
		- WinPrefetchView (Nirsoft)
- AMcache
	- Monitors installed applications, executed programs, drivers loaded, ect
	- Records SHA1 hashes of executables and drivers
	- Location: C:\Windows\AppCompat\Programs\AMcache.hve
	- Amcache should not be used as evidence of application execution
	- Tools
		- RegRipper - GUI tool
		- AMcacheParser.exe - Command Line
			- .\AmcacheParser.exe -f filepath --csv csv-output-filepath
- Jump Lists 
	- Record information about frequently used and recently accessed files and applications
	- Locations
		- C:\Users\[username]\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations
		- C:\Users\[username]\AppData\Roaming\Microsoft\Windows\Recent\CustomDestinations
	- Tools: JumpList Explorer
- Shimcache
	- Application Compatibility Cache detects if an application needs additional compatibility requirements to run
	- File path of applications, last modification date of executable
	- Location: C:\Windows\System32\config\SYSTEM
	- Info available from the Shimcache will differ between versions of Windows, ie. the execution flag is not available on Windows XP and below.
	- Tools: AppCompatCache Parser (Zimmerman tool)

### File and Folder Knowledge
- Recent Files
	- Registry key to track files and folders that have been recently opened and is used to populate 'recent' lists on Windows menus
	- Tools: Registry Explorer, Registry Viewer (Windows built-in)
- LNK Files
	- .LNK (shortcut) files are automatically created when a user opens a file or folder
	- Location: C:\Users\[username]\AppData\Roaming\Microsoft\Windows\Recent
	- Tools: LECmd (Zimmerman tool)
- Shell Bags
	- Contain the folder names and paths of folders accessed using the local host
	- Folder names and paths only
	- Tools: ShellBags Explorer (Zimmerman tool)
- Recycle Bin
	- Stores 'deleted' files and folders with subsequent metadata
	- Exists per volume and user, so does not store deletion elsewhere
	- Location: C:\$Recycle.Bin
	- Tools: RBCmd (Zimmerman tool)
- External Device Usage
	- Connection timestamps are recorded when USB devices are connected
	- USB connection timestamps, device serial number, last removal timestamp
	- Timestamps are in the local timezone
	- Tools: USBDView, Registry Explorer
- Network Activity
	- Tracks networks that local host connected to
	- Tools: Registry Explorer
		- SYSTEM\CurrentControlSet\Services\tcpip
		- Previous network connection information
	- SRUM
		- System Resource Usage Monitor (SRUM) records 30-60 days of historical system performance (
		- Records applications run, user interaction, network activity
		- Only recorded hourly, only available on Windows v8 and newer
		- Location: C:\Windows\System32\SRU\SRUDB.dat
		- Tools: SrumECmd (Zimmerman tool)

- Windows Event Logs
	- Separated into different log roles and record wide range of events that occur on a Windows host
	- Tools: EvtxECmd (Zimmerman tool)
	- Notable Event IDs
		- 4624 - Account was successfully logged on
		- 4625 - Account failed to logon
		- 4648 - Logon was attempted using explicit credentials
		- 4672 - Special privileged assigned to a new logon
		- 4720 - User account was created
		- 4722 - User account was enabled
		- 4724 - Attempt was made to reset an accounts password
		- 4728, 4732, 4756 - Group membership changes
		- 4624 (Type 10) - An account was successfully logged on via RDP
		- 1149 - User authentication succeeded via RDP
		- 21 - Remote Desktop Services Session logon succeeded
		- 24 - Remote Desktop Services Session disconnection
		- 25 - Remote Desktop Services Session reconnection
		- 7045 - New service creation
		- 4697 - New service installed in the system
		- 4698 - Scheduled task created
		- 4104 - Powershell ScriptBlock Logging

## Virtual Machines (VMs)
Common Platforms
- VMware
	- vSphere
	- ESX
- Microsoft
	- Hyper-V
- Proxmox
	- Proxmox Virtual Environment (PVE)
- Citrix
	- Citrix Virtual Desktop Environment

### VM Isolation
- Reduce the risk of compromising through lateral movement and collection of evidence
- Methods: Network isolation, Suspension of virtual machine, and Power Off (Last Resort)

### VM Preservation
- Suspend/Hibernate
- Clone/Snapshot
- Image/Copy

# Isolation and Preservation of Cloud Environments
Primarily: Microsoft Azure and Amazon Web Services (AWS) 
	Also Google Cloud to a lesser extent
- Most cloud incidents are the result of misconfiguration of identity management

AWS - Shared responsibility model for security.
- AWS Security Hub, Cloudtrail (logs), GuardDuty (specific rule alerts)
- Isolation and Preservation of EC2 instance
	- Create two subnets
	- Deploy analysis

Azure - Multi-layered security model
- Azure Security Centre, Azure Monitor (Alerts and Review), Azure Sentinel (Cloud SIEM)
- Isolation and Preservation of Azure instance
	- Navigate to Azure portal
	- Network Security Group
		- Create deny-all rule and attach it to the compromised VMs NIC

GCP - Multi-layered security model, protect data at-rest/in-transit/in-use
- Security Command Center, Cloud Logging, Cloud Monitoring
- Isolation and Preservation of GCP Compute Engine
	- Create separate VPC
	- Create subnet (isolation)
	- Create firewall rule