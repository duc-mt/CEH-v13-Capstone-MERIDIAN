# Stop-Conditions & Deconfliction

## Hard Halts
1. Any write access achieved to Level 0/1 OT devices.
2. Evidence of an **active, unrelated** adversary already present — hand off to IR immediately, do not continue testing.
3. Unintended production service degradation lasting more than 5 minutes.
4. Exposure of real customer PII/PCI data (not canary data).
5. Any interaction with a physical safety system (fire suppression, access control).

## Deconfliction Process
- Daily 09:00 sync with Blue Team lead — share planned activity window for the day.
- All C2/beacon infrastructure IPs pre-shared and allow-listed with the SOC before use.
- A dedicated Slack/Teams bridge channel is kept open for real-time "is this us?" checks during active testing windows.
- Every destructive-adjacent test (OT read, cloud IAM chain validation, vishing calls) is logged with a timestamp *before* execution, not after.

## Methodology Overview — CEH v13 Phases Mapped to MITRE ATT&CK

| CEH v13 Phase | Primary ATT&CK Tactics | Week |
|---|---|---|
| 1. Footprinting & Recon | Reconnaissance (TA0043) | 1 |
| 2. Scanning & Enumeration | Reconnaissance, Discovery (TA0007) | 1 |
| 3. Vulnerability Analysis | Resource Development (TA0042) | 1 |
| 4. System Hacking | Initial Access–Impact (TA0001–TA0040) | 2 |
| 5. Malware & Social Engineering | Initial Access, Execution (TA0002) | 2 |
| 6. Network Hacking (Sniff/Evade) | Credential Access (TA0006), Defense Evasion (TA0005) | 2 |
| 7. Web App & API Hacking | Initial Access, Exfiltration (TA0010) | 3 |
| 8. Wireless & IoT/OT | Initial Access, Lateral Movement (TA0008) | 3 |
| 9. Cloud & AI Security | Privilege Escalation (TA0004), Impact (TA0040) | 3–4 |
| 10. Reporting | — | 4 |

Each phase folder in this repo follows: **Objective → Tooling → Execution Pattern → Evidence → Detection/SIEM Logic**.
