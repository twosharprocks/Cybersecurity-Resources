2025-07-08 16:37
Status: #seed
Tags: [[Cyber]] [[CISSP Study]] [[Pete Zerger CISSP 2024 Addendum - Study Notes]]
Original: https://youtu.be/_nyZhYnCNLA?si=uoCYdI18S80pvj98

---
# Strategies
How to think like a manager (Due diligence vs due care)
- Due diligence: Practicing the activities that ==maintain== the due care effort
	- Research, planning, eval
	- Increases understanding and reduces risk
	- Think before you act (Do Detect)
	- Laws & regs
- Due Care: ==doing== what a reasonable person would do in a given situation (*prudent man rule*)
	- Implementation, operation, reasonable measures
	- Actions louder than words
	- Do Correct
	- Reporting incidents
- Together they reduce management's risk
- Think like a CISO: You are there to advise, not touch

- OSI: Please Do Not Throw Away Sausage Pizza
- Incident Management Framework (DRMRRRL)
	- Detection, Response, Mitigation, Reporting, Recovery, Remediation, Lessons Learned

# Domain 1 - Security & Risk Management
- Understand risk & apply risk analysis process
- Threat modelling
- Compliance, legal, regulatory, and privacy
- Professional ethics
- Security governance (ITIL, oversight)
- Security policies, standards, procedures and guidelines

Know the CIA Triad: 
- Confidentiality 
- Integrity 
- Availability

ISC2 code of ethics
1 - Protect society, the commonwealth, and infrastructure
2 - Act honourably, honestly, justly, responsibly, and legally
3 - Provide diligent and competent service to principles
4 - Advance and protect the profession

Security policy Development (4 levels)
1 - Acceptable use policy: Assign roles & responsibilities
2 - Security baselines: Minimum levels
3 - Security Guidelines: Offer recommendations
4 - Security procedures: Detailed step-by-step

When developing new safeguards, you are establishing a new baseline *so compliance with the existing baseline is NOT a valid consideration*

Risk Categories: Damage, Disclosure, Losses
Risk Factors: Physical Damage, Malfunctions, Attacks, Human Errors, App Errors

Security Planning
- Strategic: 5 yearly
- Tactical: yearly
- Operational: monthly/quarterly

Response to Risk
- Acceptance - Do nothing
- Mitigation (Risk reduction) - involves residual risk
- Risk Assignment (Transferrance)
- Avoidance - Change approach to remove risk 
- Deterrance
- Rejection - Ignore it

Primary Risk Management Framework: NIST 800-37
- 7 steps: Prepare, Categorise, Select controls, Implement controls, Assess controls, Authorise the system (accept risk), Monitor controls
	- PCSIAAM: People Can See I Am Always Monitoring
- Not every risk can be mitigated
- Management's job to decide how risk is handled
- Human safety is always first priority & most important
- When legal issues are involved "Call an attorney" is a valid choice

Risk Types
- Residual - What's accepted (AFTER)
- Inherent Risk - Without Controls (BEFORE)
- Total Risk - Risk without controls (WITHOUT)
	- Total risk = threats x vulnerabilities x asset value
	- Risk = threat x vulnerability

Risk Analysis
- Quantitative: Dollar value on effectiveness (OBJECTIVE)
	- 6 steps to risk analysis:
		- 1. Inventory & assign value ==AV==
		- 2. Identify threats - Exposure Factor ==EF== & Single Event Expectancy ==SLE== 
		- 3. Threat analysis - calculate likelihood in a year with ==ARO==)
		- 4. Estimate potential loss - calculate the annualised loss expectancy ==ALE==
		- 5. Research countermeasures for each threat - calculate changes to ==ARO== & ==ALE==
		- 6. Perform cost/benefit analysis for each countermeasure

- Qualitative: Scoring system to rank threats (SUBJECTIVE)
	- Guess work and opinions
	- Delphi Technique: Anonymous feedback and response
	- Loss potential: loss if threat agent successfully exploit vulnerability
	- Delayed Loss: Loss can occur over time
	- Threat Agents: 

Formulas - [Extra review video (20mins)](https://youtu.be/ttOKJYOedNo?si=UTglalHpe463xakc)
- Exposure Factor ==EF==: *Percentage* of loss by realised risk
- Single Loss Expectancy ==SLE==: Represents *cost* associated with *single* realised risk against specific asset
- Annualised Rate of Occurance ==ARO==: *Expected frequency* of occurrence in a single year
- Annualised Loss Expectancy ==ALE==: *Yearly cost* of all realised risk on specific asset
- Safeguard Evaluation: mitigate risk, transparent to users, difficult to bypass

SLE = AV x EF 
- eg. $200,000 building x 50% damage (0.5) = $100,000 single loss
ALE = SLE x ARO 
- eg. $200,000 building x 0.5 x 10% hurricane prob (1 in 10 yr) = $10,000 (max value of safeguard)
ALE = AV x EF
Safeguard value = ALE before (ALE1) - ALE after (ALE2) - Annual safeguard cost (ACS)

Total Risk - Controls gap = residual risk

Supply Chain 
- On-site assessment
- Document exchange and review
- Process/policy Review
- Third-party audit

Threat Modelling
- Proactive or reactive
- Models
	- Asset valuation
	- Attackers goals
	- Potential threats to software
- Stride (by Microsoft) - Software threats
	- Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege
- PASTA - Countermeasures based on Asset Value
	- Objectives, scope, Decomposition Analysis, Threat analysis, Vuln Analysis, Attack model/sim, Risk analysis & Management
- VAST - Agile-programming environment
	- Visual, Agile, Simple Threat
- DREAD - 5 questions
	- Damage Potential, Reproducibility, Exploitability, Affected Users, Discoverability
- TRIKE - Open Source process implements a requirements model
	- Assigned risk is acceptable to stakeholders
- COBIT - Control Objectives for Information and related Technology (security control framework)
	- Meet stakeholder needs
	- Covering enterprise end-to-end
	- Apply single integrated framework
	- Enabling holistic approach
	- Separating governance from management
- Diagramming Potential Threats
- Reduction Analysis - Systems Parts
	- Trust Boundaries (Points where trust changes)
	- Data Flow Paths
	- Input Points (external input)
	- Privileged Operations
	- Details about Security Stance and Approach
- Security Controls
	- Safeguards are proactive
	- Countermeasures are reactive
	- Control Categories
		- Technical (aka Logical)
		- Adminstrative
		- Physical
	- Control Types
		- Deterrent (Discourages)
		- Preventative (Helps stop)
		- Detective
		- Compensating (Options to other existing controls)
		- Corrective (Return to normal)
		- Recovery (more advanced corrective)
		- Directive (support policy compliance)
- Legal and Regulatory
	- Types of Law; Criminal, Civil (contracts, employment), Administrative (Gov agencies)
	- Laws
		- Computer Fraud and Abuse Act (CFAA)
		- Federal Sentencing Guidelines
		- Federal Information Security Management Act (FISMA)
		- Copyright and the Digital Millennium Copyright Act
	- IP & Licencing: Trademarks, Patents, Trade Secrets, Licencing
	- Encryption & Privacy: Computer & Encryption export controls, US fourth amendment, GDPR
	- Other Laws
		- HIPPA - Health Insurance Portability and Accountability Act
		- HITECH - Health Information Technology for Economic and Clinical Health
		- Gramm-Leach-Bliley Act (Financial Institutions)
		- COPPA - Children's Online Privacy Protection Act
		- ECPA - Electronic Communications Privacy Act
		- CALEA - Communication Assistance for Law Enforcement Act
- Business Continuity Planning
	- Development, Processes, Approval, Implementation, Education
	- BCP - How to continue business (whole business)
	- DRP - How to return IT infrastructure to operation (technical aspects of recovery)
	- COOP - Plan for continuing to do business until IT infrastructure is restored
- Consequences of Breaches: Reputational, ID Theft, IP Theft, Fines
- Notification of Breaches: GDPR within 72hrs

# Domain 2 - Asset Security
Information Lifecycle: Creation, ==Classification==, Storage, Usage, Archive, Destruction

Classification
- Class 0: Unclassified/No Damage, Public
- Class 1: Confidential/Damage, Sensitive
- Class 2: Secret/Serious Damage, Private
- Class 3: Top Secret/Exceptionally Grave Damage, Confidential/Proprietary
Sensitive Data
- Personally Identifiable Information (PII)
- Protected Health Information (PHI) (covered by HIPAA)

Data Destruction
- Erasing (Recoverable), Clearing (overwrite), Purging (for reuse, less secure), Degaussing, Destruction 
- Aware of data retention

Data Owner - Can delegate data duties (senior management)
Data Custodian - Does NOT decide controls needed, but does implement for data owner (day-to-day)
Data Administrators - Responsible for granting appropriate access (RBAC)
User - Anyone who accesses data
Business/Mission Owners - Can overlap with system owner
Asset owners - Owns asset ==and associated security plans==

Data Processor - Processes data on behalf of data controller
Data Controller - Person/Entity that controls data processing
Data Transfer - GDPR restricts data transfers to countries outside EU

Reducing GDPR Exposure
- Anonymisation - Impossible to ID original subject (no longer relevant)
- Pseudonymisation - Pseudonyms to represent data (less stringent)

# Domain 3 - Security Architecture & Engineering
Zero Trust Security: Address limitations of legacy model based on perimeter
- Identity as the control plane, and no identity is trusted by default
- Assume compromise/breach by verifying every request
- Verify Identity, Manage Devices, Manage Apps, Protect Data

Secure Design Principles
- Secure Defaults: Default configuration reflects
- Fail Securely: components should fail to deny access
- Trust but Verify (no longer sufficient): Initial authentication then generic access control within "secure" environment 
- Privacy By Design - 7 principles from IAPP
	- Proactive, Default Setting, Embedded in design, Positive-sum approach (everyone benefits), full lifecycle data protection, visibility & transparency, user-centric privacy (GDPR)
- Keep It Simple - Complexity is the worst enemy of security
	- Best in suite over best in breed (simplify defence-in-depth)
	- Reduces risk of config mistakes (improve incrementally over perfection)
- Security-aaS

Internet of Things (IoT)
- Smart Devices - installing apps and may use in-the-cloud AI

SIEM & SOAR
- SIEM: System that collects data from many sources, provides real-time monitoring, traffic analysis, notification of potential attacks
- SOAR: Centralised alert and response automation (with threat-specific playbooks), response may be fully automated or single-click

Microservices & SOA
- SOA: Creation of discrete services (blackbox)
- Microservices: Fine-grained services with discrete function (Modern adaptation of SOA for coud computing
- Code-Level vulnerabilities be ID'd early in dev lifecycle
	- Static code analysis and dynamic testing in CI/CD to ID vulns BEFORE release

Containerization
- Lightweight portable package app for multiple platforms
- Reduces overhead by enabling containered apps on shared OS kernel
- Similar concerns of server virtualisation: isolation at host, process, network and storage
- Focus is on DevOps security (container-level) and application-level security (AuthN and AuthZ)

APIs (REST)
- Exposed interfaces to allow programmatic interactions between services
- REST uses HTTPS between endpoints - encrypted with access limited with API keys

Embedded Systems
- Tech component of an IoT device (full computer system inside larger system)

High Performance Computing
- Alternative to client-server computing model for ops with large data-sets & large-scale parallel processing (eg. SET@Home)
- Grid Computing uses centralised controller to assign computing to grid members

Edge Computing: processing to occur locally (far from cloud)
- Common in IoT like agriculture, science/space, military
- Fog Computing: Gateway device in the field to collect/correlate data centrally at the edge
- Consider data encryption, spoofing protection and authentication for large network-connected devices in various locations

Cloud Computing - CSP (Cloud Service Provider)
- Shared Responsibility
	- IaaS: OS upwards
	- PaaS: Data & Applications
	- SaaS: Just application use (configure features)
- Function-as-a-Service (Serverless): Breaking out individual components of an application
- Cloud Models
	- Public Cloud: All on CSP's hardware (low skill)
	- Private Cloud: Running VMware/Hyper-V, All about control/compliance, legacy support
	- Hybrid Cloud: Best of both, flexibility (run what you need where you need)
- CASB (Cloud Access Security Broker)
	- Security Policy Enforcement solution (installed on-prem or cloud)
	- Solving Shadow IT
- Post-Quantum Cryptography: Use conventional computers but resistant to quantum attacks
	- Symmetric: Key Exchange (bulk encryption (fast)
		- Grover's algorithm - quantum halves key length
	- Asymmetric: Key exchange, digital signatures
		- Shor's algorithm: RSA & Elliptic Curve are vulnerable
		- Lattice (based on shortest & closest vector problems) is resistant

Cryptography
- Code: Sometimes secret but don't always provide confidentiality
- Cipher: Always meant to hide true meaning of message

- Stream Cipher: Symmetric key encrypting one bit at a time
- Block Cipher: Apply algorithm to a block of data
- Substitution: Replace each character with different character (Caesar Cipher)
- Transposition: Rearrange the letters
- Initialisation Vector (IV): Random bit string for encrypting message (cryptographic version of random number)
- Caesar, Vigenere, One-Time Pad
	- Caesar has key length of 1
	- Vigenere uses a word or sentance
	- One-Time Pad uses key as long as the message
		- Must be generated randomly
		- Atleast as long as message
		- Must be protected against disclosure & used only once
- Zero-Knowledge Proof: Prove knowledge of fact without revealing the fact (digital signatures)
- Split Knowledge: Information/privilege separated between people
- Work Function/Factor: Cost/Time/Effort to break protective function
	- Modern crypto uses keys atleast 128 bits long (will increase with quantum)
- Symmetric (Faster): Shared secret key
- Asymmetric (Stronger): Public-Private key pairs (scalability, key distro, nonrepudiation)
- Confidentiality, Integrity, Nonrepudiation

DES
- Electronic Codebook Mode (ECB) - Least secure, processes 64-bit blocks with chosen key 
- Cipher Block Chaining (CBC) - Each block XORed with block of ciphertext preceding it 
- Cipher Feedback (CFB) - Streaming version of CBC, uses memory buffer of same block size. Uses chaining so errors propagate
- Output Feedback (OFB) - Similar to CFB but XORs plain text with seed value (no chaining, no error propagation)
- Counter (CTR) - Uses incrementing counter instead of a seed

Key Clustering: Weakness where plain-text generates identical cipher-text (similar to collision)

Asymmetric Keys
- Public Key: Shared, use recipient's to encrypt a message, validate signature using sender's 
- Private Key: Kept Secret, use own to decrypt, sign message with your own

Hash Functions
- Allow input of any length
- Provides fixed-length output
- Relatively easy to computer hash for any input
- One-way functionality
- Collision free

Digital Signature Standard: Uses SHA-1/2/3 message digest function
- Works in conjuction with Digital Signature Algorithm (DSA), RSA, and Elliptic Curve DSA (ECDSA)

PKI - Certificate Authorities (digital certificates
- Verify using issuing CA's public key

Securing Traffic
- Email: S/MIME and PGP
- Web: Transport Layer Security (TLS) has replaced older SSL
- Network: IPSec
	- Security architecture
	- Transport mode or Tunnel Mode
	- Used between computers or over VPN
	- Uses Authentication Header (AH) or Encapsulating Security Payload (ESP)

Crypto Attacks
- Brute-force
- Meet-in-the-middle: Exploits protoccols using 2 rounds of encryption
- Man-in-the-Middle: Two parties unknowningly communicating with attacker
- Birthday attack: Collission in hash function
- Replay Attack: Reuse authentication request

Digital Rights Management (DRM)
- Enforce restrictions on use of entertainment content

Symmetric Algorithms
- *AES*: Block (128), Key 128/192/256 ==Strong==
- Blowfish: (64), Key 32-448
- DES: Block (64), Key 56, ==Very Weak==
- 3DES: Block (64), Key 112/168, Moderate
- IDEA: (64), Key 128
- RC2: (64), Key 128
- RC4: Stream, Key 128
- *RC5*: RSA Block (32/64/128), Key 0-2040 ==Very Strong==
- Skipjack: (64), Key 80
- Twofish: (128), Key 1-256

Hash Algorithms
- HMAC: Variable, ==Very Strong==
- HAVAL: 128, 160, 192, 224, 256
- MD2-5: 128 (replaced by MD6)
- SHA-1: 160 (not used)
- ==SHA-224, SHA-256, SHA-384, SHA-512==

Public Keys Systems
- RSA: Primes
- El Gamal: Replaced Diffie-Hellman, uses modular arithmetic
- Elliptic Curve: Discrete logarithm problem

Security Models - Formalise security policy
- Broad guidelines on enforcing confidentiality, integrity, and availability
- Determines how security is implemented, what subjects can access the system, and what objects/resources the subjects can access

- State Machine Model: based on a baseline state (snapshot), All state transitions must be evaluated
- Information Flow Model: Focus on information flow, based on state machine model
	- Bell-LaPadula: Preventing information flow from high security to low security
	- Biba focuses on the flow from low to high
		- Integrity (no read down, no write up)
- Non-interference Model: Actions of different objects and subjects are not seen by (and don't interfere with) other objects/subjects on same system
- Lattice-based models: Define levels of security an object may have, and subject may have access to.
- Three properties
	- Simple Security: Rules for read
	- Star `*` security: Rules for write
	- Invocation: Rules for calls (to subjects)

- Integrity models
	- Biba: No read down, no write up, Lattice-based, invocation (can't invoke subject at higher level)
	- Clark-Wilson: Access control triple/triplet (subject, programs/transformer, data items/object), uses labels, un/constrained data items
	- Goguen-Meseguer: non-interference model
	- Sutherland: prevent interference (info flow & State Machine concept)
- Confidentiality Models
	- Bell-LaPudula: uses MAC, No read up, star property (no write down), used in government (DoD)
	- Brewer and Nash: "Chinese Wall" (prevent conflict of interest)
	- Take Grant: Directed Graph, Take/grant/create/revoke

- Graham-Denning Model: Secure creation/deletion of subjects & objects. 8 primary protection rules
	- 1-4: Create/delete object/subject
	- 5-8: Provide read/grant/delete/transfer rights

- Trusted Computing Base: Combination of hardware, software & controls that work together to form a "trusted base" to enforce security policy
	- Must create secure channels ("trusted paths") to communicate with the rest of the system
- Security perimeter: Imaginary boundary to separate TCB from rest of system
- Security kernel implements access control
- Reference monitor enforces access control

- ==Common Criteria==: Objective evaluation to defined set of security requirements
	- 5 step: Describe assets -> ID Threats -> Analysis/Rating Threats -> Determine security objectives -> Select Functional requirements (and repeat)
	- Evaluation Levels
		- EAL0/1: Functional Tested
		- EAL2: Structural tested
		- EAL3: Methodically tested/checked
		- EAL4: Methodically designed/tested/checked
		- EAL5: Semi-formally designed/tested
		- EAL6: Semi-formally verified design/tested
		- EAL7: Formally verified design and test
- Trusted Computer System Evaluation Criteria (TCSEC): Structured set of criteria for evaluating security within products/systems
- Information Technology Security Evaluation Criteria (ITSEC): European

- Covert Channels: Communication not normally used & not protected 
	- Covert timing: 
	- Covert Storage: Steganography, Ping

Trusted platform Module: Chip on the motherboard providing keys

Access Control
- Mandatory Access Control (MAC): Determined by system, classification labels (every object has classification)
	- Hierarchal, Compartmentalised, Hybrid
- Discretionary Access Control (DAC): Owner/Creator controls/defines accessibility
- Non-Discretionary Access Control: Enforcement of ==system-wide== restrictions to override object-specific access control
- Rule-based Access Control: Defines specific functions for requested object access. Commonly found in firewall systems
- ==Role-based Access Control==: Well defined collection of named job roles with specific permissions

MFA: Something you have, something you know, something you are
Authentication (AuthN): Proving you are who you say you are
Authorization (AuthZ): Granting authenticated party permission

Multitasking: Multiple processes
Multithreading: Multiple tasks within processes
Multiprocessing: Multiple processors
Multiprogramming: Multitasking on mainframe systems

Single/Multistate: Number of security modes they can operate in
User processor operating mode: Limited instructions
Privileged processor operating mode: Kernel access

Memory Types
ROM: Burned at factory
RAM: S(tatic)RAM uses flip-flops, D(ynamic)RAM uses capacitors
PROMs
- EPROM: Programmable chip allows erasing/clearing
	- UVEPROM - Ultraviolet
	- EEPROM - Uses electric voltage
	- Flash - Electronically erased/written EEPROM

Firmware: Stored on a ROM chip to start a device
Hyperviser
- Type I (Baremetal)
- Type II (hosted)

CASB - Enforcing approved cloud access policies (prevent shadow IT)

Functional Order of Security Controls: Deter, Deny, Detect, Delay, Determine, Decide

*Administrative controls*: Facility construction/selection, site management, personnel controls, awareness training, emergency response/procedure
*Physical controls*: fencing, lighting, locks, construction materials, mantraps, dogs, guards (No security without physical security)

Physical Security Controls
- Fencing (8ft+barbed)
- Temp: 40-60% humidity (too low is static, too high is corrosion), temp 60-75F (15-23c), damage at 175F, storage damage at 100F
- Power
	- Blackout: Prolonged loss
	- Brownout: Prolonged low volt
	- Fault: Short loss
	- Surge: Prolonged high volt
	- Spike: Temporary high volt
	- Sag: Temporary low volt
- Lights: 8ft high & 2 candles

Fire Fighting
- Class A (Ash): Common combustibles (water or soda)
- Class B (Boil): Burning alcohol/oil (gas or soda acid)
- Class C (Conductive): Electrical fires (non-conductive gas)
- Class D (Dilythium): Burning metals (dry powder)
- Class K (Kitchen): Burning oil or grease (wet chemicals)

Electrical interference
- Common mode noise: Difference between hot & ground wires
- Traverse mode noise: Difference between hot and neutral wires
- RFI: Radio Frequency Interference

NUMBER ONE CONCERN IS HUMAN SAFETY

Preaction systems - Closed sprinkler head (good for people & computers)
Wet Pipe System - Filled with water, flame activated sprinkler at set temp
Dry Pipe System - Filled with compressed air, water held back by valve.
Deluge System - Similar to dry pipe except sprinkler heads are open, held back by deluge valve

Gas Discharge is better than water, but can't be located in same places as people (remove air)
- Halon replaced by FM-200

lock Types: Combination, key card, biometric, conventional (tumbler)

Site Selection: Effects of natural disasters
Facility design: security needed
Secure work areas: High value assets require restricted access that are in centre of protection

Wiring Closets: Physically secure it
Media Storage: Physical security & media sanitisation
Evidence Storage: Chain of custody, physical controls
Audit Trails & Access Logs
Clean power: UPS (consistent power)

# Domain 4 - Communication and Network Security
VXLAN - Virtual Extensible LAN
- Scaling network segmentation at high scale, overcomes VLAN limit of 4096
- Uses tunnelling protocol that encapsulates ethernet frame (layer 2) in a UDP packet

SDN - Software Defined Network
- Separate control plane from data plane (Security challenges)
- Reprogram the data plane at any time
- Used in SD-LAN & SD-WAN
- SDN is secured from MITM with TLS

SD-WAN - Software Defined Wide-Area Networks
- Remote connect to enterprise network for branch offices
- Enables many network services (LTD, Broadband, ect) to connect to apps
- Security based on IPsec, VPN tunnels, next-gen firewalls (NGFWs) and micro-segmentation of app traffic
- Uses centralised control for intelligent routing and SASE (Secure access service edge) to decentralise connectivity

Li-Fi - Light Fidelity (LEDs to transmit data)
- Only requires working LED lights (cannot penetrate walls)

Zigbee (PAN) - Short range personal area network (PAN)
- Used in IoT smart home hub (eg. Alexa)
- Supports centralised & distributed security models
- Assumes symmetric keys are transmitted securely

Celluar Networks
- 5G (no longer needs SIM, can ID each device)
	- Diamter protocol (AAA) will be a target
	- DDos is a concern
	- Old vulnerabilities 

Content Delivery Network - CDN
- Distributed network of proxy servers to deliver content fast
- Spatially relative to users

OSI Model 
	- Please Do Not Throw Sausage Pizza Away
	- All People Seem To Need Data Processing
- 1 - Physical (Bluetooth, 802.11): Device drivers on how to transmit/receive bits
- 2 - Data Link (ARP): Formatting packet from network layer for transmission (frame)
- 3 - Network (ICMP, NAT, IPSec): Routing and Addressing info (packet)
- 4 - Transport (SSL, TLS, TCP/UDP): Managing connection integrity & control session
- 5 - Session (SMB, RPC, SQL): Establish, maintain, control, terminate sessions between endpoints
- 6 - Presentation (JPEG, ASCII): Transforming data from application into format any system can understand
- 7 - Application (HTTP, SSH, IMAP): interfaces user apps, network services, or OS with protocol stack

TCP vs OSI
- Application = Application/Presentation/Session
- Transport = Transport
- Internet = Network
- Link = Data Link/Physical

TCP vs UDP
- TCP (Error detection): Connection oriented, byte stream, No multicast/broadcast, full duplex (bidirectional), Reliable transmission, packet = segment, 
- UDP (Broadcast): Connection-less, message stream, multicast/broadcast, no duplex, unreliable, packet = datagram

Cabling
- Cat1-7 is all unshielded twisted pair, max 100m
- Cat 5, 5e, 6, 6a, & 7

Topologies
- Mesh: All systems connected to all others (redundant connections)
- Ring: Points on a circle, unidirectional transmission loop, one system transmitting (performed by a token) (token ring based)
- Bus: All connected to network backbone/trunk, requires collision detection
- Star: Centralised hub or switch

Analog: continuous signal varying in frequency, wave shape, signal loss over long distance
Digital: Discontinuous electrical signal (on-off binary)

Synchronous: Timing mechanism, high rates of 
Asynchronous: Start and stop delimiter (PSTN modems)

Baseband: Single communication channel with DC to cable (eg. ethernet) (Digital signal)
Broadband: Multiple simultaneous signals with frequency modulation, high throughput when multiplexed (analog signal)

Broadcast: All recipients
Multicast: Specific recipients
Unicast: Single comm to specific recipient

Carrier Sense Multiple Access (CSMA)
- Decrease chance of collisions when 2+ stations start sending signals over datalink layer. Check medium before broadcast
- CSMA/CA (Collision Avoidance - wireless) - Single permission to communicate at given time (before collision)
- CSMA/CD (Collision detection - wired) - Responds after collision by having stations wait random time before restarting

Token passing: Prevent collision in ring networks
Polling: Master-slave config, primary system polls each secondary used by SDLC (layer 2 system)

Network Segmentation
- Intranet: Private network
- Extranet: Sectioned off as intranet and public (B2B)
- DMZ: Extranet for public (Perimeter network)
- Segmentation: Boosts performance, reduce comms problems, provide security

Bluetooth
- IEEE 802.15 (PAN), uses 2.4 GHz radio, four digit code to avoid accidental pairing
- Bluejacking: Push unsolicited messages to engage/annoy
- Bluesnarfing: Wireless Data Theft
- Bluebugging: Remote control

SSID Broadcast: Announces with a beacon frame, hiding SSID is not secure

TKIP - Temporal Key Integrity Protocol
- Implemented under name WPA
CCMP - Counter Mode with Cipher Block Chaining Message Authentication Code Protocol
- Created to replace WEP & TKIP/WPA
- Usues AES (128-bit key)
WPA2 (uses CCMP)

Fibre Channel - Network Data Storage or Network Attached Storage
Fibre Channel over Ethernet - Encapsulation for access over Ethernet
- VERY fast

iSCSI - Internet Small Computer System Interface
- Network storage standard based on IP

Site Survey - Survey of presence, strength, reach of wireless access points (mapping signal strength)

EAP/PEAP/LEAP
- EAP: Extensible Authentication Protocol (Authentication framework)
- PEAP: Protected EAP (Encapsulated EAP in TLS tunnel)
- LEAP: Lightweight EAP (Cisco Proprietary)

MAC Filtering - List of authorised wireless clients

Captive portals - Redirects wireless web client to portal access control page (Hotel login)

- Firewall: Manage/control network traffic by filtering
- Switch: Repeats traffic out of port where destination is known (generally layer2, sometimes layer 3)
- Router: Control flow on network to connect similar networks (layer3)
- Gateways: Connecting different network protocols (aka protocol translators) (layer3)
- Repeaters/Concentrators/Amplifiers - Layer 1
- Bridges: Connect two networks (layer 2)
- Hubs: Connect multiple computer systems, multiport repeater (used in homes)(layer 1)
- LAN Extenders: Multilayer switch to connect two LANs to create a WAN
- WAN
	- Private circuit: dedicated physical circuits (ISDN, DSL)
	- Packet-Switching: Virtual circuits (SDLC, ATM)

Firewalls
- Static Packet-Filtering: Examines message header (Layer 3+)
- Application-Level: Single service, protocol, application (Layer 7)
- Circuit-level: Communication between trusted partners (layer 5)
	- eg. SOCKS
- Stateful: Evaluates state, session, context of traffic end-to-end
- Stateless: Block on source/destination or other static values (good for heavy loads)
- Deep packet: Application layer to filter on both header & payload

- Web Application Firewall (WAF): Filter/monitor HTTP/S traffic
	- protects web apps from XSS, CSRF, SQL injection
- NextGen(NGFW): Deep packet inspection, app-level inspection, intrusion prevention, intel from outside
- Unified Threat management: Multifunction device include IDS/IPS, TLS proxy, web filter
	- More used in small-medium business (doesn't scale)
- Network Address Translation (NAT) Gateway: Allows private subnets to communicate with cloud but hides internal network from internet
	- Network Access Control List for private subnets
- Content/URL filter: Looks at content based on filters (deep packet inspection)

- Application: Generally web traffic, example is NGFW)
- Host-based: Installed on OS
- Virtual: Virtual network appliance (from CSP & third-party)

IDS: Logs & alerts,
IPS: Logs, alerts, takes action
- Behaviour-based (baseline, protects zero-day), knowledge-based (signatures, only known attack methods)
HIDS (Host-based) & NIDS (Network-based)
Inline (in-band): NIDS/NIPS on or near firewall
Passive (out-of-band): Traffic does not go through it

Secure network Design
- Bastion Host; Exposed to internet & hardened by removing all unnecessary services/programs/protocols/ports
- Screened Host: Firewall protected (more secure than bastion)
- Screened Subnet: Subnet placed between two routers, with Bastion on that subnet
- Proxy: Requests functions on behalf
- Honeypot: Entice, not entrap. Download fake payroll file is entrapment
	- Goal is to distract from real assets and isolate while you track/respond
	- Honeynet: Netowkr for same purpose

Attacks
- Teardrop: DoS sending fragmented packets 
- Fraggle: DoS with spoofed UDP traffic
- Smurf: DoS with spoofed ICMP traffic
- Land Attack: Layer 4 DoS with source/destination of TCP segment are same value (repeatedly processed by TCP stack til crash)
- SYN Flood: Succession of SYN requests (No TCP handshake)
- Ping-of-Death: Over-sized ping packet (greater than 65,536 bytes)

# Domain 5 - Identity and Access Management
Digital certificates: authenticate users, service, device
- Generally issued by a CA in public key infrastructure (PKI)
- Uses symmetric and asymmetric encryption

AAA - Authentication, Authorisation, Accounting
- RADIUS: Remote access (UDP, encrypts password only)
- TACACS+: Admin access to network devices (TCP, encrypts entire session)
- Diameter: 4G, based on RADIUS & major improvement but not compatible with RADIUS
- Kerberos: Authentication (used in AD) to prove identity
	- Confidentiality & integrity, no logging (no accountability)
	- Attacks: Replay, pass-the-ticket (NTLM), golden ticket, kerberoasting

Need to know: Access only if they need it to perform a job
Least Privilege: Same but includes rights to act on other systems
- Just-in-time (JIT): PIM, PAM
Separation of Duties/Responsibilities: Sensitive tasks split between two+ employees

Identification: Claims ID
Authentication: Proves that ID
Authorisation: Access based on proven ID (authentication)
Accountability: Auditing logs/trails to record events of ID actions

MFA: Know (PIN/Password), Have (Trusted device), Are (Biometric)
- Biometrics: Fingerprint, Retina, Iris, Voice, Facial, Vein, Gait
- Crossover Error Rate (CER) - Accuracy
	- False acceptance rate (FAR): Invalid subject is authenticated (false positive - Type 2)
	- False Rejection Rate (FRR): Valid subject rejected (false negative)

Single Sign-on: 
- SAML: Security Assertion Markup Language (XML-based), ID provider
- OAuth 2.0: Microsoft, Google, Facebook (does not expose password)
- OpenID: Decentralised to log in with one set of credentials

Access Control Models
- Discretionary Access Control (DAC): Owner controls access
- Role based Access Control (RBAC): mapped to job roles
- Rule-based Access Control: Global rules for all subjects (firewalls/filters)
- Attribute Based Access Control: Multiple attributes, more flexible than rule based
- Mandatory Access Control (MAC): Relies on labels for subjects and objects (lattice based model)

Security Controls
- Categories
	- Logical/Technical - Hardware/Software to manage access
		- Encryption, smart cards, passwords, biometrics, access control lsits, firewalls, routers, IDS, clipping levels
	- Physical - Facility & Real-world objects
		- Guards, fences, motion detectors, lights, locked doors, cable protection, swipe cards, dogs, cameras, mantraps, alarms
	- Administrative - Policies and Procedures to implement/enforce access control
		- policies, procedures, hiring, background checks, classification, training, vacation, reviews, work supervision/rotation
- Types
	- Preventative (Primary) - Stop unauthorised activity
	- Detective (Primary) - Discover activity
	- Corrective (Primary) - Restore systems after unauthorised activity
	- Deterrent - Discourage unauthorised activity
	- Compensation - Provides options to existing controls
	- Directive - Direct, confine, control actions of subjects
	- Recovery - Repair or restore (more advanced than corrective)

Risk: Possibility/likelihood a threat can exploit vulnerability

Access Control Attacks
- Dictionary
- Brute force: Try all possible words
- Spoofed logon screen
- Sniffer attack: Packet-capturing tool
- Spoofing Attack (generally phishing)
- Social Engineering (user education)
- Phishing
	- Spear-phishing: Targeted specific users
	- Whaling: high-level execs
	- Vishing: Voice over IP
- Access aggregation: Combines non-sensitive info to learn sensitive info (recon attacks)

Preventing Attacks
- Long, complex and changed passwords & account lockout
- Have secure endpoints to avoid fake logons

Other Attacks
- Tempest - Reading monitor info from EM radiation (CRT monitors)
- White Noise - False traffic to hide 

RFID, Barcoding & Inventory - To prevent theft (reduce risk)

# Domain 6 - Security Assessment and Testing
Security Assessment and Testing
- Validate ==ongoing== effectiveness of security controls
	- Vulnerability assessments
	- pen testing & software testing
	- Audits
	- Security management task
- Every organisation should have a ==defined and operational== security and assessment testing program 

- Vulnerability Assessments: Use automated tools to find known vulnerabilities
- Penetration Tests: Same tools supplemented with attack techniques
	- Assessor attempts to exploit vulns to gain system access
- Tests that involve human interaction will increase cost

Security Process Data
- Write Policy - Employment policies/ practices: background checks, termination
- Communicate Policy - Roles and responsibilities: Set by management
- Train policy Security Awareness Training: Prevents social engineering, helps phishing

Software Testing - Verifies code functions as designed
Code Review - Peer review to validate code before deployment
Interface Testing - Interactions between components

Static Software Testing: Code reviews, evaluate software without running it (source code or compiled application)
Dynamic: Evaluate in a runtime environment
Fuzzing: Modified inputs to test under unexpected circumstance
- Eg. SQL injection

Security Management Oversight - Proper oversight of infosec program
- Log Reviews - systems are not misused
- Account management reviews - Only authorised users retain access
- Backup verification (MOST IMPORTANT) - Ensure data protection is functioning properly
- Key performance and risk indicators - High-level review of security program effectiveness

Internal and External Audits
- Security Audit - 3rd party performs security assessment
	- Assume any "audit" is a 3rd party audit
- Internal Audit - Internal staff for management use (preparation for 3rd party audit)

# Domain 7 - Security Operations
- Next Gen Firewalls (NGFW) - Deep-packet inspection, introduces threat feeds from external
- WAFs - protect web apps from XSS, CSRF, SQLi
- User and Entity Behaviour Analytics - Entity behaviour collected and input into a threat model
- Threat intelligence - feed used by org to educate about changes in threat landscape
- AI & ML - Critical for analysing millions of events
	- Develop history of behaviour profiles to establish deviation from norms

Limiting Access & Damage
- Need to know & least privilege - prevent issues and limit impact

Preventing Fraud & Collusion
- Separation of duties - Prevents one person doing all of a critical function
- Job rotation - Rotating into different jobs to prevent/flush out fraud
- Monitor privileged operations - Ensure trusted employees do not abuse special privileges (also monitor as many attacks use this)

Lifecycle
- Creation
- Classification
- Storage
- Usage
- Archive - Retention
- Destruction - Not readable

Service-level Agreements - Stipulate performance expectations
Secure provisioning - Deployed and maintained in secure manner 
- Deploy PC from a secure image

Virtual Assets 
- VMs, VDI, Software-defined networks, virtual storage area networks
- Primary component & target is Hypervisor
- Cloud increases risk, protect data depending on value
- Shadow IT is an issue with cloud (use CASB to flush out)
- Cloud Service Provider (CSP) - Least amount of maintenance & good security

Configuration & Change Management
- Similar configs that are known and documented
- Baseline - ensure systems are deployed with a common baseline
- Change Management - Reduce outages from unauthorised changes
- Versioning - Labelling/numbering system to track changes
- Requires changes to be requested, approved, tested, and documented

Patch/Update Management - Ensure systems are kept up-to-date
- Evaluate, test, approve and deploy
- System audits to verify deployment
- Intertwine change and config management to ensure changes are documented
- Orgs without patch management will experience outages from known issues that could have been prevented
- Patch Process: Evaluate, Test, Approve, Deploy, Verify
	- Vuln scanner to identify missing patches

Vulnerability Management
- Routine vuln scans and periodic vuln assessments
- Scanners: Detect vulnerabilities and absence of patches
- Assessments: Extends beyond scans and includes reviews & audits

Incident Response
- Detection - Monitoring tools, IPS, firewalls, notify help desk
- Response - Triage (Decision to declare), limit damage
- Mitigation - First containment effort, create team
- Reporting (management) - Relevant stakeholders (customers, vendors, law)
- Recovery (management) - Return to normal operations 
- Remediation - Root cause addressed, root cause analysis
- Lessons Learned - prevent recurrence, improve IR Process

Denial of Service Attacks
- SYN Flood - TCP three-way handshake
- Smurf Attack - Amplify responses to send numerous packets
- Ping-of-Death - oversized ping packets

Honeypot - Lures and distracts so admins can observe. 
- "Padded cell" after detection

Blocking Malicious Code
- Layered defence, defence-in-depth
- Use together: Anti-malware, Policies (least privilege), education

Pentests
- Discover vulnerabilities and then mimic attack. Done on isolated systems whenever possible.
- Black box, white box, grey box

IDS vs IPS Response
- IDS - passively log behaviour
	- HIDS - Host based (single system)
	- NIDS - network based, not as visible to attackers
- IPS - inline with traffic and has ability to block

Espionage - External source attacking
Sabotage - Insider threat
Zero-day exploit - vulnerability not known publicly

Log Files
- Common log files (security, system, app, firewall, proxy logs) should be protected and archived as read-only to prevent modifications

Monitoring - Auditing subjects & system performance
- IDS or SIEMs automate real-time analysis

Audit Trails - Detective control, extracts info about incident to prove/disprove culpability, essential for prosecution

Sampling - Extracting elements
- Statistical - Mathematical
- Clipping - Non-statistical over a specific threshold

Due Care - management acting with common sense, prudent management, responsible action

Regularly Audit Access controls

Crime 
- Military, business, financial, terrorist, grudge, thrill
- eDiscovery - evidence identification & governance, evidence preservation/collection, process/review/analysis, production & preservation (Data Custodian)
- Gathering evidence - Possess without modification
- Voluntary surrender, subpoena, search warrant

Evidence
- Best (Original/Real)
- Secondary (Copy)
- Direct (proves based on 5 senses)
- Conclusive - Incontrovertible
- Circumstantial - Inference
- Corroborative - Supporting but can't stand on own
- Opinions - Expert and non-expert
- Hearsay - Not based on first hand knowledge

Evidence types - Real, Documentary, Testimonial
To be admissible - Relevant, material, competently collected

Natural Disasters - Earthquakes, Floods, Storms, Tsunamis, Volcanic eruptions

Man-made - Explosions, Electrical fires, Terrorist acts, power outage, utility failures

Recovery Sites
- Cold - data centre space, power, network connectivity
- Warm - Preventative, pre-installed and pre-configured
- Hot - Proactive, live backup site

Service Bureau - Lease computer time (on-site or remote)
Mobile Site - Self-contained trailers
Multiple Sites - mix & match

RPO - Recovery Point objective (age of files to be recovered)
RTO - Recovery Time Objective (duration of time & service level before unacceptable)

Mutual Assistance Agreement - provide support between orgs for disaster recovery sites (difficult to enforce)

BCP - Business Continuity Planning - enhance ability to recover
- 1. Scope and Planning
- 2. Business Impact Assessment
- 3. Continuity Planning
- 4. Approval & Implementation

COOP - Continuity of Operations Plan (keep doing business until restored)
DRP - Disaster Recovery Plan (recover from disaster)
BRP - Business Resumption Plan
MTBF - Mean Time Between Failures
MTR - Mean Time to Repair
MTD - max Tolerable Downtimes

DR & BCP - Improve responsiveness, ease confusion, make logical decisions
- Read-through test - Review DRP
- Structured (Tabletop) - Roleplay scenario
- Simulation - Walkthrough response measures
- Parallel - Relocate to personnel to alt recovery site
- Full Interruption - Actually shutdown operations at primary site

Recovery Team - Critical business functions at alt site
Salvage Team - Recovery at original site

Backups
- Electronic Vaulting - Transfer to remote site
- Remote Journaling - Transmit journal/transaction logs to off-site
- Remote Mirroring - Live database server maintained at backup site

Disruption Categories
- Non-disaster - Disruption of service from device/user error
- Disaster - Facility unusable for a day or longer
- Catastrophe - Disruption destroys facility

# Domain 8 - Software Development Security
Code Repository Security 
- Don't commit sensitive info,
- Protect access
- Sign your work
- Keep IDE up-to-date

Code Libraries can improve security

Devops and Devsecops
- Runtime - period software is running (DAST - Dynamic app security testing)
- Best practice is source code and runtime scans
- Containers - Scan at build AND runtime

CI/CD - Continuous Integration, Continuous Delivery
- Implement MFA
- Store secrets securely (no hard-coded)
- Least Privilege RBAC access
- Automate vuln scanning in CI/CD pipeline
- Release versioning

Configuration Management
- Software Configuration Management - Baselining (snapshot), create artifacts, system/component level versioning

Code Scanning
- Static: Tester has access to source code
- Dynamic: Executes the application (no source code)

Relational Database Management Systems
- Tables - Relations
- Rows - Record/tuples (data record)
- Columns - field/attributes
- Candidate Keys - Unique identification for a record (employee ID)
- Primary Keys - One per table, set by designer
- Foreign keys - Referential integrity (relation between two tables)
- Threats
	- Aggregation - Combine non-sensitive info from separate sources to create sensitive info (troop movements from individual transfers) (least privilege)
	- Inference - Deduce/assume sensitive info from observing non-sensitive info (pay clark deduce salary of a new from change in company salary expenditure) (blur data, database partioning)

Types of storage
- Primary (real) - RAM available to CPU (most high performance)
- Secondary (non-volitle) - HDDs, Tape, ect
- Virtual - Simulate primary memory through secondary (page file)
- Virtual Storage - Simulate primary in secondary (RAM disk)
- Random access storage - RAM and hard drives
- Sequential Access - Magnetic Tape
- Volatile - Requires power to store
- Non-volatile - magnetic, optical, non-volatile RAM (NVRAM)

Machine Learning and Neural networks
- Expert Systems - a knowledge base (if/then rules) and inference engine
- Machine Learning - Algorithmically discover knowledge from data
- Neural networks - Simulate human mind with layered calculations, require extensive training

Systems Development
- Agile - needs of customer, quick iterations to develop functions
	- Individuals over interactions (over processes/tools), Working Software (over documentation), Customer Collaboration (over negotiation), Respond to change (over following plan)
- Waterfall - Sequential development (opposite of Agile)
	- 7 stage (allows return to previous stage)
	- System requirements, Software requirements, Prelim design, detailed design, code & debug, testing, Ops & Maintenance
- Spiral - Several iterations of waterfall
	- Allows multiple iterations of waterfall
	- Develop new system prototype, iterative

Software Development Maturity Models
- Improve maturity & quality of software processes
- SW-CMM "Capability Maturity" 
	- 5 step: Initial, Repeatable, Defined, Managed, Optimised (CI/CD)
- IDEAL - Initiating, Diagnosing, Establishing, Acting, Learning

Change and Configuration Management
- Request Control - Cost/Benefit analysis of request
- Change Control - recreate-situation
- Release Control - Once changes are finalised, approved release

Virus Propagation Techniques
- File Infection - .exe & .com on Windows
- Service Injection - svchost.exe, winlogon.exe and explorer.exe
- Boot Sector Infection - Bootkits
- macro Infection - Spread through macros (Visual Basic)

Anti-Virus Software
- Signature-based - critical to update frequently
- Behaviour-based - monitor for unusual activity (often cloud-based, AI)

Compromise Password Security 
- Password Crackers
- Dictionary Attacks - Large dictionary file (type of brute force)
- Brute Force - Try all possible variations
- Social Engineering - Authority figure
- Rootkit - Escalation of Privilege (2nd Step)

Application Attacks
- Buffer Overflow - validate user input
- Backdoor - Undocumented command (often during development/debugging)
- Time-of-Check-to-Time-of-Use - program checks access too far in advance of resource request
- Rootkit - Escalation of Privilege

Web App Vulnerabilities
- XSS - Cross-site Scripting (send malicious code to different user)
- SQLi - Unexpected input to gain unauthorised access to database

Recon Techniques
- IP Probes (Ping sweep)
- Port Scan
- Vulnerability scans - Nessus, OpenVAS, Qualys

Protection Rings
- Ring 0 - Kernel
- Ring 1 - Device Drivers
- Ring 2 - Device Drivers
- Ring 3 - Applications

SDLC - Software Development Lifecycle
- Real Developers Ideas Take Effort
	- Requirement analysis
	- Design
	- Implementation
	- Testing
	- Evolution

Concentric Circle Security - Mutually independent security apps, processes, services toward single common goal
- Avoid monolithic stance, provides layered defence (defence-in-depth)

Acquired Software Security impact
- OS vulnerabilities
- Application-Level attacks
- Shrink Wrap Code Attacks - Unpatched/poorly configured software
- Misconfiguration Attacks - poorly configured service/device (left in default)

