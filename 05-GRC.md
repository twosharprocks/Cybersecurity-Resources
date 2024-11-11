# Governance, Risk & Compliance

GRC is a framework for asking <span style="text-decoration:underline;">“What assets are most important?”</span> and <span style="text-decoration:underline;">“What is adequate protection?”</span>
* <span style="text-decoration:underline;">Governance</span> - Creating management processes for implementing security practices across the organization. Codifying and enforcing proper behaviour and operations by establishing standards of “right” and “wrong”.
* <span style="text-decoration:underline;">Risk Management</span> - Identifying an organization’s most important assets and determining how they might be compromised
* <span style="text-decoration:underline;">Compliance</span> - Making sure the business follows internal security policies and adheres to relevant security laws. Enforcement of policies in order to meet standards.

**Security Culture Framework**
Security culture is the way members of an organization think about and approach security issues. A healthy security culture has employees who are invested in the organization’s security and “behave securely.”
* A healthy security culture requires motivating employees to value security, and training them on how to avoid insecure behavior.

<span style="text-decoration:underline;">Security Culture Framework Steps</span>
1. Measure & Set Goals - “Reduce employees clicking phishing links to 5%”
2. Involve The Right People - “CEO and/or CIO; HR/Training/Comms directors”
3. Create An Action Plan - Develop training to cover dangers of malware
4. Execute The Plan - Implement with goal of training 25% of employees per quarter.
5. Measure Change - Determine success/failure based on goals in Step 1
<span style="text-decoration:underline;">Security control</span> - Any system, process, or technology that protects the confidentiality, integrity, and availability of a resource.
* Administrative controls - Requiring unique usernames and passwords
* Technical controls - eg. Hiding the server behind a firewall that can only be accessed by the corporate VPN
* Physical controls - Doors/Turnstiles stopping unauthorised building access

Goals of Controls
* Preventative Controls - Prevent access with physical or technical barriers. 
* Deterrent Controls - Discourage attackers from attempting to access a resource
* Detective Controls - Identify and alert attempts to access a resource.
* Corrective Controls - Attempt to fix an incident, possibly stop it from happening again.
* Compensating Controls - Restore the function of compromised systems.

Layering security controls is a fundamental aspect of the security design framework known as <span style="text-decoration:underline;">defense in depth</span>. Multiple defenses to secure a resource provides mostly Confidentiality & Integrity (eg. Single server has three different controls).

<span style="text-decoration:underline;">Redundancy</span> is removing any single points of failure and is mostly concerned with Availability (eg. Having multiple servers cross-checking)

<span style="text-decoration:underline;">Deciding on Security Controls</span>
1. <span style="text-decoration:underline;">Required control type:</span> Should the control be physical, administrative, or technical?
2. <span style="text-decoration:underline;">Required strength of control:</span> How strong does the control really need to be?
3. <span style="text-decoration:underline;">Control Decisions: </span>
    1. Corrective control (eg. rolling back an app to a version without the issue)
    2. Administrative Control (eg. changing how users and how an app share data)
    3. Technical Control (eg. implementing 2FA, new features, new user workflow)
4. <span style="text-decoration:underline;">Cost of implementation:</span> How much does the control cost compared to the benefit provided?
5. <span style="text-decoration:underline;">Time of implementation:</span> How long will the control take to implement?

**Most professional security work is mandated by governance policies and subject to compliance audits.**
<span style="text-decoration:underline;">Regulations</span> - Detailed instructions on how laws should be enforced (eg. GPDR)
<span style="text-decoration:underline;">Policy:</span> Set of rules that inform standards for behaviour and operations (eg. Bring Your Own Device (BYOD) vs. Mobile Device Management (MDM))
<span style="text-decoration:underline;">Guidelines:</span> Similar to policies, as they are issued by organizations to make the actions of its employees or departments more predictable, and presumably of higher quality.
* Guidelines are not mandatory, only suggestions to be followed by those they apply.
<span style="text-decoration:underline;">Standards:</span> Published specifications used to establish a common language and technical criteria across an organization or industry.
<span style="text-decoration:underline;">Laws:</span> Policies written in legal language, and voted upon and passed by legislative bodies of government.
<span style="text-decoration:underline;">Due Care:</span> A reasonable person’s compliance and best efforts
<span style="text-decoration:underline;">Due Diligence:</span> Making a decision based on sufficient information
<span style="text-decoration:underline;">Governance Framework</span>: Defines the rules and policies that must be followed by everyone in an organization or industry. Organizations must use these frameworks to remain compliant with federal regulations and industry standards. are rules and policies.
* Internal/Volitional - Developed by company (setting a business goal)
* External/Imposed - Developed by standards bodies/gov (meeting legal requirements)
<span style="text-decoration:underline;">Risk Management Framework (RMF)</span> A set of standards that define best practices. An organization may voluntarily follow these to efficiently manage its cybersecurity risks.
* example: NIST’s (National Institue of Standards & Technology) framework uses _Identify, Protect, Detect, Respond, & Recover_
## Frameworks & Standards
[Useful Frameworks & Standards [Overview]](https://securitybase.com.au/articles/cyber-security-standards-and-frameworks-an-overview)
ISO27001 - [Overview (ISO.org)](https://www.iso.org/isoiec-27001-information-security.html)
NIST - [NIST Framework Documents](https://www.nist.gov/cyberframework/framework-documents)
SOC2 - [SOC for Service Organizations: Trust Services Criteria](https://us.aicpa.org/interestareas/frc/assuranceadvisoryservices/aicpasoc2report.html)
South Australian Cyber Security Framework (SACSF) - [Overview (sa.gov)](https://www.dpc.sa.gov.au/responsibilities/protective-security-framework/cyber-security/the-sacsf)
<span style="text-decoration:underline;">Australian Cyber Security Centre ([ACSC)](https://www.cyber.gov.au/)</span>
* [Information Security Manual](https://www.cyber.gov.au/acsc/view-all-content/ism)
* [Essential 8 Mitigation Strategies](https://www.cyber.gov.au/acsc/view-all-content/publications/essential-eight-maturity-model)
1. Application Whitelisting/Application Control
2. Application Patching
3. Configure Office Macros
4. Application Hardening
5. Restrict Administrator Privileges
6. Patch Operating Systems
7. MFA
8. Daily Backups
* [Essential 8 Maturity Model](https://www.cyber.gov.au/acsc/view-all-content/publications/essential-eight-maturity-model)
* <span style="text-decoration:underline;">Level Zero</span> - Weaknesses in the overall cyber security perimeter.
* <span style="text-decoration:underline;">Level One</span> - Adversaries with minimal tradecraft and resources usually seeking an opportunity rather than a target. Using publicly available exploits, vulnerable systems and common social engineering techniques to gain entry and launch malicious applications.
* <span style="text-decoration:underline;">Level Two</span> - A modest step-up in capability, these adversaries spend more time on a target as well as the effectiveness of their tools. Generally using similar techniques to a Level One, however spending far more time, money and effort in their attacking attempts.
* <span style="text-decoration:underline;">Level Three</span> - The highest level of attacker doesn’t require public exploits and are much more adaptive. They can target even the slightest of weaknesses in cyber security perimeters, exploiting and bypassing security controls. Once gaining access, they seek privileged credentials and pivot to other parts of the network whilst continually covering traces of their activities.

<span style="text-decoration:underline;">Contingency Planning for Business Continuity</span>
Two types of breach
1. <span style="text-decoration:underline;">Mild/moderate:</span> The business has been impacted, but can still handle day-to-day operations at greater cost.
2. <span style="text-decoration:underline;">Serious/catastrophic</span>: The business has been impacted so severely that it cannot operate. Instead, they must use their resources to contain the incident, recover from the disaster, and eventually return to operations.

<span style="text-decoration:underline;">Business Continuity Planning</span>: Focuses on processes and procedures to ensure business-critical functions continue **during and after** a disaster.
* <span style="text-decoration:underline;">Disaster Recovery</span>: Focuses on the specific steps an organization must take to resume work **after** a disaster.
* <span style="text-decoration:underline;">Contingency Policy Statement</span>: Establishes the organization’s framework and responsibilities for maintaining confidentiality, integrity, and availability of data. It includes:
* Responsibilities of an emergency response team
* Resource requirements
* Training requirements
* Schedule for plan maintenance

<span style="text-decoration:underline;">Business Impact Analysis (BIA) and Risk Assessment</span>
* Identify key processes and functions of the business.
* Establish a detailed list of requirements for business recovery.
* Determine the resource requirements needed to resume key processes.
* Evaluate impact on daily operations.
* Develop priorities and classifications of business processes and functions.
* Develop recovery time requirements.
* Determine financial, operations, and legal impact of disruptions

BIA helps inform the Disaster Recovery plan, specifically:
* <span style="text-decoration:underline;">Recovery Point Objective (RPO)</span>: Amount of data that a business can afford to lose/recover (given the most recent backup copy of the data) after a disruption or system outage.
* <span style="text-decoration:underline;">Maximum Tolerable Downtime (MTD)</span>: Total amount of time a system can 
afford to be unavailable for users and the business. This breaks down into:
    * <span style="text-decoration:underline;">Recovery Time Objective (RTO)</span>: Maximum tolerable amount of time needed to bring **all critical systems back online** after a disaster occurs.
    * <span style="text-decoration:underline;">Work Recovery Time (WRT)</span>: Time available to get the systems working again. WRT is the remainder of the MTD after the RTO. If MTD is four days and RTO is one day, WRT is three days.

Disaster Recovery can also use <span style="text-decoration:underline;">Alternate sites</span>;
* <span style="text-decoration:underline;">Hot Sites</span>: Ready at all times, equipment loaded with currently available data and can immediately continue operations. It is costly, but important for mission-critical data.
* <span style="text-decoration:underline;">Cold Site:</span> Very little existing infrastructure. It is not typically used until after a disaster occurs, so there must be a strategy for setting it up quickly when the time comes.
* <span style="text-decoration:underline;">Warm Site:</span> In-between, for example with servers, hardware, software, and other equipment set up but not loaded with the latest data.
## Threat Modelling
Threat Modelling Methologies
* [PASTA - Process for Attack Simulation and Threat Analysis](https://threat-modeling.com/pasta-threat-modeling/) 
    * Focuses on aligning considerations of business objectives with technical requirements.
* [STRIDE - Spoofing, Tampering, Repudiation, Information Disclosure, DoS, Elevation](https://www.softwaresecured.com/stride-threat-modeling/)
    * Focuses on identifying what can fail in the system being modelled.
* [OWASP - Open Web Application Security Project](https://owasp.org/www-community/Threat_Modeling)
    * Focuses on identifying possible threats, prioritizing risks, and planning mitigation strategies. It is mainly used with web and desktop applications.
        * Determine assessment scope
        * Identify threat agents.
        * Identify potential attacks.
        * Identify exploitable vulnerabilities.
        * Prioritize identified risks.
        * Mitigate risks.
## Risk Management
<span style="text-decoration:underline;">Quantitative analysis</span> focuses on hard, numerical data.
<span style="text-decoration:underline;">Qualitative analysis</span> focuses on things that cannot be measured through numerical data.
* Qualitative Risk Analysis is used when a complex evaluation of cost vs. benefit is unnecessary.
<span style="text-decoration:underline;">Asset value</span> is how much money an asset is worth in currency.
<span style="text-decoration:underline;">Exposure factor</span> is always somewhat subjective. We apply a numerical value for the level of damage an exploited risk would produce. (Can be 0.25, 0.5, 0.75, or 1.0)
* If a Mail server’s capability was reduced to 0%, the exposure factor is 1.0
<span style="text-decoration:underline;">Loss expectancy</span> is the measure of how much money an organization will lose in the event of a given breach.
* Single Loss Expectancy (SLE) = AV (Asset Value) x EF (Exposure Factor)
* Annual Rate of Occurence (ARO) = X (# of occurrences) / years
* Annual Loss Expectancy (ALE) = SLE x ARO

Loss Expectancy can be categorised as:
* <span style="text-decoration:underline;">Marginal</span> - The organization has the resources to respond to the breach immediately, without affecting day-to-day operations or revenue.
* <span style="text-decoration:underline;">Notable</span> - The organization has the resources to respond to the breach, but may not be able to do so immediately. May experience interruptions to operations.
* <span style="text-decoration:underline;">Severe</span> - The organization experiences serious interruptions to operations, and doesn’t have the monetary and/or personnel resources to respond effectively. May have to defer revenue, delay project timelines, reassign employees, or hire consultants to fix the issue.
* <span style="text-decoration:underline;">Catastrophic</span> - The organization suffers severe, lasting damage to its reputation and/or infrastructure. The future of the business is threatened by reputational damage, bankruptcy, being found in contempt of federal regulations, or other issues.

<span style="text-decoration:underline;">Risk matrix</span> is used to compare how many of the risks facing an organization are mild and how many are severe.
<span style="text-decoration:underline;">Heat map</span> is a visual representation of the probability and likelihood of risks. Organizations can use heat maps to make strategic decisions about how to protect the company.
## Device Approaches
[Device Approach Overview](https://www.wired.com/brandlab/2018/06/byod-cyod-cope-cobo-really-mean/) 

* BYOD - Bring Your Own Device ([Risks of BYOD](https://www.core.co.uk/blog/byod-effect-security-risks-personal-devices-work))
* CYOD - Choose Your Own Device (from a limited selection)
* COPE - Corporate Owned, Personally Enabled
* COBO - Corporate Owned, Business Only
