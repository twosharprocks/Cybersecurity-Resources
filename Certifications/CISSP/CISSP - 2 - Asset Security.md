2025-04-14 15:21
Status: #seed
Tags: [[CISSP Study]] [[Cyber]]
Reference: 

---
# Information Asset Security
#### **Learning Objectives**

- Identify, classify, and categorize information assets.  
- Explain the importance of treating information as an asset.
- Differentiate the IT asset management lifecycle from the data security lifecycle.​
- Relate the data states of in use, in transit, and at rest to the data lifecycle.​
- Relate the different roles that people and organizations have with respect to data.​
- Describe the different security control types and categories. ​
- Explain the use of data security standards and baselines to meet organizational compliance requirements.
#### **Key Topics**
- Provision Information & Assets Securely
- Information & Asset Handling
- Manage Data Life Cycle
- Appropriate Asset Retention
- Data Security Controls & Compliance
---
The IT Asset Management Life Cycle
- Resources: Materials + Supplies -> Assets -> Outcomes
- Assets remain with the organisation
	- Tangible assets are physical things/infrastructure (storage array or subsystem, processors running software)
	- Intangible assets is not physical (data in databases, software running the database, procedural knowledge)
- Planning
	- Establish alignment of assets with goals/objectives
		- Identify the IT asset
		- Total asset valuation to determine: Costs, Anticipated revenue, Competitive, Harm
- Acquiring the asset
	- Confidence that security considerations for design and use have been identified
	- Combination of
		- In-house development
		- Third-party development
		- Purchase or licencing of commercial systems elements
- Deployment: Training end users and support personnel on security
- Managing: Ongoing security assessment
- Retirement: Disposal and destruction, defensive briefing

Data destruction in Cloud Environments
- Challenge in certifying the destruction of the data
- PaaS as a solution

Information and Asset Ownership
- Information owner: person or org unit with primary responsibility for setting the required infosec & quality guidelines, policies, or asset requirements. Not always the one who created information, but they are accountable for it's creation and use.

Classification and Categorisation
- Inventory -> Determine/assign ownership -> value determination -> asset classification -> Protection determination
- Classification: Grouping sets of data/information/knowledge with comparable sensitivity

Case Study: Solarwinds
- Compromised software development process - injecting malicious code into software updates which provided access to customer environments
- Highlighted gaps in managing security requirements, especially software supply chain integrity
	- Failed to validate/verify source code
- Breach allowed unauthorised access to sensitive systems and data. Tighter access controls and principles of least privilege would have mitigated impact
- Incident jeopardised privacy by exposing sensitive data. Improived encryption and stronger anonymisation would have enhanced privacy
- Raised concerns about retention of compromised assets and catagorisation and possession of controls.

Establishing Information and Asset handling Requirements
- Media that stores data require physical & logical controls
- Media marking: Policies should be in place based on classification 
	- Physical label identifying sensitive info
		- Label should indicate if data is encrypted
		- Retention period & Point of Contact
		- If found without label, marked for highest possible until otherwise identified
	- Only designated personnel should have access
	- Individuals responsible should be properly trained
	- Logs and records kept to track handling of backup media

End of Life and End of Life Support
- Organisation's long term information security and retention policies may need to consider what happens to their data when the hardware/software/services support that data lose support

Data Security Life Cycle
- Creating: Generation or acquisition of new content. Classification is important.
- Storing: Committing the data to a storage media. Protection in accordance with classification
- Using: Accessed, viewed, processed or used. Requires data by unencrypted, with controls (DLP, DRM, access) in place to protect data
- Sharing: Shared with users, customers, partners third parties
- Archiving: Data leaving active use, long term storage.
- Disposing: Must consider data's classification level

Case Study: Facebook and Cambridge Analytica
- Unauthorised access and exploitation of personal data from ~87 million Facebook users
- Third-party app "This is Your Digital Life" - Cambridge Analytica used harvested data to produce psychological profiles to influence political opinions/behaviours.
- Criticism of Facebook for inadequate data protection, failure to ensure 3rd party adhered to it's policies.
- Lapses in user data management policies leading to improper access without user consent
- Cambridge Analytica exploited loopholes in Facebook's platform to access/collect data beyond intended restrictions
- Misuse of user data without their knowledge
- Improper retention of data by third-parties
- Unauthorised categorisation and possession of vast user data
- Facebook could have implemented stricter vetting for 3rd party apps, as well as audits of app compliance
- Facebook could have enforced principle of least privilege and granular controls
- Facebook did not effectively monitor or control how user data was used by 3rd-party apps
- Facebook should have implemented a rigorous data life cycle management process

Data Location
- Map out local and global requirements for data storage
- Who has access?
- What are the potential locations for the data?
- Where are the user's coming from (which locations, trusted or untrusted?)
- What controls are in place for each location?
- Which lifecycle phases will allow data to move between locations?
- How does data move?

Role of a Data Custodian
- Custody of assets that do NOT belong to them
- Responsibility to protect data while in custody according to policies, standards, procedures, baselines, and guidelines
	- Adhere to data policies/standards
	- Ensure appropriate user access and levels of security
	- Data integrity, storage, and archiving
- Should be supported/advised by security function

Data States
- Three basic states
	- Data at rest
		- Stored on media in any type or form. Not transmitted/processed
		- Easiest phase to protect: Identify all repositories, ensure secure access, define data protection, backups made to ensure availability
	- Data in transit
		- Currently travelling/moving
		- Risk of interception, resulting in integrity-loss and deception
		- Data-in-motion can be encrypted at data-level, network-level, or both
	- Data in Use
		- Being processed by applications or processes
		- Being generated, updated, appended, or erased (or being viewed)
		- In plain text - most vulnerable state, but still have controls such as DLP, DRM, and access controls

Data Management: Roles and Responsibilities
- Objectives
	- Clearly define roles associated with functions
	- Establish data ownership at all phases
	- Instil data accountability
	- Continuously maintain adequate and agreed upon data quality and metadata metrics
- Data Owner
	- Accountable for data collected/created
	- Best positioned to understand data's value
	- Individual/group Accountable for protecting it based on value
	- Responsible for:
		- Determining impact data has to organisation's mission
		- Understanding replacement cost
		- Knowing when information is no longer needed
	- Examples of Documentation
		- Ownership, intellectual property rights, and copyright of data
		- Obligations to ensure data meets compliance requirements
		- Data protection expectations and responsibilities delegated to data custodians and others

---
Data Collection
- Collection: First step in data life cycle - Creation/acquisition
- Important to appoint data owners and assign classification so security controls can be implemented as early as possible

Data Maintenance
- Maintaining confidentiality, integrity, and availability
- Data-at-rest, Data-in-transit, data-in-use

Data Retention (Record retention)
- How long to keep data/assets, and when to destroy
- Driven by compliance or corporate requirements
- Retention Requirements
	- Understand where data exists
		- Need to know where it resides in order to retain/archive
		- Need to know how different pieces of data relate to one another across the enterprise
	- Classify and Define Data
		- Define what data needs to be archived and for how long based on laws, regulations, and corporate requirements
	- Archive and Manage Data
		- Based on business access needs, defined by policy while allowing timely, authorised access
	- Data Retention Strategy
		- Must involve most important stakeholders in the process to align organisational goals/objectives with legal requirements
		- Define clear lines of accountability
		- Establish common objectives for supporting data retention best practices

Data Remanence
- Residual data remaining on some sort of media after deletion/erasure
- Dependent on the security of the data that was stored on the media - if it's important and possible to recover, then most secure sanitization is required

Data Destruction for SSDs
- "Flash memory" cannot be overwritten
- SSD Manufacturers include built-in sanitization commands to internally erase data (issues if the commands aren't configured correctly)
- Cryptographic Erasure (Crypto-erase)
	- Erasing the encryption key makes the data unreadable
- Require specialist erasure techniques to avoid data remanence
	- Combine overwriting, crypto-erase, and sanitization

Generally Accepted Principles
- Information System Security Objectives
	- Confidentiality, Integrity, Availability
- External Systems are Assumed to be Unsecure
	- If it's not under your control, it's not secure
- Auditability and Accountability
	- Auditability: Ability to verify activities in a system (audit trails, systems logs, alarms, notifications)
	- Accountability: Ability to audit the actions of all parties/processes that interact with a system (clearly defined roles & responsibilities with authorised sensitivity level)
- Prevent, Detect, Respond, Recover
	- Preventive measures avoid/deter undesirable event
	- Detective measures identify occurrence of an undesireable event
	- Response measures contain the damage of an undesirable event
	- Recovery measures restore confidentiality, integrity, and availability of information systems to their expected state.
- Resilience for Critical Information Systems
	- All critical information systems need to be resilient to major disruptive events
- Protection of Information in use, in transit, and at rest
	- Security should be considered and implemented based on sensitivity when data is in use (processed), in transit (moving), or at rest (storage)

Standards Selection (Frameworks)
- PCI-DSS, ISO27001, GDPR, NIST-800 
- NIST, ENISA, ITU, ISO

Baseline (USGCB) and Baseline Security System ISKE
- United States Government Configuration Baseline (USCGB)
	- Federal government-wide guidance to agencies on security configuration setting
- Estonian Information System’s Authority IT Baseline Security System ISKE
	- Information security standard developed for the Estonian public sector.
	- Based on Germany's "IT-Grundschutz" (IT Baseline Protection Manual)
	- Three-baseline system depending on the needs of the entity managing the data

Scoping and Tailoring - Necessary environment and risks
- Scoping: Limiting the baseline recommendations to those that apply
	- Provides specific terms & conditions on control applicability
	- Can impact how controls are applied
	- Plans should identify which controls use scoping guidance
	- Application of scoping must be reviewed & approved
- Tailoring: Altering baseline recommendations so they apply more specifically
	- Involves scoping the assessment to more closely match system and environment
	- Provide flexibility in assessment approaches while still meeting assessment requirements
	- Tailoring Rationale
		- Control allocation & placement
		- Operational/Environmental considerations
		- Security objectives
		- Technology considerations
		- Selecting compensating security controls
		- Assigning security control parameter values
		- Supplementing security control baselines
		- Control enhancement

Data Protection Methods
- Baseline is a consistent, minimum security reference point, and helpful for achieving protection levels based on value
	- Technology: Might set a Windows machine, or an architechture
	- Non-Tech: Eg. Display ID badges or Escorting visitors
- Questions for applying baselines
	- Which parts can have the same baseline?
	- Should the same baseline be applied throughout the organisation?
	- How will the controls forming the baselines be determined?




---
**This reminds me of**... 

---
# Other References
