#### **Learning Objectives**

- Explain the value and use of secure coding standards, guidelines, frameworks, and architectural concepts.
- Differentiate between major secure coding and management methodologies to support selection of organizational software development practices.
- Explain the security implications of managing software development, deployment, and support, including: Security advantages of mature programming environments and tool sets, risks and benefits of code repositories and libraries, value of integrated development environments (IDEs).
- Contrast legacy software configuration management (CM) approaches with automated configuration tools.
- Identify approaches for appropriate security testing in systems development environments.
- Identify methods and artifacts that would support security assessment of third-party vendors, COTS and commodity systems, and orphaned systems elements.
- Explain the software security assessment issues that arise during organizational mergers and acquisitions.
- Identify and understand major causes of security issues in source code, database and data warehouse systems, and web environments.

#### **Key Topics**

- Assess Effectiveness
- SDLC
- Secure Guidelines and Standards
- Security Impact of Acquired Software
- Software Security Controls

---
Making Software Secure by Design, Build and Development
- Two scenarios: New project, or existing software products without security process

Software Development Methodologies
- Collection of managed activities to translate end user needs for function and capability into a software system that meets those needs
- Security needs to be balanced against time, money and other resources
- Fast, Lean Development Methods: 
- Reuse Model - built from existing and tested components, most widely used approach, often most poorly managed
- Spiral Method - Nested & improved version of waterfall, uses 4-substaged in "Deming Cycle" (Plan, Do, Check, Act)
- Prototyping - Build simplified version of entire application, release for review, use feedback to build 2nd version
- Modified Prototype Model (MPM) - Refined prototyping model, application evolves with the organisation.
- Cleanroom - Focused on controlling/avoiding defects/bugs in software. Write code correctly the first time rather than bug hunt later
- Extreme Programming - Values of simplicity, communication, feedback all combined into process. Structured approach to software development, subprojects of limited & defined scope using developers always in pairs. Owner needs to be involved in defining the software needs.
- Agile Development - Small team focused on collaborative, iterative learning, building, testing and deploying capabilities. "Scrum", "Sprint", "Safe".
- Devops - Development and Operations. Plan, Code, Build, Test, Release, Deploy, Operate, Monitor (loop back to Plan). 
- DevSecOps - As above but introduces security at every stage as part of quality assurance.

Acceptance, Transition to Production, and Revisions and System Replacement
- Security Testing: Application meets security requirements outlined earlier, Strives to uncover design/implementation flaws that allow security policy bypass, and first phase of certification/accreditation process
- Test in environment which simulates production as much as possible
- Testing, Acceptance, Production
- Baselines should be tested/audited periodically
- Change Requests must be managed through change management
- Periodic application audits

Software Defined Security (SDS)
- Difference between client-server-based model and fully cloud-based model with no on-prem architecture beyond internet presence and local access
- Centralised control/management for all network segments
- Greater shift to virtualised security, remove hardware dependencies
- Enables security policies to shift to on-demand, agile/adaptable
- Eliminate older converged protocols like MPLS through flexible overlays & network sharing
- Make threat intelligence predictive rather than reactive (combination of machine & human learning)
- Can act as bridge to holistic, all-source risk management/mitigation
- IAM is vital
- Entities and Users must be tracked, defined, authenticated, managed, and tracked
- Defense must be proactive, agile, flexible, and responsive
- Zero trust enables and is required by SDS solutions

Data-Centric Vulnerabilities
- Software Threat Modelling: Performed during software design
- Data-centric: Brings together attack and defence side's information to review data of interest
- NIST SP 800-154

Secure Software and System Needs for Configuration Management
- "If you can't measure it, then you can't manage it"
- Configuration Management (CM) process is to manage and control system elements and configurations over the life cycle

Operation and Maintenance
- Testing backup and recovery procedures 
- Ensure proper controls for data, reports, and the effectiveness of security controls and processes
- Periodic risk analysis and recertification of sensitive applications as required (eg. major changes, reclassifications, new software, ect)

Testing, Verification, and Security Assessment
- Repairs, maintenance, updates for all systems need to be acceptance tested to verify functionality.
- Regression testing required to ensure modifications didn't introduce erroneous elements

OWASP Top 10 Web App Security Risks
- 2021-Broken Access Control
- 2021-Injection
- 2021-Security Misconfiguration
- 2021-Identification and Authentication Failures
- 2021-Security Logging and Monitoring Failures
- 2021-Cryptographic Failures
- 2021-Insecure Design
- 2021-Vulnerable and Outdated Components
- 2021-Software and Data Integrity Failures
- 2021-Server Side Request Forgery

Software Acquisition via Third-Party Development
- Contract should determine testing, timelines, ect
- Security needs to be built-in from the beginning
- CMM - Capability Maturity Models
- Many CMM's may not include security & quality assurance

Toolsets, Libraries, Repositories, and Integrated Development Environments (IDEs)
- C, C#, and C++ standard libraries
- Framework Class Library (FCL) for the .NET Framework
- Java Class Library (JCL) 
- Ruby Standard Library
- Software libraries offer: Increased dependability, reduced process risk, effective use of specialists, accelerated development, standards compliance

Continuous Integration (CI) and Continuous Delivery (CD)
- CI: Integrating code changes frequently and automatic testing
- CD: Extends this further by deploying (sometimes to production)
- CI/CD automates software development pipeline processes
- Faster development using CI/CD often means less security

OWASP Maturity Models
- Software Assurance Maturity Model (SAMM)
- Business Functions: Governance, design, implementation, verification, and operations

Software (Quality) Assurance
- Proper functioning of Software Systems determines the system:
	- performs all intended and required functions
	- Does not perform other unintended or unauthorised functions
	- Is free from security vulnerabilities
	- Is free from and protected against insertion of errors in design, code, form, function and data at any point in the lifecycle
- Functional Requirements: Specific thing system must do
- Non-functional requirements: Characteristics of overall form or attributes of behaviour
- Process
	- Planned and systematic set of activities, processes, or steps to gather & evaluate data, and determine overall quality
	- Confidence in software's ability to fulfil needs safely and securely
	- Organised around workflows - Sets of tasks to perform, conditions that trigger workflow execution, outcome reporting, distributed & used
		- Workflows 
			- Cover any span of activities at any phase of lifecycle, 
			- Reflect whether software & system elements are built in-house, freeware, or licenced
			- Manage security assessment testing, operational evaluation, regression testing, and ethical pentesting
	- All assessment activities must provide effective feedback

Designing and Writing Software: Procedural vs Object-oriented Concepts
- Code Re-Use: Encourage programmers to re-use rather than reinvent software units
- Refactoring: Rewriting code to perform the same function but more efficiently
- Data Quality Standards & Practices: Reduce/eliminate many vulnerabilities by imposing standardised data declarations
- Data Modelling: Design process to ID data elements that need input, create, store, modify, output and destroy during operation.
- Add/Change Functionality
- Security practices: Can dictate use of pre-approved software libraries

Designing and Writing Software
- Development process ensures all user needs from the software are translated into system actions
- Requirements
	- Emerging Properties: Alternate way of looking at system-level behaviour
	- Functional Requirements: Task/Process system must perform
	- Non-Functional: Broad characteristics (many times safety, security, privacy & resilience deemed non-functional by system engineers/analysts)

Vulnerabilities Across the Software Build/Use Cycle
- Time of check (ToC) or Time-of-use (ToU)
- Race condition vs ToS & ToU
- Between the lines
- Trapdoor
- Backdoor

Open-Source Software and Security Assessment
- Linus's law: All bugs in code become apparent with enough eyeballs looking at it
- "Security by obscurity" does not generally work

REST-based API Security Recommendations
- Employ the same security mechanisms for APIs as you do for any other web application
- Do not create and implement your own security solutions (use a framework or existing library)
- Do not use single-key based authentication for an API unless it's a free, read-only public API
- Do not pass unencrypted static encryption keys (encrypt it if sending over HTTP)
- Use Hash-based authentication code (HMAC) such as SHA-2 or SHA-3 (avoid SHA-1 or MD5)

Controls for Incomplete Parameter Checking and Enforcement
- Buffer overflow prevention
	- Enforce bounds checking
	- Design frameworks for secure coding
	- Use programming language that enforces strong data typing while isolating code from data
	- Detect, intercept, and properly respond to error conditions
- Part of proper parameter validation
- Websites use filters as part of access control
- Requests using SQL injection (#1 on 2017 OWASP Top 10)
- XSS (Cross-Site Scripting) (#7 of OWASP Top 10)
	- Script execution from browser

Software Assurance and Security Assessment
- Applied software risk management
- Planning, Security Needs, Risk Assessment, Systems/Process Quality, Risk Controls, Ongoing Assessment

Secure Coding Guidelines and Standards
- Encourage devs to follow standard guidelines over personal preferences
- Address proper security requirements based on org needs
- Coding Standards: CERT, OWASP

Managed Services and Security Assessment
- Managed Services: 3rd party taking over function/responsibility of business function, used under contract & SLA
	- Deliver IT or info services
	- Deal in other services with shared access to org assets, facilities, people, and info
- Importance of Supply Chain Security

Memory or Other Object Reuse
- Allocation and Deallocation based on memory addresses
- Memory Leak: Content being left behind & read by the next process
- All systems should ensure content of any memory are randomised, zeroed, or overwritten before reallocation
	- Risk of unprotected paging/swap files

IDE's Program Execution, and the Runtime Environment
- Runtime System: Collection of all hardware/software components that allow an application to run on a system
- Type-checking, Java Runtime-Environment (JRE)

Toolsets, Libraries, Repositories, and Integrated Development Environments (IDEs): Programming Tools and Toolsets
- Tools: Binary compatibility, Bug Database, Build tools, code coverage, debuggers, doc generators, source code editors/generators, static code analysis, Unit testing tools

Project Initiation & Planning, Functional Requirements, System Design Specs, and Development & Implementation
- 1 - Project Initiation & Planning
	- Project justification - Objectives, scope
	- Establish user requirements (determine security requirements), Identify alternatives (conduct risk analysis), Select/Approve Approach (Define security strategy)
	- Future needs - Security needs
- 2 - Functional Requirements - Identify security areas
- 3 - Design specs - System architecture, inputs/outputs/data flow, security test plans & baselines
- 4 - Development & Implementation - Develop security code, Evaluated Security Code, Document Security Code
	- Code review is vital and takes time

Limit Reuse to Trusted Libraries
- Generally tweaking and code reuse rather than whole new scripts
- Teams need to set firm limits for code reuse
- Change Management for changes/additions to code libraries

Object-Oriented Technology and Programming (OOP)
- Centered on "objects" rather than actions
- Traditional is input, processing, output
- Object-oriented focuses on objects we want to manipulate rather than logic required to manipulate it
- Data Modelling
	- Object is a block of preassembled programming code in a self-contained module
- Languages: Java, Python, C++, C#, Ruby, Curl, Smalltalk, Delphi, Eiffel

Development and Implementation
- Controls coded into a system might be data validation, logging and monitoring, version control
- Might also include testing and integrity controls for program & application, operating instructions & procedures, utilities, privileged functions, Job and system documentation, components (hardware/software/files/databases/reports/users), restart & recovery, syntax, timestamps, before & after images, internal checks, parameter ranges & data types, valid and legal address, completion codes, peer code review.

Buffer Overflow
- Can be created/exploited in wide variety of ways
- Exists when buffer experiences more data than it can handle
	- System writes excess to system memory
- Highly dependent on app's runtime environment
	- Attack allows new instructions to be executed from system memory

Security of Code Repositories
- Ensure safely of application code during development, in use, and at rest
- Protection of code repositories needs to be managed the same as any other asset

Software Assurance During Acquisition
- Planning: Initial ID of possible need
	- Security involves: statements of need, sizing/scoping/estimates, risk assessment completed, alternates, Return on Investment (ROI), software requirements into Statement of work (SOW), deliverables, acquisition strategy, bid evaluation criteria
- Contracting: Seek competent, qualified suppliers
	- Security involves: Request for proposal with statement of work, Evaluating supplier proposals, software risk mitigation
- Monitoring, Acceptance and Deployment Phase
	- Establishing and consenting to contract schedule
	- Implementing change/config control procedures
	- Reviewing and accepting software deliverables
- Ongoing Use and Support
	- Sustainment - risk management, assurance, change management
	- Disposal/Decommissioning

Strong Data Typing and Structure Enforcement by Programming Language
- "Strongly typed" language vs "Weakly typed"
- Arrays stay in bounds, control/restrict pointers
- Type-checking
- Memory access through pointers is main cause for weaknesses/exploits in C or C++
- Java does "Static type checking" to examine arguments & check of correct type

Mergers and Acquisitions: Special Issues Regarding Software, Databases, and System Security Assessment
- Difference in config management, baseline ID and control of IT/Info assets
- Missing asset/risk inventories, risk mitigations, control strategies, plans/processes
- New organisation may bring significant existing security vulnerabilities
- Security inventory often low priority, with pressure to contain costs after acquisition

Other Common Software Attack Vectors
- Between-the-lines: Authorised user is tapped into data falsely inserted. Prevented by physically securing telecommunication lines
- Trapdoor/Backdoor: Hidden mechanism to bypass access control measures (often called a "maintenance hook")
- Social Engineering: Deception/intimidation to influence/guide/persuade someone in organisation to provide information to someone who should not have it.

Maturity Models for Secure Software Development
- SW-CMM - SEI's "Capability Maturity Model"
- 5 levels
	- Initial - unpredictable, poorly controlled
	- Repeatable - More organised, often reactive
	- Defined - Well-characterised processes, proactive
	- Managed - Controlled with quantitative techniques
	- Optimising - Continually improved

Regression Testing, Security Assessment Testing, and Testing and Evaluation of Controls
- Regression Testing: Testing changes/updates to existing software
- Security Assessment Testing: Ethical pentesting to demo present, in-situ system security state
- Control Testing/Evaluation: Carefully select test scenarios
	- Good Test Data: Data validation, bounds checking, Sanitised test data, clear segregation between testing & production

Polyinstantiation
- Object-oriented programming (OOP)
	- Prevent inference possibilities (deduce sensitive info by observing authorised info)
	- Allows different versions of same info depending on classification
- In OOP, all defined ranges and data values referred to as objects
- Steps in OOP
	- Objects: Data modelling, Classified as class of objects, defined as data kind contained, assigned logic sequence that can manipulate object
	- Method: Each distinct logic sequence, provides computer instructions
	- Object: Real instance of a class, class object characteristics provide relevant data
	- Messages: Comms between objects
- OOP programs use and reuse code blocks (objects)
	- Boosts security by using well-defined security objects

Acceptance Testing
- Formal test to determine if the system satisfies acceptance criteria (originally called "functional testing")

Security of Application Programming Interfaces (APIs)
- Automation connectors using exposed digital assets
- Granular control of target hardware/applications with code snippets
- IoT requires APIs for inter-device communication
- Data governance: security framework for structured/controlled development/deployment of APIs

Dynamic and Static Analysis
- DAST - Dynamic Application Security Testing. 
	- Simulates attacks against applications like web-apps, services, APIs to determine if vulnerable
	- Hybrid, concolic, symbolic, and simulated execution methods
	- Dynamic analysis generally associated with binary analysis
	- Specialised Application Testing
	- Dynamic Binary Analysis
	- Dynamic Source Analysis
- SAST - Static Application Security Testing
	- Typically at programming/testing life cycle phases
	- Finding hardcoded passwords/secrets
	- Static Binary Analysis - programmatic weakness in executable code, generally with subject matter expert
	- Static Source Analysis - Sometimes use tools

IDEs: Tools, Libraries and Repositories
- IDEs: Integrated Development Environments
	- For OOP: class browser, class hierarcy diagrams, object inspector

Programming Language Generations
- Generation 1: machine languages (binary/hex), operating codes (opcodes), object code used by computer itself. Generally simple instructions to CPU & coded in binary or object code
	- Rarely used except for malware reverse engineering or malware exploiting memory/storage violations
- Generation 2: Assembly language. 
	- Often used for security-sensitive functions within operating system kernels, device drivers, other critical functions.
- Generation 3: High-order languages, use meaningful words to give commands. 
	- COBOL, FORTRAN, BASIC, Java, and C
- Generation 4: Very high level languages, report & application generators
- Generation 5: Natural Language interfaces, aka constraint-based or logic programming
	- Largely fallen from use outside of limited academia/research

Standard Libraries, Other Libraries, and Software Reuse
- Standard library: Available across implementation of programming language. Include definitions for common algorithms, data structures, mechanisms that can be reused
- Poor code inspection that inherits risk

Designing & Writing Software: Procedural vs Object-Oriented Concepts
- Process-driven: Executable, Nested, different instances run independent of each other, encapsulate data/knowledge/logic/procedures, Use variety of instructions
- Also called jobs, tasks, duties, ect.
- Procedural thinking: Step-by-step tasks
- Object-oriented thinking: Ideas, steps, data, logic bundled into logical whole

Common Exploitable Software Source Code Errors
- Experience at Writing/Reading Source Code will help confirm it: 
	- performs correctly, 
	- does not replicate/contain errors, 
	- does not allow other functions, 
	- runs efficiently, 
	- meets/exceeds security requirements

Orphaned Software and System Security Assessment
- End of support, cost of OS-dependent software
- Legacy - Supported in-house or 3rd party (open to remediation)
- Orphaned - Unsupportable (replace or abandon)
	- Refactoring of business process

Auditing and Logging of Changes
- Configuration Identification (CIs) - Determines baseline
	- 4 categories: hardware, software, interfaces, documentation
- Configuration Management (CM)
- Configuration Control (CC) - All baseline changes done with knowledge/evaluation/consent of management
- Configuration Status Accounting - Recording/reporting configuration item descriptions, and changes made since baseline established
- Configuration Audit - Internal audit of artifacts & activities

Software Assurance Policy
- Documented, well-written, and well shared
- Avoiding deployment of malicious or vulnerable software

Advanced Persistent Threat and Insider Threat
- APT: Establish and extend presence in info tech infrastructure to continually exfiltrate information and undermine/impede critical aspects of organisation. Adapts and resists defender efforts to stop it.
- Insider Threat: Ignorance and negligence (over malicious action) are major causes of security breaches and incidents

Object-Oriented Programming (OOP)
- Characteristics: Encapsulation (data hiding), Inheritance (subclasses that share characteristics), Polymorphism (object changes do not have to ripple out to every program using it), different data types (ensure secure methods remain through changing characteristics)
