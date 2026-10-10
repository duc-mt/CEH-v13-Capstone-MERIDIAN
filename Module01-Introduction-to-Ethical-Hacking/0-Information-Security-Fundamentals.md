# Information Security Fundamentals & Engagement Framing

**Objective:** establish the CIA triad, threat-modeling baseline, and legal/ethical framing before any technical activity begins against Meridian Dynamics (MDX).

## Security Controls Reviewed
| Control type | MDX example | Covered in |
|---|---|---|
| Preventive | Network segmentation, IAM least privilege | `../Module19-Cloud-Computing/`, `../Module06-System-Hacking/` |
| Detective | SIEM, EDR, IDS/IPS, Sigma rule library | `../10-Detection-Engineering/` |
| Corrective | Incident response runbooks, patch management | `../11-Reporting/2-Remediation-Roadmap.md` |
| Deterrent | Acceptable use policy, security awareness training | `../Module09-Social-Engineering/` |

## Threat Actor Framing
This engagement emulates a financially motivated, moderately resourced external actor with cloud-pivoting capability — not a nation-state APT — consistent with MDX's threat profile as a mid-market manufacturer/logistics group (see `../00-Engagement-Charter/`).

## Hacker Classes & Ethical Hacking Methodology
| Class | Definition |
|---|---|
| White Hat | Authorized security tester — this engagement |
| Black Hat | Unauthorized malicious actor |
| Gray Hat | Tests without authorization but without malicious intent |
| Red Team | This engagement's role: continuous, scenario-driven, emulates a real adversary |
| Blue Team | MDX's SOC — detection, response, deconfliction partner |
| Purple Team | The joint activity captured in `../11-Reporting/3-ATTACK-Coverage-and-Purple-Team.md` |

## Legal & Compliance Framing
- Engagement is governed by a signed contract referencing `../00-Engagement-Charter/0-Scope-and-RoE.md`.
- Applicable frameworks referenced throughout: NIST CSF, MITRE ATT&CK, OWASP Top 10/API Top 10, IEC 62443 (OT), ISO/IEC 27001.
- No activity in this repo proceeds without the authorization boundary defined in the Engagement Charter.

## CEH Methodology Phases (This Project's Roadmap)
1. Footprinting & Reconnaissance (Module 02)
2. Scanning Networks (Module 03)
3. Enumeration (Module 04)
4. Vulnerability Analysis (Module 05)
5. System Hacking (Module 06)
6. Malware Threats (Module 07)
7. Sniffing (Module 08)
8. Social Engineering (Module 09)
9. Denial-of-Service (Module 10)
10. Session Hijacking (Module 11)
11. Evading IDS/Firewalls/Honeypots (Module 12)
12. Hacking Web Servers (Module 13)
13. Hacking Web Applications (Module 14)
14. SQL Injection (Module 15)
15. Hacking Wireless Networks (Module 16)
16. Hacking Mobile Platforms (Module 17)
17. IoT and OT Hacking (Module 18)
18. Cloud Computing (Module 19)
19. Cryptography (Module 20)
