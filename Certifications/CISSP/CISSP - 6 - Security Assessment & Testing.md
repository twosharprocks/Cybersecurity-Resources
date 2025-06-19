#### **Learning Objectives**

- Identify and select security assessment approaches, frameworks, and standards. 
- Identify ethical and security implications of various control testing methods.
- Select applicable artifacts to meet compliance requirements (e.g., test results, log files, and other information).
- Explain the need for data-driven security decision-making.
- Identify key activities and process data associated with proper management of security practices.
- Describe organizational response to identified weaknesses.
- Identify exception handling procedures within organizational risk tolerance.
- Apply ethical practices to disclosure of test results.
- Examine the process of conducting security audits.
- Compare the purposes and requirements for conducting different types of audits.

#### **Key Topics**

- Design and Conduct Assessment and Audit
- Security Controls Testing
- Security Process Data
- Analyze Output and Report

---
Internal Audit and Assessment
- Determine if the security controls and meeting the organisations risk expectations
- Internal: May be done in preparation for external audit
	- Requires a consistent approach
	- Internal Assessment process Steps:
		- 1. Chartering
			- Management Commitment - Starts the assessment process
				- May require additional resources to begin
			- Scoping the Assessment - Responsibility of management
				- Range, and who will do the work
			- Stakeholder Engagement - Ensure it won't interrupt BAU, convey assessment activities
			- Risk Assessment - Done throughout assessment process
		- 2. Testing: Conduct of the work, engaging with scope
			- Vulnerability assessment
			- Penetration testing
		- 3. Reporting
			- Benchmark for tracking control performance
			- Tool to inform corrective activities & continuous improvment
			- Support external audit/assessment activities
		- 4. Remediation
			- Needs to align with organisation's practice
			- Corrective action needs to align with assessment results

External Audit and Assessment
- Meeting a compliance framework
- Process
	- Chartering - Responsibility of audited orgs governing body
		- Scope & objectivesis set, work is resource, management structure responsible
		- Often determined by compliance framworkauditing org
	- Pre-audit planning
	- Audit execution - Collect artifacts, perform tests, conduct interviews
	- Audit reporting - Determines if standards met
- Most common Audit Types
	- Compliance
	- Financial
	- Operational
	- Information Systems
	- Integrated
	- Forensic
- Pre-audit planning
	- Preparation of audit checklist, necessary artifacts, individuals to be interviewed, audit schedule

Third Party Audit and Assessment
- Service Providers - Cloud Service Providers (CSPs), Internet Service Providers (ISPs), Managed Security Service Providers (MSPs), consultants, advisors.
- Two different processes drive id and review of external vendors
	- Jointly determine responsibilities for security and compliance assessment, and audit activities.

Case Study: WannaCry
- May 2017 global ransomware attack
- EternalBlue exploit in Microsoft Windows
- Initial infection via phishing emails with malicious attachments
	- Encrypted target files and demanded ransom in bitcoin
	- UK's NHS experienced significant disruption
- Vulnerability assessment and pentesting - WannaCry used an exploit which already had a patch available
- Disaster Recovery - DR plans to restore impacted systems is essential (restore system functionality)
- Business Continuity Plans - Effective plans to enable orgs to sustain essential functions during disruption and facilitate prompt recovery (sharing threat intelligence and coordinated response)
- Awareness Training: WannaCry spread through phishing emails, so user education on social engineering is essential. (Cyber threats evolve, so awareness needs to be continuous)

Compliance and Substantive Testing
- Compliance Test
	- Determines if the control exists and is operating properly
- Substantive Test
	- Evaluates the proper operation of the process (by doing it)
	- Higher degree of assurance, takes more time and resources

Management Review and Approval
- ISO27001:2013 - Top management shall review the organisation's information security management system at planned intervals to ensure it's continuing suitability, adequacy and effectiveness
- Reviews
	- Excemptions from normal activities
	- Information from previous reviews
	- Ongoing metric
	- Results of audits
	- When security objectives have been met
	- Feedback from interested parties
	- Risk assessment reporting and plan management for handling risk
- Support continual improvement
- Best practice requires statistical methods and logging
- Compliance requirements, authorise use of system for business purpose

Log Reviews
- All major frameworks emphasise importance of logging
- ISO27001:2013
	- Event logs recording user activities, exceptions, faults and information security events should be produced, kepts and regularly reviewed
- NIST SP 800-92
	- Log reviews are component of log management, imperitive function for security assessment and testing as well as identifying security incidents, policy violations, fraud, and operational problems
	- Log reviews support audits, forensic analysis, org security baselines, and historical review can help identify vulnerability exploitation
- Gramm-Leach-Bliley Act (GLBA) - Financial Institutions to protect customer info. Log reviews can identify and rectify
- Sarbanes-Oxley Act (SOX) 2002 - Regulates financial and accounting practices, with regular log review supported to ID security violations
- Health Insurance Portability An Accountability Act (HIPAA) 1996 - Specific security practices for protecting patient health information. Minimum log retention of 6 years
- Payment Card Industry Data Security Standard (PCI DSS) - Security for storing, processing, or transmitting credit card data.

Logging Practices
- Four Key Practices
	- Prioritise log management appropriately 
		- What are the logging goals and requirements according to laws, regulations, and current org practices?
	- Establish policies and procedures
		- Ensure consistent approach throughout organisation to meet requirements under law and regulations (periodic audits to ensure policy compliance)
	- Create & Maintain secure log management
		- Consider SIEM for storage and analysis
	- Provide adequate support to staff with logging responsibilities
		- Training, resources, tools, documentation, technical guidance, information dissemination

Managed Services and Security Assessment
- Managed Services
	- Deliver IT or Information services
	- Deal in other services but have shared access to or use of the contracting org's assets, facilities, people, and information
	- Importance of supply chain security


Interview and Testing
- Interviews 
	- Often used to identify the differences between documented processes and actual work performance
	- Help assessors understand and clarify business practices, as well as organisational expectations
	- Interview subjects for an assessment should be defined in chartering process and explicitly named in pre-audit checklist
	- Depth and breadth of interview needs to be defined too.
	- Number of individuals and roles in the controls should be defined to ensure appropriate coverage
	- Proper documentation is essential (permission to record)
		- Notes are helpful but subject to interpretation
		- Interview artifacts may contain sensitive info - secure properly and consistent with classification  
- Testing
	- Comparing actual behaviour of system, process or activity under defined conditions with it's expected behaviour.
		- Successful test documents that expected and actual behaviour are consistent
	- Testing requires expected performance be esttablished before conducting test.
	- Historically large divide between testing and security assessment - testing done in development, assessment being ongoing/recurring.
	- Given constantly changing threat landscape, test techniques previously reserved for developers-only may be very useful in on-going or special-purpose security assessments

POA&M - Plan of Action and Milestones
- A structured document that outlines a plan to address identified weaknesses in an organization's security posture, particularly in cybersecurity. This document details the specific actions, responsible individuals, and milestones required to remediate vulnerabilities and improve security. 
- Key aspects of a POA&M:
	- **Identifies Weaknesses:** The POA&M starts by listing security weaknesses that need to be addressed. 
	- **Action Plan:** It outlines a detailed plan of action with specific steps to remediate those weaknesses. 
	- **Milestones:** It defines milestones to track progress and ensure timely completion of the action plan. 
	- **Accountability:** It assigns responsibilities to individuals or teams for specific actions. 
	- **Resource Allocation:** It details the resources (personnel, technology, funding) required for the remediation efforts. 
	- **Continuous Improvement:** The POA&M is a living document, continuously reviewed and updated to reflect changes in the security environment and ongoing improvement efforts.

Security Assessment Standards and Frameworks - NIST Risk Management Framework
- NIST Risk Management Framework (SP 800-37r2) - Standard for audits and control assessments
- Also
	- NIST Security and Privacy Controls for Information Systems and Organisation (SP 800-53 r5) - Functional approach providing customisable, flexible set of controls for protecting the security and privacy of information systems from wide variety of threats/risks. 
	- NIST Protecting Controlled Unclassified Information in Nonfederal Systems and organisations (SP 800-171r1) - Private companies take responsibility for information covered in this section when they become part of the federal gov supply chain

Availability Services
- Performance of availability services directly affects organisation's ability to meet compliance & customer commitments
- Backups
	- Planning availability services for backup/restoration is essential to almost every security control & compliance framework
- Roles and responsibilities
	- Development is an extension of organisation's risk management practice - work is directed by risks of data loss or system failure
- Compliance Requirements
	- ISO27001 Annex A:12.3 Backup is the principle addressing backups, but need for backups is through a variety of controls in the standard. FIPS 200 Control Families of Contingency Planning (CP) and Media Protection (MP) address US gov info system backups. HIPAA requires backups and business contingency plan, Trust Services Criteria (TSP) for Availability places expectations on organisations undergoing SOC2 auditing.

Remediation (Change management)
- CIP (Continual Improvement Processes 
	- Generally incremental but can plan significant change
	- Plan-Do-Check-Act cycle (PDCA) aka Shewhart/Deming Cycle
	- Six Sigma Approach (5 step)
		- Define the problem
		- Measure the current process and collect data
		- Analyse the data
		- Improve the current process
		- Control the future state process

Exception Handling
- Once an indicator establishes a control is not achieving agreed level of risk reduction, usual response is to improve the control
- Some circumstances appropriate response is to change risk tolerance
- Change Management process must engage system owner to determine proper action.
- Exceptions must be documented

Continuous Full-Cycle Testing
- Pen-testing is point-in-time
- Breach attack simulation tools automate testing tools
- Couple with threat intelligence integrated with organisation's change management
- Chaos engineering as another avenue for compromise response
	- Forced failure then track detection, incident response and recovery
	- Parts of organisation expected to respond are not informed of the test before, expected to treat the failure as if it were a real attack.

Managed Services and Security Assessment
- UK National Cyber Security Centre (NCSC) Principles of Supply Chain Security
	- Understand what needs to be protected and why
	- Know who your suppliers are and what their security looks like
	- Understand the security risk posed by your supply chain
	- Communication your view of security needs to suppliers
	- Set and communicate minimum security requirements for your suppliers
	- Build security considerations into contracting processes and require suppliers do the same
	- Meet your own security responsibilities as a supplier and consumer
	- Raise awareness of security within your supply chain
	- Provide support for security incidents
	- Build assurance activities into your approach to managing your supply chain
	- Encourage the continuous improvement of security within your supply chain
	- Build trust with suppliers
- ISO28000 series addresses development and application of supply chain security management

Misuse Case Testing
- Use case - way of using a system
- Scenario - description of interaction between individuals
- Abuse/Misuse cases
	- Sets of actions which could lead to system integrity failure, malfunction, or security compromises
	- Deliberate and malicious in intent, or accidental

Log Security
- ISO27001:2013 Control item 12.4.2 - "Logging facilities and log information should be protected against tampering and unauthorised access."
- Confidentiality - May contain sensitive info
- Integrity - Protect from alteration/destruction in transit/storage

Disaster Recovery (DR) and Business Continuity (BC)
- Compliance Requirements
	- NIST Special Publication 800-34 "Contingency Planning Guide for Federal Information Systems" (Roadmap for BC & DR planning in the US)
	- ISO27301 Business Continuity Information Systems (aligns with broad ISO22301 Business Continuity Management Systems - good practice for business implications and resilience activities)
- BC/DR Testing and Training Processes
	- Business Impact Analysis (BIA)
	- Desk Check, Walk-through, Tabletop, Simulation, Parallel, Full Cutover

Logging Practices
- Develop standard processes
	- Define requirements and goals
	- Develop policies - mandatory requirements and suggestions
- Requirements developed with management support
- Generally organisations should review logging data of most importance

Synthetic Transactions
- Process that mingles the information needed by both operations and assessment.
- Real User Monitoring (RUM)
	- Aka Real-user metrics, or end-user experience monitoring (EUM)
	- Passive monitoring based on web-monitoring services for continuous observation, tracking availability, functionality, and responsiveness
	- Some bottom-up forms of RUM capture server-side information
	- Top-down client-side RUM can directly see user interaction with application
	- RUM techniques not restricted to software - often used in call centres to indicate process quality, compliance issues, improvement, ect
- Synthetic Performance Monitoring
	- Aka Proactive monitoring
	- External agents run scripted transactions against web application
	- Has been done with lightweight & low-level agents, but increasingly need full web browser to process JavaScript, CSS and AJAX calls
- Systems/Processes that may Benefit
	- Website monitoring
	- Database monitoring
	- TCP Port monitoring
	- Service-level agreement validation
- Synthetic monitoring may add value by:
	- 24x7 application availability monitoring
	- Know if remote site is reachable
	- Understand performance impact of 3rd party apps
	- Monitor SaaS performance availability
	- Monitor performance availability for IaaS and PaaS
	- Test B2B web services that use Simple Object Access Protocol (SOAP), Representational State Transfer (REST), or other web technology
	- Monitor availability of critical database queries
	- Objectively measure SLAs
	- Analyse baseline and performance across geographies
	- Complement real-user monitoring by synthetically monitoring availability during low traffic periods
- Practical Example - Microsoft's System Center Operations Manager
	- Variety of syntheitc transactions to monitor databases, website and Transport Control Protocol (TCP) port usage.

Code Review During Planning and Design and Application and Development
- Code Review during planning and design
	- Security review of architechture and threat modelling are NOT security testing methods (but are important pre-requisites for later testing)
	- Methods to identify attack surface
- Architecture Security Review
	- Manual review of product architecture, requires archtectural model and allows detection of architecture violations of security standard
- Threat Modelling
	- Structured manual analysis of app-specific business case or usage, requires business case or usage and allows ID of threats
- Code Review During Application and Development
	- Static Analysis and Security Testing (SAST) - Find possible vulnerabilities without executing source code by detecting unsecure code practices (outdated libraries, misconfigurations, improper data type useage)
	- Static Binary Code Analysis and Manual Binary Review - Analysis of compiled application for finding vulnerabilities without app execution. Similar to source code analysis but not as precise and fixed recommendations can't be provided.

Code Review and Testing (Source Code Analysis and Review)
- Modern automated techniques to avoid manual review
- Objectives
	- All required functions exist
	- No foreign code
	- No dead-end or unreachable code
	- No backdoors or trapdoors
	- Coding standards have been met
	- All code is of trustworthy provenance
- 

Purpose of Audit and Assessment
- Formal Security Assessment
	- Independent evaluation against a compliance standard
	- Performed by individuals outside the audited entity's management structure
- Informal Security Assessment
	- Insights and observations about the systems being evaluated
	- Performed in-house, third party or both
- Audits or Assessments
	- Audit - Structured review of information to determine compliance. Generates artefacts
		- Elements of a Finding
			- Criteria, Effect, Recommendation, Cause, Condition
		- Reporting - To meet requirements
		- Compliance calendars
	- Assessment - Formal evaluation of controls to meet management expectations, primarily related to risk-management compliance (eg. Sarban's Oxley Act - SOX)
		- Include - Special purpose testing, inspection, analysis tasks
		- May be - At any level, any environment, use internal developers and testers, operational end users, third party assessment, or a mix
		- Scope determined by management

Negative Testing
- Designed to provide evidence of application behaviour in case of unexpected or invalid data. Trying to detect application failure during test rather than in production
	- Do not confuse with misuse testing (Safety-critical systems blur the line) 

Security Education, Training and Awareness (SETA)
- NIST 800-50 Building an Information Technology Security Awareness and Training Program
- Needs assessment can determine organisation's awareness and training needs
- Minimum following roles should be addressed
	- Executive management: Fully understand directives and laws that form basis of security program
	- Sysadmins and IT support: High degree of authority requires higher degree of technical knowledge in security implementation
	- System owners: Must have broad understanding of security policy & high degree of understanding of security controls
	- Security Personnel: Expert consultants and must be well educated on security policy and best practice
	- Operational managers and system users: High degree of security awareness and training on controls and system rules
- Sources of timely material: Email advisories, Professional organisations and vendors, Online IT security news, Periodicals, conferences/seminars/courses

Ethical Penetration Testing
- Chartering: RoE drafting
- Discovery: Identify potential breadth of environment. Recon activities
- Scanning: Weakness identification & fingerprinting
- Exploitation: Delivery and compromise documented
- Reporting: Activities performed with particular attention on results

Ethical Disclosure
- Legal obligations by assessor to report outside of organisation
- Non-disclosure: Safe harbor programs can run afoul of GDPR
- Full Disclosure: Motivate vendors to remediate weakness
- Responsible Disclosure: Time given to rememdiate before public disclosure. Project Zero, Vulnerabilities Equities Process (VEP)
- Mandatory Reporting: Laws governing disclosure
- Whistleblowing: Ethical obligation to disclose, may not have legal protection

Ethical Penetration Testing
- Must have signed contract in place
- Testers can be held liable for any disruptions
- Should not be confused with ethical hacking (attempts to detect vulnerabilities in software systems and products)
- Increasingly defined by compliance frameworks as part of best practice
- No single standard for ethical penetration testing

Interface Testing
- Testing different components of an application in combination
- Verifies distinct functions occur between components by design
- Assure quality of software products
- Performed by both testing and dev teams
- Verify interactions between application and server
- External Interface
	- Have all supported browsers been tested?
	- Can the site work without plugins?
	- Can all supported documents be supported/opened on all platforms

Account Management
- Identity store provides centralised repository for all identity information
- AAA - Authentication, Authorisation, Accounting
- User behaviour modelling to detect indicators requiring investigation

Test Coverage Analysis
- Percentage of software structure that's been evaluated during structural testing.
- "Statement coverage" generally means 100%
	- Each program statement to be executed at least once
- Decision (Branch) Coverage
	- Minimum level of coverage for most software products, insufficient for high-integrity apps
- Condition Coverage
	- Each condition in program decision on all possible outcomes at least once. Only different from Multi-condition Coverage when multiple conditions must be evaluated
- Multi-Condition Coverage - Combination of conditions
- Loop Coverage 
	- Execution coverage for zero, one, two, many iterations (initialisation, typical running, termination/boundary conditions)
- Correspondence between data/field types
	- Verify proper controls for data/field types (eg. date field cannot accept impossible dates)
- Data Flow Coverage
	- Data flow must be executed at least once
- Populating Required Fields
	- Test condition of leaving required fields unpopulated
- Path Coverage
	- Sufficient test cases for each feasible path from start to finish. Generally not achievable because of many paths through software program - amount of coverage is dependent on software criticality
- Allowed Number Characters
	- Verify limited number of characters accepted in a field (field 25 long should not accept 26)