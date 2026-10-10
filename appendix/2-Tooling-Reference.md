# Tooling Reference (by class, not step-by-step weaponization)

| Class | Examples | Used in |
|---|---|---|
| OSINT | Shodan, Censys, crt.sh, theHarvester, amass | 01 |
| Network scanning | nmap, masscan | 02, 06 |
| Enumeration | enum4linux-ng, crackmapexec, ldapsearch, onesixtyone | 02 |
| Vulnerability scanning | Nessus, OpenVAS, Nuclei, Trivy, ScoutSuite, Prowler | 03 |
| Credential auditing | hashcat (offline, isolated rig) | 04 |
| AD attack-path mapping | BloodHound-class graph analysis | 04 |
| Phishing simulation | GoPhish | 05 |
| Attack simulation (benign) | Atomic Red Team, CALDERA | 05 |
| Sniffing/MITM | Responder-class, bettercap-class | 06 |
| Web/API testing | Burp Suite, OWASP ZAP, ffuf, sqlmap | 07 |
| Wireless | aircrack-ng-class, hostapd-based rogue AP | 08 |
| IoT firmware | binwalk | 08 |
| OT/ICS | mbtget (read-only) | 08 |
| Cloud security | Pacu, ScoutSuite, AzureHound-class, aws-cli | 09 |

This project intentionally documents tooling **by class and by standard, publicly documented usage syntax** rather than shipping ready-to-run exploit/credential-theft scripts — matching how commercial Red Team reports are written and keeping the repo safe to share broadly for CEH study purposes.
