# Interview Prep
[Preparing for a Security Engineering Interview](https://tryhackme.com/r/resources/blog/security-engineer-interview-guide)
* Research the company - Recent news articles & Glassdoor, investigate website, company values, specific security challenges
* Stay up to date - OWASP Top 10, CVE's, NIST/ISO frameworks, reports from Microsoft, Crowdstrike, Symantec, ect

## Common "getting to know you" questions you may encounter:
   * What sparked your interest in cyber security?
   * How do you stay up-to-date with the latest cybersecurity trends and threats? Are there any security blogs, forums, or conferences you follow?
   * What are your greatest strengths and accomplishments?
   * How do you prioritise tasks and manage your time effectively, especially when dealing with multiple security incidents or projects simultaneously?
   * Describe a challenging situation you faced in a previous job (or during your learning experience) and how you resolved it. What did you learn from that experience?
   * What motivates you to work in a high-pressure environment where security incidents may occur at any time?
 
## Common Security Questions:
`How do you ensure that a server is secure?
Firstly, we need to ensure that strict access controls are implemented along with role-based permissions. Secondly, encrypting data in transit with TLS and data at rest using strong encryption methods. Regularly patching and updating the server is essential to fix known vulnerabilities. Implementing intrusion detection and prevention systems, conducting regular security audits, and having an incident response plan complete the strategy, providing robust protection against potential threats. Note: The security or hardening of any device is very relative and depends on the usage and deployment. For example, an email server being accessed by thousands of users would be secured differently than an FTP server dedicated for intranet.

Some relevant resources include: 
* Microsoft Windows Hardening - To learn key attack vectors used by hackers and how to protect yourself using different hardening techniques
* Linux System Hardening - Learn how to improve the security posture of your Linux systems
* Active Directory Hardening - To learn basic concepts regarding Active Directory attacks and mitigation measures

`What is the difference between HIDS and NIDS?
Host-based Intrusion Detection Systems (HIDS) are primarily focused on monitoring and protecting individual hosts or devices within a network, whereas Network-based Intrusion Detection Systems (NIDS) are designed to monitor network traffic at the network perimeter or on specific segments. An example of HIDS could be an antivirus software that scans files for malicious behaviour, while Suricata is an example of open-source NIDS that can be deployed at network to scan incoming and outgoing internet traffic.

`Explain a brute force attack along with the steps to prevent it.
A brute force attack is an attempt to gain unauthorised access by systematically trying all possible combinations of passwords or encryption keys. To prevent it, use strong, complex passwords, implement account lockout policies after a certain number of failed login attempts, and employ multi-factor authentication (MFA) to add an extra layer of security. Additionally, rate-limit login attempts and consider using CAPTCHA or intrusion detection systems to detect and block repeated failed login attempts from suspicious sources.

`How frequently should you perform patch management?
Patch management frequency should align with the criticality of systems and the severity of vulnerabilities. For critical systems, apply patches immediately upon release, especially for high-risk vulnerabilities
Less critical systems can follow a regular patch cycle, like monthly or quarterly, with thorough testing
Emergency patches should be patched immediately. Regular vulnerability assessments, compliance requirements, threat monitoring, and a risk-based approach should guide the patch management schedule to balance security and operational stability effectively.

`What is ARP poisoning?
ARP poisoning is a cyber-attack where an attacker manipulates the Address Resolution Protocol (ARP) tables on a local network. By sending fake ARP messages, the attacker associates their MAC address with the IP address of another legitimate device on the network. This enables them to intercept or redirect network traffic intended for the targeted device, potentially allowing for eavesdropping, data manipulation, or denial of service. It's a common attack vector in LANs and can be used for malicious purposes. This question highlights the importance of understanding networking concepts, so we strongly advise a recap with our Network Fundamentals module, which talks you through the core concepts of how computers communicate with each other and types of network weaknesses.

`Explain active reconnaissance.
Active reconnaissance in security engineering involves the deliberate and direct probing of a target's network or systems by an attacker to gather specific information about vulnerabilities, open ports, services, and configurations. This proactive approach helps attackers identify potential weaknesses and entry points to plan and execute cyber-attacks effectively.

`What are the different types of reconnaissance techniques? Please give some examples.
The two fundamental categories are passive reconnaissance and active reconnaissance. Passive reconnaissance involves collecting information about a target system or network without directly interacting with it. This type of reconnaissance is non-intrusive and relies on publicly available data and open-source intelligence (OSINT). Active reconnaissance involves direct interactions with the target system or network to gather information. It is more intrusive and may include activities that can be detected by security measures. You can practice this by completing the Active Reconnaissance room in our Network Security module!

`What is SYN/ACK, and how does it work?
SYN/ACK is a communication process in the TCP (Transmission Control Protocol) handshake. When a client initiates a connection to a server, it sends a SYN (synchronise) packet. The server responds with a SYN/ACK (synchronise/acknowledge) packet, indicating it's willing to establish a connection. Finally, the client acknowledges this with an ACK packet, and the connection is established. This three-step process ensures reliable and orderly data transmission in TCP/IP networks.

`Do you know what XXE is?
XXE stands for XML External Entity Injection. It's a vulnerability that occurs when an attacker can manipulate the processing of XML data in an application to include external entities, often leading to information disclosure or denial of service. Attackers can exploit XXE to access sensitive files, execute remote code, or perform other malicious actions by tricking an application into parsing maliciously crafted XML input. Proper input validation and secure parsing practices are essential to mitigate XXE risks.

`Explain the OWASP Top Ten and give an example of a vulnerability from this list.
The OWASP Top Ten is a list of the most critical web application security risks. An example vulnerability is Injection, which includes SQL injection and command injection. An attacker can exploit this by injecting malicious code into an application, potentially gaining unauthorized access to the database or system. Our OWASP Top 10 room covers each of the OWASP Top 10 vulnerabilities and critical web security risks.

`What is the difference between XSS and CSRF?
XSS (Cross-Site Scripting) and CSRF (Cross-Site Request Forgery) are both web security vulnerabilities, but they target different aspects of web applications. XSS involves malicious scripts injected into a website to execute within the context of a user's browser, potentially stealing data or performing actions on their behalf. CSRF, on the other hand, tricks a user into unwittingly making an unwanted, often malicious, request to a different website where they are authenticated, causing actions to occur without their consent. In summary, XSS manipulates a user's view of a website, while CSRF manipulates their actions on a website.

`What is role-based access control (RBAC), and why do compliance frameworks cover it?
Role-Based Access Control (RBAC) is a security model that restricts system access to authorised users based on their roles within an organisation. Compliance frameworks cover RBAC because it helps ensure data privacy, security, and regulatory compliance by enforcing access control and minimising the risk of unauthorised access. RBAC helps organisations define, manage, and audit user permissions systematically, aligning with compliance requirements to protect sensitive data and maintain accountability in access management.

`What is the NIST framework?
The NIST (National Institute of Standards and Technology) framework is a set of guidelines and best practices for regulating cyber security and risk management. It provides a comprehensive approach to managing and improving an organisation's cyber security posture, covering areas such as risk assessment, cyber security policies, and incident response. The NIST framework is widely used by organisations to enhance their cyber security resilience and align with industry standards and regulations. Our Governance & Regulation training explores policies and frameworks vital for regulating cyber security in an organisation, and can give you a better understanding of the Governance, Risk Management & Compliance (GRC) framework.

## Preparing for scenarios
Scenario-based questions are used to assess your problem-solving skills, your ability to apply your knowledge to real-world situations, and your decision-making process when it comes to security incidents or challenges. These questions typically present a hypothetical situation or security incident, and you're asked how you would respond, what steps you would take, and what security measures you would implement. The specific scenarios can vary but might include:

- You receive an alert indicating a potential data breach. Walk me through the steps you would take to investigate and respond to this incident.
* Step 1: Identification - Verify the alert's legitimacy and source.
* Step 2: Containment - Isolate affected systems to prevent further damage.
* Step 3: Eradication - Identify the root cause and eliminate the threat.
* Step 4: Recovery - Restore affected systems and data.
* Step 5: Lessons Learned - Conduct a post-incident review to improve future responses.

`How would you prioritise and remediate critical vulnerabilities in a large network environment with limited resources and tight deadlines?
A Security Engineer would prioritise and remediate critical vulnerabilities by focusing on high-risk assets, implementing temporary mitigations where necessary, leveraging automation for efficiency, and maintaining transparent communication with stakeholders to meet tight deadlines and resource constraints.

`A company wants to improve its network security posture. Describe the steps you would take to perform a network security assessment and recommend improvements.
To improve network security posture, you would start by defining the scope and objectives of the network security assessment. Next, conduct vulnerability scanning and penetration testing to identify weaknesses. Following this, analyse findings, produce a detailed report with recommendations for improvement, and prioritise actions based on risk. Finally, collaborate with IT teams to implement the recommended security enhancements, continually monitoring and adjusting the security posture as needed to ensure ongoing protection.

`As a Security Engineer, how would you collaborate with developers to ensure secure coding practices are followed during the software development lifecycle?
To ensure secure coding practices are followed, you would integrate security into the software development lifecycle (SDLC) by conducting regular training sessions, providing coding guidelines and security tools, and performing code reviews with a focus on identifying and mitigating vulnerabilities. You would also work closely with development teams to understand their specific project requirements, offer guidance on threat modelling, and emphasise the importance of security at every stage of development. Fostering open communication and a security-conscious culture would ensure that security is ingrained in the development process from inception to deployment. Before your interview, we recommend refreshing your memory with our SSDLC training, which focuses on the Secure Software Development Lifecycle (S-SDLC), its processes, and methodologies.

`You suspect that an employee is accessing sensitive data without authorisation. What steps would you take to confirm the suspicion and mitigate the risk?
* Step 1: Evidence Collection - Gather logs and access records
* Step 2: Isolation - If necessary, isolate the employee's access
* Step 3: Interview and Investigation - Conduct interviews and review evidence
* Step 4: Documentation - Maintain detailed records
* Step 5: Access Review - Evaluate access controls
* Step 6: Mitigation - Take appropriate actions, like access revocation
* Step 7: Lessons Learned - Improve security measures based on findings
* Step 8: Communication - Keep stakeholders informed
* Step 9: Ongoing Monitoring - Continuously watch for further unauthorised access
* Step 10: Legal Compliance - Ensure all actions align with laws and regulations

`How do you stay updated with evolving security regulations and ensure an organisation remains compliant with relevant laws such as GDPR or HIPAA?
To stay updated with evolving security regulations and ensure organisational compliance with GDPR or HIPAA, you should regularly monitor industry news, subscribe to relevant publications and mailing lists, attend conferences and workshops with cyber experts, and participate in professional networks!

`Can you describe a specific security incident you've handled in the past? What were the key challenges you faced, and how did you resolve them?"

# Job Domains
* Security Architecture - Security design that addresses the requirements and potential risks of a given scenario or environment. 
* Physical Security - Protection of personnel, hardware, software, networks, and data from physical actions and events that could cause serious loss or damage.
* Risk Assessment - Analyzing what can go wrong, how likely it is to happen, what the potential consequences are, and how tolerable the identified risk is.
* Security Operation - Process of identifying, containing, and remediating threats on behalf of a company or organization.
* Threat Intelligence - Research and analysis of evidence-based knowledge regarding an existing or emerging menace.
* User Education - Teaching users how to protect themselves from cyberattacks by informing them of risks, exploits, and external threats, and the skills needed to combat common attacks.
* Career Development - Training of future cyber security professionals
* Governance - Framework for managing performance and risk, oversight of compliance and control responsibilities, and defining the cyber mission by mapping the structure, authority, and processes to create an effective program.
* Framework and Standard - Creation of new security frameworks and practices for professionals to follow.

# Job Domains
* Security Architecture - Security design that addresses the requirements and potential risks of a given scenario or environment. 
* Physical Security - Protection of personnel, hardware, software, networks, and data from physical actions and events that could cause serious loss or damage.
* Risk Assessment - Analyzing what can go wrong, how likely it is to happen, what the potential consequences are, and how tolerable the identified risk is.
* Security Operation - Process of identifying, containing, and remediating threats on behalf of a company or organization.
* Threat Intelligence - Research and analysis of evidence-based knowledge regarding an existing or emerging menace.
* User Education - Teaching users how to protect themselves from cyberattacks by informing them of risks, exploits, and external threats, and the skills needed to combat common attacks.
* Career Development - Training of future cyber security professionals
* Governance - Framework for managing performance and risk, oversight of compliance and control responsibilities, and defining the cyber mission by mapping the structure, authority, and processes to create an effective program.
* Framework and Standard - Creation of new security frameworks and practices for professionals to follow.
