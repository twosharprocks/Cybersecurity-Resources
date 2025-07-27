2025-04-14 15:22
Status: #seed
Tags: [[CISSP Study]] [[Cyber]]
Reference: 

---
#### **Learning Objectives**

- Explain the significance of basic secure design principles.​
- Compare and contrast the key security characteristics of security models.​
- Explain the hardware foundations of security.​
- Apply security principles to different information systems and their environments.​
- Determine the best application of cryptographic approaches to solving organizational information security needs.
- Manage the use of certificates and digital signatures to meet organizational information security needs.
- Apply different cryptographic management solutions to meet organizational information security needs.
- Describe defenses against common cryptanalytic attacks.
- Apply the lessons of Crime Prevention through Environmental Design (CPTED) to information systems security design and operation.
- Identify information security implications of various physical facilities, systems and infrastructure.

#### **Key Topics**

|   |   |   |
|---|---|---|
|- Secure Design Principles     <br>- Security Models     <br>- Controls & Systems Security Requirements     <br>- Security Capabilities|- Vulnerabilities of Security Architectures & Designs      <br>- Cryptographic Solutions     <br>- Cryptanalytic Attacks     <br>- Secure Site & Facility Design|- Site & Facility Security Controls     <br>- Information System Life Cycle|

---
Operationalising Risk Management
Threat Modelling - 
- Purpose: To protect the organisation against threats by anticipating and countering various threats
- Threat is something we want to protect the organisation from
- Workflow diagrams to produce a conceptual view of a process or system

Case Study: Stuxnet
- ID in 2010 - unprecedented sophistication in a cyber-weapon
- Tailored to sabotage Iran's nuclear program - exploited series of zero-days to specifically target Siemens PLCs, encrypted payload to avoid detection and ensure integrity
- Highlighted vulnerability of industrial control systems (ICS)

Key Storage and Destruction
- Keys need to be protected from modification
	- Trusted, tamper-proof hardware modules
	- Passphrase protected smart cards
	- Key wrapping session keys, splitting cipher keys between physically separate locations
	- Protecting keys with strong passwords/passphrases/key expiry/ect
- Secret/private keys needs to be protected from unauthorised disclosure
	- To guard against long-term cryptanalytic attack, every key must have an expiry

Algorithim and Protocol Governance
- Key recovery: backup mechanism in the even keys are lost/damaged (eg.Common trusted directories, Password Wallets)
- Should be highly controlled and audited
	- Multiparty key recovery: Key is split and stored with trusted entities
		- No need to backup public keys
	- Dual Control & Split Knowledge: Two or more people required to complete a process
		- Cryptography: Each person supplies unique part of a key
	- Key Escrow: Third party maintains a copy of a private key
		- Mandatory for most organisations use of cryptography
		- Placed in trust of organisation, not individual

Key Management & Practices
- Key management: Most important part of cryptographic implementation 
- Definition: Generation, recording, transcription, distribution, installation, storage, change, disposition, and control of cryptographic keys
- Potential for compromise at every step
- Attacks on keys are far more efficient that attacks on cryptographic algorithims
- Key archival
	- Only backup the encryption private key in a multi-certificate system
	- Use dual control to protect keys
- Saving backups to the Cloud: Know where the keys are stored

Key Pairs
- Asymmetric key generation requires key pair generation
- Private key: Component kept private
- Public Key: Shared and used to 
- One-way functions (Very difficult to reverse)
	- Factoring problem (only RSA)
	- Discrete logarithm problem (Diff-Helmman, ECCC, Elliptic Curve, ect)
		- Finding logs of large numbers that have been exponentiated

Restricted and Work Area Storage
- Restricted area security applies to sapces/rooms where highly sensitive works occurs or information is stored
- SCIF - Sensitive Compartmented Information Facility
	- Extremely high access control protections for both users and systems within
- Strong doors to prevent physical access & block sound
- Electrical connections only to support secure systems
- Acoustic, visual, and RF protections
- Ductwork isolated
- Intrusion detection systems installed

Steganography
- Hide data from a 3rd party (hiding something within itself)
	- Concealing the fact that a secret message is being sent (as well as the message itself)
- Physical concealment techniques
- Modern Techniques
	- Covert channels
	- Hidden text within web pages
	- Hiding messages within picture or sound files
	- Null cipher (hiding within another text)
- Can be used for digital watermarking

Database Systems Vulnerabilities
- Database systems inherit platform vulnerabilities while also adding their own database-specific vulnerabilities
- Database-specific vulnerabilities
	- Data Mining: Finding hidden relationships, patterns, trends in a data warehouse
	- Aggregation: Combining non-sensitive or low sensitivity data to create high-sensitivity data (greater than sum of parts)
	- High Value Target: Databases are sought out by attackers
	- Inference: Attackers can guess information by observing freely-available and related data

Implementation Attacks
- Side channel attacks: Passive attacks that rely on a physical attribute of an implementation.
- Fault Analysis Attacks: Gaining information by forcing faults and analysing error messages/codes
- Probing Attacks: Analysis of circuitry around cryptographic module to discover information about the key/algorithm

Algorithm Attacks
- Rely on math structure of specific block ciphers
- Look for correlations between elements to find weakness in multiple encryption cycles
- Hashing is one-way, but plaintext can be determined by;
	- Hashing each plaintext until a match is found,
	- Hash each plaintext and store the generated hash in a "Rainbow Table"

Crime Prevention through Environmental Design (CPTED)
- Building design to shape behaviour of people in the environment
	- Landscape design features
	- Critical areas isolated from public & employee traffic
	- Architecture: Shrubbery/bushes to guide folks onto paths
	- Lighting: Doorway lighting is a great deterrent
	- Contact devices: Push to open (or remote controlled)
	- Turnstiles/Mantraps: Control access & limit traffic
	- Key locks to secure areas
	- Avoid windows near doors (break glass and reach through)
	- Use laminated glass & window guards to avoid covert entry

Utilities and Heating, Ventilation, and Air Conditioning (HVAC)
- Risk assessments should identify appropriate redundancy for separate services
- Building controls should use appropriate sensors to detect failures in critical systems
- HVAC Standards: ANSI/ASH RAE Standard 90.4-2019
	- Recommends temperature between 64-81 def F (18-27deg C)
	- Recommends a rack have three temperature sensors (top, middle, bottom)
	- Cooling is a huge cost/concern, but also need to address contaminants (dust, noxious fumes, ect)
	- Need to ensure air quality through airflow (based on the number of human occupants) and CO2 sensors

Goals and Drawbacks of Kerberos
- Goal: Ensure private communications between systems over a network by managing encryption keys, and authenticates principals based on possession of the secret key (allowing access to session key).
- Drawbacks: Depends on careful implementation and enforcing authentication limited lifetimes. 
	- Key Distribution Center (KDC) must be physically secured/protected, and can be a single point of failure
	- Secret key and session key lengths are very important
		- Too short can be brute forced
		- Too long can cause system overload
		- Encryption is still based on passwords

Case Study: Site and Facility Security Controls
- Northgate Information Solutions (NIS) experienced fire/explosion
- Blast blew main water tank supplying building's fire sprinkler system
	- Additional security concerns? Single point of failure in water supply
- Blast threw confidential documentation out of the facility
- Prime example of why business continuity and site security are important
	- Need for more pre-vetted staff to secure site during extreme event

Distributed Systems Vulnerabilities and Mitigations
- Common vulnerabilities:
	- Lack of central control/monitoring
	- Loss of data if nodes fail
	- Inconsistent security configurations between nodes
	- Susceptible to communication failure, compromise, or Denial of Service (DoS) from external attackers or internal error
- Mitigations for distributed systems:
	- Security baseline for new nodes
	- Communication control, encryption and redundancy
	- Node backup and node data sharing

Site and Facility Security Controls: Power
- Power stability resilience & quality of electrical service is vital
- Dual feed data centres
- Backup generators & UPSs need to be able to handle a failure
- Backups and testing are vital to ensure correct operation in an outage

High-Performance Computing (HPC) systems
- High-speed computers that handle large amount of data for data analytics and/or complex algorthms (cryptography)
- Vulnerabilities
	- Latency constraints: IDS/IPS or firewalls impose unacceptable latency losses
	- Improper Workloads: HPC's resources could be consumed improperly if it's compromised
- Mitigations
	- Proper Architectural Design: Architect secure computing enclaves and detection tools around perimeter of HPC
	- Appropriate monitoring and logging: Properly design & review logging to ensure security can be audited without interfering with HPC system

Industrial Control Systems (ICS)
- Three well-known types
	- SCADA - Supervisory Control and Data Acquisition: Interconnected equipment to monitor/control physical equipment in industrial environments. 
		- Used to automate geographically distributed processes: Power generation/transmission/distribution, oil & gas refinement/pipelines, chemical processing, rail & mass transit
	- DCS - Distributed Control Systems (DCSs): Confined to geographic area or specific plant.
		- Many similarities with SCADA but confined to defined area with local control
	- PLC - Programmable Logic Controllers: Ruggedised industrial controllers, generally using specialised code to react to real-time inputs. 
		- May be stand-alone or integrated into SCADA/DCS systems
- Vulnerabilities:
	- Limited functionality: Standard OS functions/protections may not be available
	- Limited protections
	- Long Lifespan: Typically >10 years operation
	- Susceptible to misuse/error: Complicated specialty systems
	- Susceptible to DoS: Minimal communication protection & sensitive to improper input
	- Physical Impacts
	- Often unattended/remote locations: Allows maintained physical access
- Mitigations:
	- Isolate network infrastructure
	- Monitor control system networks
	- Highly segmented networks
	- Protect Communication Channels
	- Robust Configuration Controls


Embedded Systems and IoT Vulnerabilities and Mitigations
- Specialised computing platform with limited/specialised OS, with limited processing power and long service life. 
	- May include system on a chip (SoC)
	- Limited function design or ability to update

Cloud-based Systems Vulnerabilities and Mitigations
- Vulnerabilities:
	- Inherently exposed to external communication
	- Misconfigurations
	- May exist for long periods (legacy user components)
	- Gap between CSP and data owner security controls
- Mitigations:
	- Reputable CSP
	- Well-trained sys admins
	- Encryption of files and communications
	- Identity and access management (IAM)

Session Keys - Creation & Protection
- Automated Key generation: Designed for user transparency & complete policy enforcement
- Truly Random: Need appropriately high work factor (amount of time and effort required to break is > time information needs to be protected)
- Asymmetric Key Length: Need to be longer than symmetric keys, as factoring and discrete log problems are easier to solve than brute-forcing all possible keys (Eg. RSA-1024 ~ 80-bit symmetric)
	- RSA-3072 should be used if security is required beyond 2030

Edge Computing and Fog Computing Vulnerabilities and Mitigations
- Vulnerabilities:
	- Network Compromise: Heavy reliance on network infrastructure
	- Increased Attack Surface: Increased number & diversity of devices increases potential of compromise
- Mitigations:
	- Increased network monitoring & incident response
	- Strengthen inventory (avoid sprawl, rogue devices, obsolete equipment)

Examples of Asymmetric Encryption Algorithms
- RSA - Rivest-Shamir-Adleman: Based on factoring primes
- DHM - Diffie-Hellman-Merkle: Based on discrete logarithim. Used for key negotiation with no message confidentiality (eg. exchange/negotiate a secret symmetric key for subsequent message encryption like PKI requiring symmetric session keys)
- EIGamal: Based on DHM but also includes message confidentiality & digital signature. 

Symmetric Encryption Algorithms
- Key distribution and management is difficult in large organisations - Sender and receiver need the same key
- Key distribution is the biggest problem with symmetric crypto
- Scalability - Number of keys required grows rapidly: n(n-1)/2
- Can't offer
	- Digital signatures
	- Non-repudiation of origin or delivery
	- No Access Control or Integrity

Certification/Certificate Authority (PKI)
- Need a register to reliably associate a key pair 
- Certificate Authority (CA): Trusted third party signs owner key association
- International PKI standard: x.509 certificate standard

Virtualised Systems
- Hardware virtualisation in cloud environments
	- Supports multi-tenancy
	- Rapid IT resource deployment from share pool
	- Facilitates automation
	- Reduce complexity and admin overhead
- Hypervisor is the most important element to allow virtualisation
	- Allows multiple OSs to share single hardware host
	- Controls host processor and resources
	- Prioritises and allocates resources to avoid crashes
- Type 1 Hypervisor: Runs directly on hardware (VMware EXSI)
	- Significantly reduce attack software. Also controls software.
- Type 2 Hypervisor: Runs on host OS (VMware Workstation, VirtualBox)
	- More attractive to hackers due to OS vulnerabilities

Ransomware and Ransom Attacks
- Mitigation:
	- Backup Data
	- Separate Backups: Isolate computer and network
	- Isolate Processes: Physically isolate sensitive processes
	- Use Licensed Software: Legally licensed and supported software with proper updates and patching
	- Conduct Training: Build Awareness
	- Configure Tools: Anti-malware tools to update signature files & scan storage
	- Implement Protections: Spam filtering, malicious attachments
	- Verify Systems: Verify IDS and IPS systems
	- Reassess Practices: Review incident response and decision-making processes
	- Conduct Exercises: Tabletop & simulations to ID weaknesses in process & procedures
	- Define Processes: Determine policy, processes, procedures, legal authority around ransomware payment
		- Recognise that payment may be to organisation with specific terrorism sanctions
- Consider Endpoint Detection and Response (EDR) and Extended Detection and Response (XDR)

Additional Attacks
- Spoofing: MitM Attacks
- Pass-the-Hash: Capture and reusing password hash for lateral access
- Time of Check/Time of use: Abuse of system multi-tasking

Additional Algebraic Attacks
- Birthday Attack: Probability two hashes will match is < possible number of hashes (Brute force attack) (In a group of 23, chance 2 or more share birthday is >50%)
- Factoring Attack: Targets RSA by solving public key factoring to find private key
- Dictionary Attack: List of possible passwords used against a password file. Rainbow table of hashed digests speeds this up considerably
- Random Number Generator Attacks: Some algorithms are predictable, and make determining initialisation vectors guessable
- Temporary Files: If temporary calculation files are exposed, they can be used to aid cryptanalysis

Elliptic Curve Cryptography (ECC)
- Trapdoor Function: Given P & Q, easy to compute `P*Q`
- Given Product (N), it is NOT easy to compute P or Q
- ***Highest strength encryption per bit of key length***
- Much smaller key sizes (256 & 384 bit) than RSA (eq 3072 & 7680)
	- 384-bit is acceptable for NSA top-secret (eq RSA-7680)
- Keyspace = Maximum space available for process
- N is the number of times this process has been repeated

Site Planning
- Alternate sites - geographically distinct from primary site
	- Should have equivalent processing power
	- Possible fail-over to cloud infrastructure?
	- Requirements need to be determined in contingency plans
	- Configurations at alt site should be compatible with primary
- Threats
	- Natural disasters
	- Structural failures
	- Hostile Attacks
	- Errors of ommission/commission

Client-based Systems Vulnerabilities and Mitigations
- Vulnerabilities:
	- Physically under user control: Misuse, lost/stolen, monitoring challenges, patching/update challenges
- Mitigations
	- Continuous Patching/Updating
	- General network protection: segmentation, firewalls, network intrusion prevention/detection
	- Host Protection: Antivirus, IDS/IPS, host firewall, disk encryption
	- Monitor: Logs, alerts, location
	- Education: Anti-phishing campaigns, Attack detection

Defense in Depth
- Definition (NIST-800): Security architecture constructed through the application of multiple mechanism to create a series of barriers to prevent, delay or deter an attack
- Defense-in-Depth increases assurance, but no system is stronger than the weakest link in the chain
- Defense-in-depth is not a substitute or equivalent to a sound security architecture leveraging concepts and design principle
- Example: Username/Password followed by phone notification for 2FA. Also using a series of firewalls with a DMZ.
- Defense-in-depth is the use of multiple controls from multiple control categories

Applicable Types of Controls and Security Control Categories
- Controls
	- Technical and logical controls: Firewalls, Access control lists, badge readers, ect
	- Physical Controls: Tangible (Walls, Fences, guards, locks, ect)
	- Administrative: Policy and Procedure
- Control Categories
	- Directive: Policy, signs
	- Deterrant: Notification, signage, notible presence of other controls
	- Preventative: Walls, Fences
	- Compensating: Mitigation measure
	- Detective: Recognise hostile activity (Guards, IDS)
	- Corrective: IPS, Incident Response
	- Recovery: Restore operations to a known good condition (Backups, Disaster Recovery)

Wiring Closets and Intermediate Distribution Facilities ("Cable Plant")
- May Include
	- Entrance Facility
	- Phone, network, special connections
	- ISP or Telco equipment
	- Equipment Room
	- Wiring and/or switch components
	- Backbone Distribution
	- Telco room (wiring closet)
- Security protections
	- Rooms secured against unauthorised access
	- Room access monitored/recorded
	- Secondary locks on equipment/racks
	- Conduit or tamper protection for wiring
	- Environmental protection
	- Lightning/Surge Protection
	- Backup Power/UPS
	- Heating, Cooling, Air Flow
	- Fire detection/suppression
	- High-Power Energy shutoff

Separation fo Duties (SoD)
- Attenuate possibilities/opportunities for corruption and theft
- No one individual can complete all the steps of a process
- Necessarily degrades efficiency

Other Uses of Digital Signatures
- Distributed Ledge (Blockchain)
	- Record of transactions is maintained on multiple, separate systems (no single point of failure)
	- No record change can occur without it being recognised in the ledger of multiple, independent systems
- Message Authentication - Two types using digests
	- Message Integrity Codes (MICs) (aka "Non-Keyed")
	- Message Authentication Codes (MACs) (aka "Keyed" or Cryptographic checksum)
		- Combine a message digest with a secret key - requires sender and receiver share a secret key beforehand
		- Generally use SHA-1 or SHA-3 (previously MD5)
- HMAC operation offers similar cryptographic strength and speed as hashing, but with the additional protection of a secret key
	- Offers assurance of HMAC security

Advanced Encryption Standard (AES)
- NIST sponsored in 2000 to replace DES
- Rindell algorithm (New standard)
- Required for all US government systems (up through Top Secret)

Hashing: Asymmetric Encryption for Data and Message Integrity
- Hashing: Random number generator using seed value and salt value
- Message Digest is an example of hashing
	- Fixed length, One-way operation, does not use a secret key
- Five Properties
	- Uniformly distributed
	- Collision resistant
	- Impossible to invert - One way, irreversible
	- Computer on the entire message
	- Deterministic - Given x, always generate y
- MD5 - Generates 128bit length hash, processes in 512-bit blocks
- SHA - Base on MD4
- SHA-1 - Based on MD5, Output is 160-bits long, 512-bit processing blocks, four rounds of operations with 20 steps each
	- SHA-type determined by number written AFTER the hash

Trust but Verify
- Trustworthiness of an information system is measured in specific and measureable criteria relative to operational permformance measure and stated security objectives
	- Includes strength of protection and level of assurance/confidence in protection capability
	- Burden to demonstrate an absence of certain outcomes (anti-patterns)
	- Demonstration, inspection, evaluation, and testing

Brewer and Nash - Preventing Conflicts of Interest
- Users should not access confidential information of a client organisation AND it's competitors
- Prevent information sharing between competitors
- Reduces the opportunity/temptation to violate laws/ethics
- Unusual because access control rules change based on subject behaviour

HRU (Harrison, Ruzzo, Ullman) - Restricting user privilege
- Model is very similar to Graham-Denning, and concerned with restricting a subject from gaining specific privileges
- Composes a set of generic rights and finite set of commands
	- Subjects prevented from accessing programs/subroutines to execute a command
- Modern operating systems try to implement this but are not perfect

Clark-Wilson - Integrity at transaction level
- Improves on Biba model for maintaining data integrity
- Requirement for transactions by evaluated by another party before commitment
	- Separation of duties
	- Steps within any transaction need to be carefully designed and enforced
- Clark-Wilson establishes subject-program-object so subject does not directly interact with object (all facilitated by program)
	- Program arbitrates all access (authentication & identification) and ensures interaction follows defined rules.

Fire Prevention, Detection, and Suppression
- Prevention is the most important part
	- Adherence to building code, inspections, removal of fire load
	- Prohibit smoking
- Detection: Smoke sensors (ionisation or photoelectric), Spot sensors (also include CO and heat detection), VESDA (air quality monitoring)
- Suppression: Extinguishers, In-rack
- Fire Classes - Most offices are concerned with A, B, & C
	- A - Paper, wood, plastic
	- B - Flammable liquids
	- C - Electrical fires
	- D - Flammable metals
	- K - Commercial Cooking

Social Engineering for Key Discovery
- Using deception/intimidation to disclose information
- Humans are the weakest link - social engineering is the most common cryptographic attack
- Constant awareness, education, and training

Zero Trust
- Do not trust anything inside or outside network without first verifying access

Keep it Simple
- Economy of mechanism - Keep the design as small and simple as possible
- Reduced complexity: System design as small and simple as possible. Easier to analyse and less prone to error.
- Simplicity of system is directly correlated with number of vulnerabilities

---
**This reminds me of**... 

---
# Other References
