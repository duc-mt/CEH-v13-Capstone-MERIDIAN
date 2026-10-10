# NIST SP 800-53 Rev. 5 Control Family Mapping

| Control Family | Relevant Controls | Findings |
|---|---|---|
| AC — Access Control | AC-2 (Account Mgmt), AC-3 (Enforcement), AC-6 (Least Privilege) | F-02, F-03, F-11, F-22, F-28, F-41 |
| IA — Identification & Authentication | IA-2, IA-5 (Authenticator Mgmt) | F-06, F-07, F-12, F-36, F-48 |
| SC — System & Communications Protection | SC-8 (Transmission Confidentiality), SC-13 (Crypto) | F-20, F-38, F-39, F-45, F-46 |
| SI — System & Information Integrity | SI-2 (Flaw Remediation), SI-4 (Monitoring) | F-04, F-05, F-10, F-26, F-34 |
| CA — Assessment, Authorization & Monitoring | CA-7 (Continuous Monitoring) | F-10, F-26, F-32 (ties to detection-rate metrics in `../11-Reporting/3-ATTACK-Coverage-and-Purple-Team.md`) |
| CP — Contingency Planning | CP-2, CP-7 | F-32 (no DDoS scrubbing contract) |
| CM — Configuration Management | CM-6 (Config Settings), CM-7 (Least Functionality) | F-14, F-25, F-41, F-42 |
| RA — Risk Assessment | RA-5 (Vulnerability Scanning) | Module05's scanning stack, F-04 |
| AT — Awareness & Training | AT-2 | F-07, F-31 |

## Use
Pair this with `0-ISO27001-Annex-A-Mapping.md` when the audience is a US federal/FedRAMP-adjacent stakeholder rather than an ISO-certified one — the underlying findings are identical, only the control taxonomy changes.
