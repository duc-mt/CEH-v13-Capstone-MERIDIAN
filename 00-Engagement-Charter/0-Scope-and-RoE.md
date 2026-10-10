# Scope & Rules of Engagement

## Target Profile

| Attribute | Detail |
| --- | --- |
| Client | Meridian Dynamics (MDX) — fictional mid-market manufacturing + logistics group |
| Environment | On-prem DC (VMware + Windows AD + legacy OT/SCADA), AWS (`mdx-prod`), Azure AD + M365 |
| Engagement type | Continuous, scenario-driven Red Team (not a checklist pentest) |
| Duration | 4 weeks — Wk1 Recon/Scan, Wk2 Exploit/AD, Wk3 Web/Cloud/Wireless, Wk4 OT/AI + Reporting |
| Team | 1x Lead, 2x Operators, 1x OSINT analyst |

## In-Scope

- `*.meridiandynamics-corp.com` and subdomains
- On-prem AD forest `corp.meridiandynamics.local` (2 domains, 3 sites)
- AWS account `mdx-prod` (VPCs, IAM, S3, Lambda, EKS)
- Azure AD tenant + M365 (Exchange Online, SharePoint)
- Guest Wi-Fi SSID `MDX-Guest`, Corp SSID `MDX-Corp` (WPA2-Enterprise)
- OT segment: **Purdue Level 2–3 only** (HMI/SCADA historian), read-only, no PLC writes
- Email-based social engineering (max 3 pretexts, pre-approved templates)

## Out-of-Scope

- Any Purdue Level 0/1 (physical PLCs/sensors/actuators) write operations
- Third-party SaaS not owned by MDX (payroll processor, logistics partner APIs)
- Physical intrusion / badge cloning
- DoS/DDoS against production (volumetric testing only in isolated staging)

## Rules of Engagement

| Rule | Detail |
| --- | --- |
| Testing window | Mon–Fri 09:00–18:00 ICT for OT-adjacent segments; 24/7 for cloud/web (non-OT) |
| Authorized techniques | Full CEH v13 kill chain **except** destructive payloads, real-encryption ransomware simulation, physical access |
| Credential use | Only credentials obtained during the engagement; one scoped break-glass validation at week 4 |
| Data handling | No real PII/PCI exfiltration — synthetic canary files only, tagged `MDX-CANARY-<uuid>` |
| Emergency stop | Any OT HMI instability, production outage, or pre-existing compromise → immediate halt, call Blue Team Duty Officer |
| Deconfliction | Daily 09:00 sync with Blue Team lead; all C2 infra IPs allow-listed with SOC |
| Evidence | Full command history + packet captures, encrypted, 90-day retention post-report |

## Topology Reference

Full network topology, VLAN/IP addressing, and cross-module traffic-flow diagrams live in [`../topology/`](../topology/0-Network-Topology.md) — read this alongside the scope above before starting Module 02.
