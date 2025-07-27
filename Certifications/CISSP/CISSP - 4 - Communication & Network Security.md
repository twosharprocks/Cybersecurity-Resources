2025-04-14 15:23
Status: #seed
Tags: [[CISSP Study]] [[Cyber]]
Reference: 

---
#### **Learning Objectives**

- Understand the role of the ISO OSI 7-Layer and TCP/IP models in internetworking and data communications.
- Describe the architectural characteristics, relevant technologies, protocols, and security threats associated with each layer in the OSI model. 
- Describe the evolution of methods to secure IP communications protocols. 
- Contrast the security considerations of network virtualization with physical networks. 
- Describe key software-defined networking (SDN) concepts. 
- Describe the evolution of and security implications for key network devices. 
- Describe the architecture and design of computer hardware security. 
- Evaluate the security issues and implications of communications in traditional and VoIP infrastructures and of remote computing tools.  

#### **Key Topics**

- Secure Design Principles in Network Architectures
- Secure Network Components
- Secure Communication Channels

---
Communications and Internetworking (Overview)
- Six Basic Questions for Any Task
	- Who needs to send to whom?
	- What needs to be sent?
	- Where are both the sender and recipient?
	- Why do they need to send and receive it?
	- When does it need to be sent and received?
	- How should it be sent?
- Simple Goals in Network Terms
	- Provide reliable, managed communication between hosts (and users)
	- Isolate functions in layers
	- Use packets as basis of communication
	- Standardise routing, addressing and control
	- Allow layers beyond internetworking to add functionality
	- Be vendor-agnostic, scalable, resilient

Telecommuting and Screen Scraper
- Strong VPN connections need to be established between teleworker & organisation, with full device encryption as the norm
- Consider
	- Is the user trained to use secure connectivity software/methods?
	- Does the user know which info is sensitive/vulnerable? Why someone might wish to modify/steal it?
	- Is the physical location appropriate for the work/information?
	- Who else has access to the area?
- Screen scrapers extract information from a display
	- Can be legitimate when older tech doesn't interface
	- Can be used to capture PIN pad sequences on a banking website

Remote Access and Remote Meeting Technology
- Concerns
	- People issues
	- Networks and communications
	- Threat Actors
	- Implementing systems to stay secure

TCP/IP and OSI 7-Layer Models (Overview)
- Layers: Application, Host-to-host transport, Internet, Network Interface
- OSI Layers 
	- 7 Application (Data)
	- 6 Presentation (Data) - Data Representation and Encryption
	- 5 Session (Data) - Interhost Communication
	- 4 Transport (Segments) - End-to-end Connections & Reliability
	- 3 Network (Packets) - Path Determination & IP
	- 2 Data Link (Frames) - MAC and LLC (Physical Addressing)
	- 1 Physical - Media, Signal and Binary Transmission
- OSI Acronyms
	- Please Do Not Throw Sausage Pizza Away
	- All People Seem To Need Delicious Pizza
- Why Use TCP/IP & OSI 7-Layer?
	- Threat modelling around the world use both
	- Focus on applications in data-centric vulnerability modelling/reduction
	- User experiences are focused on connecting to and using applications
		- US leans towards TCP/IP, Europe leans towards OSI 7-layer

Voice Over Internet Protocol (VoIP)
- Session Initiation Protocol (SIP) manages multimedia connections
	- Digest authentication/integrity protection with MD5
	- Also supports encryption (including TLS)
- Good: Security policies can enforce security for meetings/calls, plus recordkeeping
- Bad: Some products use encryption which has been cracked

Network Function Virtualisation (NFV) (aka Virtual Network Function)
- Decouple functions (firewalls, network address translation, IDS, name resolution, ect) away from specific hardware
- European Telecommunications Standards Institute (ETSI) formalised NFV standards
- Benefits:
	- Support transition from CapEx to OpEx
	- Reduce wait time for time-to-market ventures
	- Increase agility of service consumption

802.1X NAC
- Port-based network access control (PNAC) protocol
- Provides authentication control for devices connecting to LANs & WLANs
- Key Elements
	- Detection: Devices attempting to connect
	- Authentication
	- Authorisation
	- Enforcement: Policy-defined security requirements
	- Device Scanning: Check security configuration
	- Onboarding: Set/modify security configuration
	- Termination: Session cleanup after termination
- For Wireless, Device must first authenticate to access point using Wi-Fi Protected Access (WPA)
- Wired devices connect via a switch which provides port-based authentication

Zero Trust vs Trust But Verify
- Trust But Verify: Often seen in SSO environments
	- Network segmentation breaks IT infrastructure into security zones (security tokens to pass between)
- Zero Trust: All processes must be authenticated & authorised
	- Generally uses micro-segmentation (firewalls everywhere)

Converged Protocols
- Blending standardised protocols with specialist solutions
- Can solve problems, can also complicate security and require specialist knowledge

Internet Protocol (IP): Legacy protocol Issues and Internet Relay Chat (IRC)
- original internet protocols were not designed with security as a design goal
- Early protocols had limited authentication
- Many have become more robust, but legacy still lingers
- Internet Relay Chat (IRC)
	- Security Concerns
		- Unencrypted
		- Easy target for sniffing attacks
		- Founded on trust among servers
		- Enables special forms of DoS attacks
		- Common Platform for Social Engineering
	- Authenticity
		- Misleading identity on registration
		- Changing nickname online
		- Manipulating directory service
		- Manipulating attacker or target client to display incorrect identity
		- Social-networking services provide ample opportunity for false identity
	- Confidentiality
		- IRC often transmits in cleartext
		- Info can be disclosed by network sniffing
		- Chat applications can generate illusion/expectation of privacy
	- Scripting
		- Some clients can execute scripts to simplify admin tasks
		- Scripts are an attractive target for social engineering
	- Social Engineering
		- Exploits human nature and good will
	- Spam over instant messaging (SPIM)
		- Deliver pop-up windows that overrun intended processes
		- Recommend service is disabled or only allowed on internal/corporate IM services

NAC Best Practices
- Policy should clearly identify scope of network access
- If Mobile devices are allowed, there should be a Mobile Device Management (MDM) policy and procedures to differentiate between enterprise-owned and ad-hoc devices
- Policy should detail controls such as
	- Encryption
	- Screen locking
	- Antivirus (AV)
	- Firewall settings

Virtual Applications and Desktops
- Citrix, Microsoft, or public domain *virtiual network computing* (VNC) services
- Terminal services allow authentication/authorisation services to be used by remote users

Third party Connectivity
- Org policy onboarding, monitoring, managing and offboarding
- Inventory existing relationships
- Monitoring & auditing access
- Verify removal of IAM privileges and property is recovered

NAC Frameworks
- Cisco's CNAC architecture
	- hardware approach using proprietary technology
- Microsoft's NAP (Network Access Protection) initiative
	- Infrastructure-neutral, software dependent
- Trusted Computing Group's (TCG) standard
	- Completely vendor neutral

Endpoint Security
- Identity management and control
- Configuration management and control
- Device health and status verification
- Behaviour modelling at device level
- Property management and physical security
- Remote management
- Device geolocation

Multimedia Collaboration
- Peer-to-Peer (P2P) Applications/Protocols
	- Uncontrolled channel through network boundary (eg. tunnelling)
- Instant Messaging
	- Three Classes
		- P2P networks
		- Brokered communication
		- Server-oriented networks

Content Distributed Network (CDN)
- Origin Server receives inputs, and makes them accessible to edge servers
- News, entertainment, business - used to reduce impact on internet backbone

Cellular Networks - Physical (OSI Layer 1)
- Endpoint -> Base station -> Relay radio -> Endpoint
- Two transmission types
	- Code-division multiple access (CDMA)
		- Call data encoded and calls transmitted at once
		- Use network-based allowed lists to verify subscribers
		- Phones switched with carrier's permission
	- Global System for Mobiles (GSM)
		- Call transformed into digital data, given channel & timeslot
		- Customer info is kept on a SIM (Subscriber Identity Module)
		- Carrier must accept any GSM-compliant phone
- Wireless Network Generations
	- 1G - Analog
	- 2G - <1Mbps, General Packet Radio Service GPRS, SMS & MMS
	- 3G - <52Mbps, High-Speed Downlink Packet Access, Video calls/mobile internet
	- 4G - <100Mbps, Long Term Evolution (LTE), HD mobile media, web conferencing
	- 5G - <35Gbps, Software-defined networks, IoT, self-driving cars, robot aided surgery

Implications of multi-layer protocols
- Strong benefits of TCP/IP
- Combination of protocols may increase attack surface
- Particularly concerning for Critical Infrastructure
	- MODBUS into system communication (No authentication)
	- MODBUS uses TCP/IP 
- Adoption of TLS to provide secure communications
- Legacy devices are delaying transition to secure comms

Network Virtualisation: Software-Defined Networking (SDN)
- Rapidly changing how networks and constructed/implemented
- SDN advocates push that traditional networking is tech laden, too rigid/slow for agile business needs
	- SDN is repurposing existing infrastructure from device/hardware to virtual and data-centric
	- Deliver services rather than technology
- Abstracting network equipment moved into software-defined network
- SDN allows proactive resilience
- Three layers 
	- Application plane - defines network behaviour
		- Connected to Control with North-bound
	- Control Plane - decides how to implement that behavior
		- East-West
	- Data Plane - carries out those instructions via routers and switches
		- Connects to Control with South-bound
- Software Defined Wide Area Network (SD-WAN)
	- SDN as private network but cloud-hosted
	- Benefits: Minimise on-prem hardware, micro-segmentation, single-point network management

Threat Modelling and Internetworking
- Hazards
	- Not deliberately caused by actor/agent
	- Potential for damage/disruption to information or systems
	- Corrosion, weather damage, fire, smoke, accidents
- Threats - Intent
	- Deliberate actions
	- Purpose is disruption
	- Dealt with system security functions
	- APT Models
		- Unusually high level of technological and operational sophistication
		- Attacks span months/years
		- Conducted by a group
	- APT - Solarwinds
		- Deliberate targeting of US nuclear processes
- Kill Chains
	- Reconnaissance
		- OSINT, Scanning, Early social engineering
	- Weaponisation 
		- Select access technique
	- Delivery
		- Email, USB, URL, ect
	- Exploitation
		- Malware, Rootkits, Exploits, LOTL techniques
	- Installation
		- Install backdoors for persistent access and C3
	- Command and Control
		- Hands-on access
	- Actions of Objectives
		- Exfiltration, data corruption, lateral movement, erase logs, ect

Bound or Wired Media
- Twisted pair - copper wire twisted together to reduce EM interference and cross talk, jacketed by insulator
	- Unshielded Twisted Pair (UTP) - No shielding around twisted pair bundles, susceptible to EM interference and surveillance
	- Shielded Twisted Pair (STP) - Bundles are enclosed in metal foil shield. Better protection but more expensive, bulkier, requires bigger bend radius
- Coaxial Cable (coax)
	- Thick conductor surrounded by layer of insulation, then surrounded by braided grounding wire
	- Thicker than twisted pairs, greater bandwidth, less resistance, better interference protection, more expensive
	- Requires larger bend radius than twisted pairs
	- Robust construction, well suited for specialised applications (eg. cable TV)
- Fibre optics
	- Light pulses through glass/plastic fibre
	- Paired transmitters and receivers tuned for specific frequencies 
	- Pulse-code modulation (PCM) convert electrical impulses to light pulses.
	- Three types
		- Single mode: Small diameter with less internal reflection for long distances (up to 100km)
		- Multimode: Larger diameter, allows less expensive LEDs, good for <2000m (between buildings)
		- Plastic optical fibre: More robust and use less expensive LEDs, limited to 100m (ideal connecting devices in cabinets)

Case Study: TalkTalk
- SQL injection attack to access database of sensitive customer information
- 157,000 customers - names, addresses, DOB, email addresses, credit card info
- Investigated by Information Commissioner's Office, with fines/compensation
- Protecting Network parts
	- Exploited web app vulnerabilities
- Protecting communication channels
	- Unauthorised access to comms channels to intercept customer data
	- Importance of encryption, secure protocols, other protections for data in transit
- Use of layout values in network design
	- Layout values (placement of sensitive databases) played role in attack success
	- Consideration of network design and architecture

Case Study: Target (2013)
- Data breach of personal/financial information of millions
- Unauthorised access by exploiting vulnerabilities in 3rd-party HVAC vendor systems, then navigated to point-of-sale systems
- Importance of securing 3rd party access, network defences/segmentation
- Protecting Network Parts
	- Importance of securing network parts beyond org's immediate control
- Protecting communication Channels
	- Unencrypted communication between central network and point-of-sale
	- Importance of end-to-end encryption for data in transit
- Use of layout values in network design
	- Layout values exploited to move laterally between HVAC to point-of-sale







---
**This reminds me of**... 

---
# Other References
