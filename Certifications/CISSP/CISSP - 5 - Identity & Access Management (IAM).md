#### **Learning Objectives**

- Explain the identity lifecycle as it applies to human and nonhuman users.
- Compare and contrast access control models, mechanisms and concepts.
- Explain the role of authentication, authorization and accounting in achieving information security goals and objectives.
- Explain how IAM implementations must protect physical and logical assets.
- Describe the role of credentials and the identity store in IAM systems.
#### **Key Topics**

- Control Access
- Design Strategy
- Implementation
- Identity & Account Management

---
IAM Administration Choices - Physical and Logical
- Three Primary Management
	- Centralised: One element responsible for management
		- Maintain control of information
		- User accounts centrally monitored
		- Easy to enforce consistent and uniform procedures and criteria
		- All authorisation and authentication managed by central node
	- De-Centralised (Distributed): Controlled by owners/creators of files
		- Control is in the hands of the individuals most accountable
		- Increased fault tolerance and shorter response times
		- Disadvantage: Inconsistency between files, difficult to get system-wide view, latency between  
	- Hybrid
		- Centralised control for broadest and most basic access
		- Decentralised for other information to control access based on file type or user abilities

Just-In-Time Identity (JIT) (or JIT access)
- Granting access at specific time, for specific purporse, with specific privilieges
- Often done via SAML using SSO authentication
- Features
	- Real-time: Minimum elapsed time possible (triage)
	- Full Identity Life Cycle Service: Possible to automate Registration, deregistration, deletion
	- Escalation/De-scalation: Momentary privileges to perform service
	- Human and Non-Human Users: Human resource-access is via software, and non-human daemons also access info.

Disable and Deprovision
- Human users may leave or change role within organisation, leading to identity being disabled & deprovisioned)
- Non-Human Users may also be deprovisioned.
- Data custodian or IAM administrator perform deprovisioning of permissions

Provisioning
- Users may request access to system resources with required permissions.
- User must attest identity (eg. Identity proofing via gov-issued ID)
- Data owner reviews, and provided approval/rejection notice to Data Custodian, who creates user account for approved individual
- Data custodian notifies user and data owner of account creation, user accesses system with assigned permissions

Access Control (AC) Models
- Role-Based Access Control (RBAC) - Restricts information systems to authorised users
	- Create specific roles based on job functions and privileges required for that role
	- Access granted by the owenr as with DAC and applied with policy according to MAC
	- Non-RBAC: Map users to applications
	- Limited RBAC: Map user to applications + others not mapped
	- Hybrid RBAC: Users mapped to multi-application roles
	- Rull RBAC: Users mapped to enterprise roles
- Rule-Based Access Control (RuBAC)
	- Pre-defined list of rules to determine access
	- Additional granularity for when, where and if system will allow read/write/execute conditions
	- Managed by system owner - implementation of DAC
- Mandatory Access Control (MAC)
	- Access control policy decisions made by central authority (not user)
	- Example: Military security where user does not determine who has "Top Secret" clearance and can't change an object's classification
- Discretionary Access Control (DAC)
	- Some access control left to discretion of object owner
	- Many Windows/Android systems use discretionary access so purchasers can control product
- Non-Discretionary Access Control (NDAC)
	- Establish controls that cannot be changed by users (only admin)
- Attribute-Based Access Control (ABAC)
	- Provides access based on user/resource/environment attributes, time of day, location, ect
	- Allows setting stricter permissions based on risk (aka risk-intelligent access control)
	- Uses Boolean logic (if this then that)

Case Study: Dropbox (2012 Breach)
- Attackers stole Dropbox employee's password and gained access to list of user email addresses
- Dropbox implemented 2FA afterwards
- Physical/Logical Asset Access: Highlighted need to prevent unauthorised entry & protect assets
- Identity and Authentication: Required enhanced user verification
- 3rd Part ID services: Revealed risks associated with 3rd party integration
- Authorisation measures: Need for robust authorisation controls
- Identity and access provisioning life cycle: Access reviews and ensuring provisioning process integritys

Access Control: The Basics
- Controlling access by subjects (users) to objects (files, systems, printed docs, wifi channels)
- CRUD: Create, Read, U, Delete
- Credentials are required for access

Account Management - IAM Review
- Assigns account managers
- Establishes conditions for group/role membership
- Specifies authorised users
- Requires approval for authorisations, creating, ebaling, modifying, disabling, and removing access
- Monitors use of information system accounts
- Notifying account manager when account access is no longer needed
- Reviewing account for compliance

Case Study: Uses for JIT Identity
- Directly enforce least privilege, separation of duties, and vulnerability management policies
- Privileged Account Management (PAM)
	- JIT PAM allocates privileges for a ceiling period, with RBAC specific privilege subsets that are only active in real-time when resource/service is requested
- Privileged Session Management
	- Not just sysadmins - can facilitate fine-grain privilege assignment to session activities by means of user ID
- Enpoint Privilege Management
	- Prevent malicious or accidental processes from running with incorrect privileges on an endpoint
	- JIT PAM to the endpoint locally establishes and enforces application policies (including trusted installed applications)
- Remote Help Desk
	- Generally require trusted agent application working with endpoint OS
	- Endpoints users must trust help desk to allow, and org must trust endpoint will not trap credentials for reuse

Single Sign-On (SSO) aka Federated Identity Management
- Unified login experience for end user
- Steps
	- Login request is authenticated by SSO server
	- Each application requires back-end authentication between SSO and application server
	- Access Tokens can also be used instead of application passwords
- Variety of tech (including SAML) can be used to implement SSO
- Risks and challenges
	- Single point of failure: Access to credentials allows access to all resources
	- Password Synchronisation: Required to work across systems
	- Legacy Systems: May not support SSO mechanisms

Security Assertion Markup Language (SAML)
- XML based framework
- SAML Roles
	- Identity provider
	- Service provider/relying party
	- User Agent
- Components
	- Assertions: How attributes, authentication, authorisation request-response protocol messages are exchanged
	- Bindings: How assertions and protocol messages are conducted with request-response pairs
	- Protocols: SOAP, HTTP
	- Profiles: Set of assertions, bindings and protocols to address specific function
- ![[Pasted image 20250606152330.png]]

Session Management
- Sessions: Created, managed, supported, terminated by protocols on Layer 5
- Authenticated Session Management
	- Set of activities to ensure system maintains protected path to resources during session
	- Engages IAM systems in use by all session nodes
	- OWASP #2 threat is broken authentication 7 session management
- RFC2655 - Using cookies for session management
- Session Management is...
	- Process of tracking/securing multiple requests to a service from same subject (Identify legitimate users, track additional info, track where it ended/actions taken)
	- Submission of authentication provides session identifier information
	- Session IDs are long & random values used only once (nonce)
	- Session replay or replay attack - logging in with stolen cookie

Kerberos
- Network authentication protocol for client-server application 
- Secret key crypto
- Three systems
	- Requesting System (the Principle)
	- Endpoint Destination Server
	- Key Distribution Server (KDC)
		- Authentication Server (AS) or Ticket-Granting Server (TGS)
	- As AS - Pre-exchanged by secret key
	- AS TGS - Requires AS authentication, allows authentication to other services

Case Study: Dept of Homeland Security Physical Access Control Systems
- PACS - Physical Access Control Systems
- Identification: Requires PII to authorise physical access, and issued a personal identity verification (PIV) card
- Visitor Management: Visitors without PIV must be identified before access
- Parking Permit Management: PACS used to issue/track parking permits
- Alarm monitoring & intrusion detection: Alarms for monitoring physical IDS. Consists of sensors, lights, and other mechanisms. 

Access Control as a System, Logical Access Control Systems, and Physical Access Control Systems (PACS)
- Access Control systems are built using three categories of security controls
	- Administrative Controls: Human-facing policies, directives, procedures, training and education, standards, and compliance requirements.
	- Logical Controls: Automated technical systems that authorise users, based on registered identities, use information systems, grant permission instances for the identity
	- Physical (PACS): Having a lock that requires two people
- Smart card is a combo of physical and logical

Access Control Technologies and Devices
- Objective of access control devices is to add an additional layer of protection to data access
- Devices can be used with other ID methods for MFA
- Two types
	-  Physical Security Tokens
		- "Something you have" - Pseudorandom number generator
		- Crypto one-time pad: Scanned near NFC, press button, key fob, smart card, smartphones, ect
	- Logical Control Tokens
		- Data packages generated by access control system
		- Contain information about authenticated user ID, privileges, and other info
		- Tokens used for handshakes, and have expiration time/date
- Biometrics - Who you are
	- Requires baseline measurements, which are then cryptographically hashed to go on smart card of other physical token

Single vs Multi-Factor Authentication (MFA)
- Single Factor Authentication - One type of evidence
	- Something you know
	- Something you have
	- Something you are or do
- Multi-Factor - Presenting more than one factor of proof
	- Location (geolocation)
	- Node Authentication - Endpoint as a factor

Federated Identity with a Third-Party Service
- Responsibility remains with organisation regardless of third-parties
- Third Party Services
	- Risk management planning 7 assessment
	- Security assessment and training 
	- Incident Response
	- Planning and Support
	- Identity Management
	- Full Access Control Services
	- IT system configuration management and control
	- Audit and compliance reporting
- IDoS - Identity as a Service
	- Identity governance and adminsitration (IGA)
		- Provisioning identity information into cloud platforms
		- Establishing/modifying privileges as required
	- Access
		- Providing real-time user/device authentication/authorisation, and supporting federate standards like SAML & OAuth
	- Intelligence
		- Logging, monitoring, reporting and alerting customers to identity access/activity events (accounting)
- Who employs sysadmins doing IAM?
	- In-house: Security/sysadmin directly employed by organisation
	- Third-party: Use of SLAs and contracts to have separate org deliver IAM services
- Where are the systems located?
	- On Premises: Physically located at business
	- Cloud hosted: Hosted computing infrastructure (public, private, or hybrid cloud)
	- Hybrid: Mix of on-prem & cloud

Registration, Proofing, and Establishment of Identity
- Digital Identity Guidelines of NIST SP 800-63-3
	- Includes recommendations to support requirement for identity proofing and registration
- Identity Assurance Levels - Identity proofing process
	- IAL1: Attributes are self-assert
	- IAL2: Identifying attributes have been verified in person or remotely to a minimum of the procedure given in SP 800 63A
	- IAL3: In-person identity proofing, must be verified by authorised credential service provider (CSP) through examination of physical documentation as per SP 800-63A
- Authenticator Assurance Level (AAL) - Authentication process
	- Federation Assurance Level (FAL) is the strength of assertion in a federated environment, used to communicate authentication and attributes to a replyng party (RP)

Federated Identity Management (FIM)
- Applied where one or more systems need to share common information
	- Allow logging in from those systems for access to all in the federation
	- Eg. Using LinkedIn to login to Twitter
- Two (widely-different) standards - SAML & OAuth