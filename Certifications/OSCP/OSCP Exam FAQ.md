In this article, you can find answers to the questions listed below:

- [Exam report template](https://help.offsec.com/hc/en-us/articles/4412170923924-OSCP-Exam-FAQ#01HF79MCYA2J51F9EW5PC24D53) Word & Libre
- [Is pivoting required for AD machines?](https://help.offsec.com/hc/en-us/articles/4412170923924-OSCP-Exam-FAQ#h_01FP8C5N5TA6SJ08BH2SYV3Z7H) MAYBE
- [EXAM RESTRICTIONS](https://help.offsec.com/hc/en-us/articles/360040165632-OSCP-Exam-Guide#exam-restrictions)
- [Points required to pass the exam](https://help.offsec.com/hc/en-us/articles/4412170923924-OSCP-Exam-FAQ#h_01FP8EC382T08YAJ6V8ZQXKF5F) 70/100
- [Can I use KAI or any other chatbots during the OSCP exam?](https://help.offsec.com/hc/en-us/articles/4412170923924-OSCP-Exam-FAQ#01J095NZ46APF8NSNG7MAFN395) - NO
- [Metasploit usage](https://help.offsec.com/hc/en-us/articles/4412170923924-OSCP-Exam-FAQ#01HF79P3H0B3P21K25N5VHWDDG) - ONE MACHINE ONLY - NOT USED TO PIVOT
-   [Is PSSession going to count as a shell?](https://help.offsec.com/hc/en-us/articles/4412170923924-OSCP-Exam-FAQ#01HF79QWS5V3S5BVD3MD0X68XS) YES
-   [Which tools are allowed for the OSCP exam?](https://help.offsec.com/hc/en-us/articles/4412170923924-OSCP-Exam-FAQ#h_01FP8CCWDT0GX03RCE6RGYRZT4)
-   [Can I use Discord during the exam?](https://help.offsec.com/hc/en-us/articles/4412170923924-OSCP-Exam-FAQ#h_01H8WBK5HX8ES0A1XNBGKR042A) YES, BUT NO Q's OR EXTERNAL SUPPORT

___
### [Is there an exam report template?](https://help.offsec.com/hc/en-us/articles/4412170923924-OSCP-Exam-FAQ#h_01FP8BWNP4XXW3STDXT1PAYEFT)

Below are the example exam templates we have created to demonstrate how to report on the exam machines.  

- Noraj Report Script: https://github.com/noraj/OSCP-Exam-Report-Template-Markdown

-   [Microsoft Word](https://www.offensive-security.com/pwk-online/OSCP-Exam-Report.docx)
-   [OpenOffice/LibreOffice](https://www.offensive-security.com/pwk-online/OSCP-Exam-Report.odt)

___

### [Is there any pivoting required for the Active Directory machines on the exam?](https://help.offsec.com/hc/en-us/articles/4412170923924-OSCP-Exam-FAQ#h_01FP8C5N5TA6SJ08BH2SYV3Z7H) MAYBE

There may be pivoting required. Anything in the course material is subject to be on the exam.

___
### [Metasploit usage?](https://help.offsec.com/hc/en-us/articles/4412170923924-OSCP-Exam-FAQ#h_01FP8C9G1E0S9ABCYYRBHA6AQW) 

You may only use Metasploit on one target machine. Metasploit cannot be used for pivoting, because it would thereby be used on more than one target.

---
### [Points required to pass the exam](https://help.offsec.com/hc/en-us/articles/4412170923924-OSCP-Exam-FAQ#h_01FP8EC382T08YAJ6V8ZQXKF5F)
OSCP exam points will be allocated as follows:

-   3 stand-alone machines (60 points in total)
    -   20 points per machine
        -   10 points for initial access
        -   10 points for privilege escalation
-   1 Active Directory (AD) set containing 3 machines (40 points in total)
    -   10 points for machine #1
    -   10 points for machine #2
    -   20 points for machine #3 
      
- Possible scenarios to pass the exam (70/100 to pass)
    -   40 points AD + 3 local.txt flags (70 points)
    -   40 points AD + 2 local.txt flags + 1 proof.txt flag (70 points)
    -   20 points AD + 3 local.txt flags + 2 proof.txt flag (70 points)
    -   10 points AD + 3 fully completed stand-alone machines (70 points)

___
### [Which tools are allowed for the OSCP exam?](https://help.offsec.com/hc/en-us/articles/4412170923924-OSCP-Exam-FAQ#h_01FP8CCWDT0GX03RCE6RGYRZT4)

All tools that do not perform any restricted actions are allowed during the exam. The following tools are allowed, but the list is not limited to these:

-   BloodHound (Legacy and Community Edition only)
-   SharpHound
-   PowerShell Empire
-   Covenant 
-   Powerview
-   Rubeus
-   evil-winrm
-   Responder (Poisoning and Spoofing is not allowed in the challenges or on the exam)
-   Crackmapexec
-   Mimikatz
-   Impacket
-   PrintSpoofer

More information regarding the allowed and restricted tools for the OSCP exam can be found in the Exam Restrictions section in the **[OSCP Exam Guide](https://help.offsec.com/hc/en-us/articles/360040165632-OSCP-Exam-Guide#exam-restrictions)** 

___
### [Can I use Discord during the exam?](https://help.offsec.com/hc/en-us/articles/4412170923924-OSCP-Exam-FAQ#h_01H8WBK5HX8ES0A1XNBGKR042A)

While you may use Discord as a resource for searching for information during the exam, under no circumstances are you permitted to seek or receive assistance from others on the platform. This includes but is not limited to, asking for help, sharing exam-related information, or discussing any aspect of the exam with others.
