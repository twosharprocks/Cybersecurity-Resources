2025-07-18 17:39
Status: #seed
Tags: [[Cyber]] [[CISSP Study]] 
Original: https://youtu.be/XZr2wLKdoVc?si=QRLudpH_ZeHJkiLv

---
# Changes since 2021
Duration: 3 hrs
Number of Question: 100-150
- Cloud Computing more prominent (but 2021 prep still applies)

# Domain 1 - Security and Risk Management
5 Pillars of Information Security
- Confidentiality, integrity, availability, authenticity, nonrepudiation

Sherwood Applied Business Security Architecture (SABSA)
- Security Control Framework - Prescriptive set of cybersecurity safeguards
- Risk Frameworks - Structure approach to ID, assess, prioritise and manage risk decision making
- SABSA - Security architecture framework and methology
	- Used in conjunction with both risk and security control frameworks
	- Risk does "why" (strategic), Security control does "how" (tactical), SABSA adds "how" (architecture)

NIST Risk management Framework (RMF) - Mandatory for Federal gov agencies
NIST Cybersecurity Framework (CSF) - Optional guidance for private business

FedRAMP - Federal Risk and Authorisation Management Program
- Standardised approach to security assessment, authorisation and monitoring for ==cloud products and services==
- Goals: Accelerate adoption of secure cloud, enhance cloud trust, promote reusable cloud approach

ISO27001:2022 - Information Security Management System (ISMS)
- Set of policies, processes, and controls to protect info assets
- ID info assets and assess value
- Implement mitigating controls based on ISO27002
- Regularly monitor, measure effectiveness, and continuously improve ISMS

ISO27002:2022 - Best practice and control objectives for ISO27001
- Focus areas of access control, cryptography, HR security, opsec, incident response
- Practical blueprint for organisations attesting to ISO27001

Privacy Issues
- Privacy - Right to control collection/use/disclosure of PII, PHI
- Confidentiality - Duty of org to ensure private info is kept secret

Encryption & Privacy
- Computer Export Controls - can't export to Cuba/Iran/NK/Sudan/Syria
- Encryption Export Controls - Limits on export of encryption products
- Privacy (US) - Fourth Amendment
- ==Privacy (EU) - GDPR==

Privacy Laws
- Health: HIPAA & HITECH
- Financial: Gramm-Leach-Bliley Act
- Children's Online Privacy Act (COPPA)
- Electronic Communications Privacy Act (ECPA)
- Communications Assistance for Law Enforcement Act (CALEA)(Wiretapping)
- California Consumer Privacy Act (CCPA)
- China: Personal Information Protection Law (PIPL)
- South Africa: Protection of Personal Information Act (POPIA)

Privacy Impact Assessment (PIA)
- Privacy Data being stored/processed/stored by system and impact of breach
- Required by GDPR & HIPAA
- Assess Scope, Data Collection, and data retention

Cloud Privacy
- Data residency is vital
- Legal can prevent use of a CSP, add costs & time to market, drive changes to architecture
- NEVER replace compliance with convenience (increases risk)
- Many frameworks impose fines or other actions for noncompliance

Conflicting International Legislation
- Laws can introduce risk, and mitigate legal risks just like any other. Cloud risks require legal collaboration
- Conflict Example
	- EU: GDPR ==forbids== transfer of data to countries without adequate privacy protections
	- US: Clarifying Lawful Overseas Use of Data (CLOUD) Act ==requires== CSP to hand over data to aid investigation of serious crimes, even if stored in another country
- Consumer is responsible for navigating legal challenges

External Dependencies - Entities outside of org it depends on for continuity, disaster recovery, or operations

Supply Chain Risk Management
- Hardware Root of Trust - Defence against unauthorised firmware, which verifies keys match before secure boot begins
	- TPM & Silicon Root of Trust (SRoT)
	- SRoT - Specialised chip/module embedded directly into hardware, uses unique & unchangeable (immutable fingerprint) cryptographic identity
	- Physically Unclonable Function - Digital fingerprint based on chips inherent variations (typically semiconductor
- Software Bill of Materials (SBOM) - Inventory of all components in a software product

# Domain 2 - Asset Security
Nothing new - no topics moved or removed

# Domain 3 - Security Architecture and Engineering
Secure Access Service Edge (SASE) - based on Zero Trust
- Brings together network and security functions into integrated cloud service
- Includes: Firewall, Secure web gateway, anti-malware, IPS, Cloud Access Service Broker, Data Loss prevention
- Merges WAN management into unified whole, cloud native architectures
- Response to edge-centric trends in mobility, cloud, SD-WAN and IoT

Cryptographic Lifecycle
- FIPS 140-2 - Protect digital stored, unclassified yet sensitive info. Developed for use in non-military US gov agencies
	- Three Levels: 1 (Lowest), 2 (Specifies security for crypto modules), 3 (Physical protections to ensure tampering attempts are evident/detectable)
- FIPS 140-3 (Supersedes -2) and has ==Four Levels== 
	- Level 1: Production-grade equipment and externally-tested algorithms
	- Level 2: Adds physical tamper-evidence and RBAC
	- Level 3: Add physical tamper-resistance, ID-based auth, separation between interfaces
	- Level 4: More stringent physical requirements, physical tamper-active, erase contents for various environmental attack
	- Types of modules: Hardware, Software, Cloud 

Cryptography & Key Management
- Keys must be secured at same level as the data they protect
- Sensitivity dictates level of protection
- Key Recovery - Recover of key without user cooperation
- Key Escrow - Keys held by trusted third party

Key Management Strategy
- Generate - In HSM
- Distribution - Encrypt key with separate key
- Storage - Protected at risk
- Use - Clients use key for resource access (acceptable use policy)
- Revocation - Process to revoke at separation, policy breach
- Destruction - Removal from key from operation location
	- Deletion - Removes any info that could be used to rebuild key
- 

Quantum key Distribution
- Two parties to generate shared random secret key
- Essential property of QKD is ability to detect eavesdropping (introduces detectable anomalies)
- Main drawback is it relies on authenticated classical channel
	- In practice you can achieve authentication & secure comms without QKD at less expense
	- Only used in high security scenarios using key distribution by courier.
	- QKD not used to transmit quantum data

Information System Lifecycle - 9 phases
- Stakeholder needs/requirements - define scope, baseline security expectations
- Requirement Analysis - Analyse/refine requirements, map requirements to detailed/actionable security controls
- Architectural Design - High level blueprint of system, architecture diagrams, data flows, threat modelling, security by design
- Development/Implementation - Build phase, develop/procure software/hardware, implement security configurations
- Integration - Components function together, integrate and document, ID and address potential security gaps
- Verification/Validation - Confirm it meets requirements & stakeholder needs, testing, stakeholder feedback, vulns minimised
- Transition/Deployment - Move to production, user training, secure and controlled transition
- Ops and Maintenance - Ongoing operation & management, patch/config management, incident response, vulnerability scanning
- Retirement/Disposal - Secure decommissioning, prevent data exposure, respect data retention periods, secure data sanitization

# Domain 4 - Communication and Network Security
IPv4 - 32bit addresses (4 billion unique), large portions reserved
IPv6 - 128bit (340 undecillion unique addresses)

Multicast - one-to-many specific recipients
Broadcast - One-to-all (not supported by IPv6)
Unicast - one-to-one (most common use)
Anycast - one-to-nearest or most optimal 

Converged Protocols - run over existing TCP/IP
- Infiniband over Ethernet - Remote direct memory access over ethernet (lower latency and higher throughput)
- Compute Express link - Open standard for high-speed high capacity cpu-to-device and cpu-to-memory connections

Management Plane - Config, monitoring, software updates and security management
Control Plane - Routing & optimal paths, managing network routing protocols between devices
- Open Shortest Path First (OSPF) & Border Gateway Protocol (BGP)
Data Plane - Forwarding data packets between devices in the network
- Cut-through switching - Ultra-low latency, makes forwarding decision as soon as receives first part of frame
- Store-and-forward - When reliability is essential, Switch waits for full frame before forwarding

Network Performance Metrics
- Bandwidth: Maximum capacity of network channel
- Throughput: Actual data transfer rate in practice
- Latency: Time delay of packet between source & destination
- Jitter: Variation in latency
- Signal-to-Noise ratio (SNR): Quality of signal

Traffic Flows
- East-West: Data move laterally between servers within datacentre (internal - micro-segmentation & isolation)
- North-South: Data moves from internal network to public cloud or internet (data compromise, DDoS, inadequate authentication)

Reasons for Segmentation
- Boost performance - organise segments wwhich communicate regularly
- Reduces communication problems
- Helps security

Intranet - Private network
Extranet - Segment for internal and external
DMZ/Perimeter network - Public consumption

Out-of-band: Physically separated network infrastructure
Air Gap: Complete physical isolation, no wired or wireless connections (common in high-security critical infra)

In-band segmentation: Subnets & VLANs
Virtual routing & forwarding: Common in IP routers
Virtual Domain: "VRF Domains"

Micro-segmentation: Further divide apps/workloads (limit scope of impact)

Edge Networks: Distributed networks bring compute/storage physically closer to end users/devices
- Ingress/Egress: Entry point for traffic entering edge network (security, monitoring, and traffic shaping)
- Peering: Direct interconnections (reduce latency, costs, central bottlenecks)
- Caching: Cache popular content (Content Delivery System), improves SaaS subscriber scenarios
- Compute: Containerised, low-latency processing near end users (edge computing)
- Storage: Reduces latency, regional replication

Virtual Private Cloud - VM's are isolated from resources of another company

Network Observability - Data and visibility into status/performance of network components/traffic
Traffic Flow/Shaping - Manage, control, priortise different types of traffic
Capacity management - Tracking network use and planning capacity expansion to meet future needs
Fault Detection and Handling - Discover, diagnose, respond to faults (failed devices, connectivity or performance loss)

# Domain 5 - Identity and Access Management

Groups - Collection of users/devices, streamline management of permissions
Roles - Specific rights and permissions granted to groups (reflect job functions/responsibilities)

Authentication, Authorisation, Accounting
- OATH - Open Authentication, time-based, one-time password (TOTP)
- Passwordless - Hello, FIDO2 Security Key, Authenticator App
	- Reduces phishing exposure, adds cost/biometric concerns
- FIDO2 - Public key for user authentication (key provides crypto response)
- Windows 10 replaces passwords

Zero Trust: No entity is trusted by principle, 
- Assume breach, verify explicitly, least privilege access
- Identity as control plane
Trust but Verify: Largely replaced

Policy Enforcement Point - Responsible for enabling, monitoring and terminating connections between subject and resource. Applies necessary controls

Policy Decision Point - Where decisions are made based on user ID, device health, risk assessment

Zero Trust Architecture (NIST SP 800-207)
- Control Plane (drive policy-based decision logic): Adaptive identity, threat scope reduction, policy-driven access control, policy administrator, policy engine
- Data Plane (Enforces decisions defined in control plane): Implicit Trust Zones, Subject/System, Policy Enforcement Point

# Domain 6 Security Assessment and Testing
Location - "Design & Validate" Audit Focuses
- On-Prem: Physical access main concern, Control and Visibility, Scope
- Cloud: Shared Responsibility, Documentation & APIs, Compliance Focus
- Hybrid: Increased complexity, Data Flows, Integrated Controls across the hybrid landscape

Assuarance Challenges with Virtualised Cloud
- May require multiple layers of auditing - auditor must understand the virtualised architecture of CSP
- Use of vulnerability scanners & pentesting may be limited by CSP
	- CSP usually has Rules of Engagement for testing
	- Right to Audit - Contracts often written to allow CSP standard audits be used in place of customer-performed audit

PenTesting - Red Team, Blue Team, Purple Team (& White team)

Cloud Audits - Sampling by picking a subset of physical infrastructure (20 of 100 regional centres)

Cloud Audit Standards
- SSAE - Statements on Standards for Attestation Engagements 
	- Defined by American Institute of CPAs
	- Enhance quality and usefulness of "System and organisation Control" (SOC) reports
	- Audit standards & suggested report formats
	- SOC 1: Financial controls
	- SOC 2 Type 1: Design of security processes and controls at specific point in time
	- SOC 2 Type 2: Effectiveness over time (generally >6months)
	- SOC 3: Publicly shareable & general opinions
	  
- ISAE - International Standard on Assurance Engagements
	- International Auditing and Assurance Standards Board
	- ISAE 3402 roughly equivalent to SOC 2
	  
- CSA - Cloud Security Alliance
	- Security Trust Assurance and Risk (STAR) certification program
	- Demonstrate compliance to desired level of assurance
	- Two levels of certification 
		- level 1: Self-Assessment
		- Level 2: Third-Party Audit

# Domain 7 - Security Operations
SIEM - Collects data 
- Key Features: Log centralisation & Aggregation, Investigative monitoring (broad visibility across data, apps, IDs, endpoints, infra)

SOAR - Centralised alert and response automation with threat-specific playbooks & Runbooks (Automating response)
- Log Collection, SIEM, SOAR, SOC
- Faster than humans in identifying and responding to true incidents
- Logs only useful if they're reviewed, and SIEM tools can help
	- Log centralisation, data integrity, normalisation, automated or continuous monitoring, alerting, investigative monitoring
		- SOAR runbooks often invokable from the SIEM
- Playbook - Document/Checklist (paperwork)
- Runbook - Automated tool that implements playbook (technology)

Communications for DRP
- Internal Stakeholders 
	- Disaster recovery teams: Req. reliable real-time channels for real-time comms
	- Management: Periodic updates on progress & potential impacts
	- Wider company: General Awareness (pre-post announcements)
- External Stakeholders
	- Customers/Clients: Proactive controlled comms about potential service disruptions, ETAs for resolution
	- Partners: Inform of relevant timelines & agreed coord channels
	- Regulators: Advanced notification and/or post-test reports may be mandated, include compliance 

# Domain 8 - Software Development Security
Agile Model - Four Principles
- Individuals and interactions over (processes and controls)
- Working software (over comprehensive documentation)
- Customer Collaboration (over contract negotiation)
- Responding to change (over following a plan)

- Agile: SCRUM methodology to help agile teams work together
- Scaled Agile Framework (SAFe) - Implement agile for enterprise
	- Based on: Agile Software Development, Lean Product Development, Systems Thinking

Waterfall - 7 stages
- System Requirements, Software Requirements, Preliminary Design, Detailed Design, Code and Debug, Testing, Ops & Maintenance

Spiral Model - Multiple iterations of waterfall
- New system prototype with each loop (iterative)

Application Security Testing
- Static Application Security Testing 
	- No program execution, requires source code access
	- Inside out
- Dynamic Application Security Testing
	- Program execution, no source code required, tester has no knowledge of application tech/framework
	- Outside in
- Interactive Application Security Testing
	- Analyses for vulnerabilities while being used
	- Real-time reporting to optimise testing
	- Often built into CI/CD

Software Composition Analysis
- Track components of software package or application
- Special concern to open-source software components
- Automated, combines app security & patch management

Cloud Services - Impact of acquired software
- Data Security and Privacy - Encryption, data residency, confidentiality/integrity
- Shared Responsibility
- CSP Security Practices - policies, incident response, track record
- Multi-Tenant & Isolation - Mechanisms to prevent leakage
- Identity and Access Management - Auth mechanisms, RBAC, Just-in-time control
- Monitoring, Logging & Auditing - capabilities, retention policies, ability to access/analyse logs
- Incident Response and Notification - CSP procedures & notification protocols
- Compliance and Regulatory Requirements - Depending on industry
	- SOC 2 Type II
- Data Portability and Exit Strategy - Ability to migrate/leave
- Supply Chain Security - Mitigate potential vulnerabilities