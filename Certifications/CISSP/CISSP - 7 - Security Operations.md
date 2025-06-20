#### **Learning Objectives**

- Describe the legal, organizational, and compliance requirements of investigation activities.
- Assess what makes logging practices effective and efficient.
- Describe the security implications, operations, and limitations of monitoring systems, including intrusion detection and prevention (IDS/IPS), security information and event management (SIEM), and user and entity behavior analytics (UEBA).
- Identify organizational enforcement approaches to support change management activities.
- Justify the use of increased automation of change activities in terms of systems and information security.
- Apply secure system design concepts, security models, and AC models to typical business and organizational processes.
- Understand the importance of media management and media protection techniques.
- Apply various incident response concepts and standards to incident response activities.
- Evaluate the impact of organizational culture and compliance expectations on incident response.
- Determine security implications for operational controls.
- Associate incident response activities with specific attack forms.
- Assess the security value of third-party services.
- Identify the necessity and challenges of patch management to address vulnerabilities.
- Relate organizational change management practices to information security.
- Identify change management standards.
- Describe established approaches to improving systems availability.
- Identify the key steps and resources necessary to support business continuity and recovery processes.
- Compare implementation and requirements of various types of testing for disaster recovery plans.
- Discuss participation in business continuity planning and various BC exercises.
- Identify information security implications of various physical controls.
- Assess information security implications of personnel safety practices.
#### **Key Topics**
- Investigations
- Logging and Monitoring Activities
- Configuration Management
- Security Operations Concepts
- Resource Protection
- Incident Management
- Detective and Preventative Measures
- Patch and Vulnerability Management
- Change Management
- Recovery Strategies
- Disaster Recovery Processes and Plans
- Business Continuity Planning and Exercises
- Physical Security
- Safety and Security Concerns

---
Evidence Collection and Handling
- Evidence
	- Data about the incident
	- Data/Systems/Media that may have been compromised
	- Information from people about the evidence
	- Information about the incident scene
- Take inventory of artifacts at incident scene
- Issue with cyber incident is that the scene can be geographically diverse
- Appoint evidence custodian
	- Responsible for chain of evidence
- Maintain chain of custody
	- Record of where and when, what form, where and handled when stored between collection and presentation
- Make backups at bit level without changing the data or state
- Make copies of all evidence (physical and digital)

Reporting and Documentation
- Admissibility - Evidence is acceptable to court
- Accuracy - Evidence is true and accurate
- Comprehensibility - Evidence is not withheld
- Objectivity - Evidence is not presented subjectively

Sandboxing
- Separating threat from network for analysis

Incident Response Activities - Mitigation 
- Containment (Quarantine) & Eradication
- Typical containment tactics might include:
	- Logical or Physical disconnection
	- Disabling outgoing/incoming connections from external services, applications, platforms, sites
	- Disconnecting key servers
	- Disconnecting extranets or VPNs
	- Disconnect internal network from ISP
	- Disable wifi and remote login
	- Disable internal users
	- Disconnect some/all external partners and user domains
- Hardening
- Eradication - identify and remove every instance of causal agent
	- Include all backup material
	- May need full low-level reformat of media

Third-Party Provided Security Services
- May Provide
	- Threat Intelligence
	- Network Monitoring
	- Physical Security
	- Network Management
	- Audit
- Due diligence on provider
	- Review of governance
	- Service-Level Agreements (SLAs)
	- Non-Disclosure Agreements (NDAs)
	- Insurance/Bonding
	- Audit/Testing
	- Strong contract Language
	- Regulatory Approval

Investigative Techniques
- Interviews
	- Enlist trained interviewers
	- Conduct multi-party interviews
	- Ensure preservation of subject's rights
	- Record when possible
- External Requests
	- Request info from others sources: ISPs, gov agencies, witnesses, ect. Can be formal or informal
- Automated Capture
	- Collecting and analysing incident data from normal logging
- Manual Capture
	- Audio interviews, video capture, ect

Incident Response Activities - Response
- NIST 800-61 Containment, Eradication, and Recovery
- ISO27035 - Responses
- Pareto Analysis (80/20 rule)
- Five Whys
- Fishbone diagrams - Causes
- Failure Mode Effects Analysis
- Fault Tress - Boolean logic to id failures

Maintaining the Integrity of an Investigation
- Respect and abide by ethical walls
- Abide by legal requirements
- Respect and support all aspects of evidence handling
- Respect and protect individual rights
- Follow appropriate communication channels

Travel
- Prior, During, and After
- In many countries, kidnapping is a well-established business model
- Foreign intelligence services will track every traveller
- Electronic surveillance networks can take advantage of facial and other biometric recognition tools

Implement Disaster Recovery Processes - Response
- Criteria for initiating response action: Dollar value, # of affected users, expected downtime, threat to human health/safety
- Personnel authorised to initiate BCDR action: Usually member of senior management
- Information stream/chain: To provide decision-maker with sufficient data

Security Information and Event Management (SIEM)
- Aggregation: Firewalls, IDS/IPS, Performance monitoring tools, Network devices, Endpoints, Anti-malware
- Normalisation: Standardising data presentation from multiple sources
- Correlation: Weighting to activities to calculate probabilities/significance
- Secure Storage; Must archive logs securely
- Analysis: Using scripts & heuristics
- Real-time monitoring: Active threat detection
- Reporting: Current/historic data distillation

User and Entity Behaviour Analytics (UEBA)
- Use templates from monitoring over time, may require training
- Convergence between SIEM and UEBA

Firewalls
- 4th Gen and Next gen incorporating IDS & IPS functions
- Need to consider risks as firewalls change themselves

Log Management
- Events can be:
	- Precursors - Signals suggesting change of conditions which may change threat landscape
	- Indicators - Signals from events suggesting security event is underway or has occurred (IOCs)
- Log Management practices
	- Logging Compliance and standards
	- Logging Policies
	- Logging Infrastructure
	- Log Generation, collection and normalisation
	- Log protection from creation to disposition
	- Log Review, Analytics, and reporting

Perimeter Security Controls
- Exterior
	- Property security line (eg. parking, building entrances)
- Interior
	- Within facility - any area directly controlled at direction of management
	- Protected areas - street level entrances, lobbies, loading docks elevators, sensitive internal areas
- Access Control Device presented to Access control system, with enrolment in identity management system

Least Privilege and Need-to-Know
- Minimum level of privilege to do their duties, and no more
- Establishing ethical walls
- RBAC to manage access and control

Major Change Management Activities - Patch Management Steps
- Receiving notice of the patch
- Determining applicability
- Determining potential impacts
- Testing the Patch
- Perform a full backup prior to application
- Apply the patch
- Confirm installation for all target systems
- Solicit/Receive user feedback
- Rollback if warranted
- Document

Separation of Duties
- No individual can complete a trusted process alone, eg Bi-furcated finance
- Do not share duties between;
	- System administrator & Network management
	- Data Entry & Computer Operations
	- Security administrator & security auditing
	- System development and maintenance
	- Information systems management
	- Change Management

Recovery Site Strategies
- Mirror Sites: Operate in parallel with production (two complete & up-to-date copies of everything)
- Hot Sites: Fully functional op sites with all necessary hardware/software/data to instantly handle critical functions
- Warm Sites: Similar to hot but don't have current data or functions for instant failover (hours to days)
-  Cold Sites: No hardware, software or data, utilities may be connected. (weeks to months)
- Mobile Sites: Portable on vehicle
- Cloud: Backup stored with cloud computing service provider
- Localised Impacts
	- Joint operating agreement (JOA)
	- Memorandum of Understanding (MOU)
- Alternate sites need to be far enough to avoid impacts on primary
- Consider relocation kits (BCDR team responsible for updating)

System Resilience, High Availability (HA), Quality of Service (QoS), and Fault Tolerance
- Sufficient spare components
- Clustering: Combining systems for full capacity if element fails
	- Active-passive operational load sharing
- Power: UPS and Generators

Security Training and Awareness
- Location-specific training and awareness for travellers
- Emergency Procedures
- Incident Reporting procedures
- User roles in incident detection/response
- Recognising attack attempts on individual users

Ingress and Egress Monitoring
- Ingress: Firewalls, gateways, remote authentication servers, IDS/IPS, SIEMs, Anti-malware solutions
- Egress: Data Loss/Leak Protection
	- Signature (Data types)
	- Pattern Matching (eg. two-word strings)
	- Labelling
	- DLP needs to work in conjunction with data protection effort
		- Data at rest, Data in motion, Data in use
	- Monitoring: Email, Portable media, FTP, Web posting, APIs
	- Data discovery, classification, categorisation
	- Enforcement: Training DLP tool, Attribution/Assigning, Stringency/Prevention
	- DLP for compliance, security, training and awareness, due diligence, Asset management

Security Orchestration, Automation, and Response (SOAR)
- Comparable to CI/CD: Process automation
- Collect, integrate and automate security functions
- Three processes
	- Orchestration: Bring it all together
	- Automation: Run/Play books (machine learning as option
	- Security response: 

Continuous Monitoring
- Information Security Continuous Monitoring (ISCM)
- NIST 800-137: Define, Establish, Implement, Analyse/Report, Respond, Review/Update

Honeypots & Honeynets
- Placed in network demilitarised zone (DMZ)
- Mimic architecture of actual environment
- Cannot invite someone onto property and then arrest for trespass
	- "Hackback" is illegal almost everywhere

Emergency Management
- Fire, Evacuation, Coordination with external services

Availability Controls
- Redundancy
- Failover (Switching)
- Fault Tolerance (Handle component failure)
- RAID (Redundant Array of independent disks)
- High-Availability Clusters (Failover clusters)
- Replication (Data in more than one site/node)