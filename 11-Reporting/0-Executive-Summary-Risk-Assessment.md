# Executive Summary & Risk Assessment

Meridian Dynamics could be compromised from an Internet-facing service through internal identity systems into both AWS and Azure cloud environments. An attacker following the demonstrated path would be capable of accessing business operations, intellectual property, cloud workloads, and supervisory OT data without requiring physical access.

**Bottom line:** the Red Team achieved full on-prem Domain Admin, full `mdx-prod` AWS account takeover, and a cross-cloud pivot into Azure AD, starting from a single unpatched internet-facing component and a weak service-account password policy. The attack path from internet-facing API to Domain Admin to cloud-account-takeover took under 72 hours of active operator time — well inside a realistic adversary dwell-to-impact window. See `../diagrams/attack-chain.md` for the full visual chain.

## Risk Register (Top Findings)

| ID | Finding | CVSS/Impact | Likelihood | Risk |
| --- | --- | --- | --- | --- |
| F-22 | CI/CD role → full AWS account takeover | Critical | High | **Critical** |
| F-06 | Kerberoastable `svc_backup` → Domain Admin in 3 hops | Critical | High | **Critical** |
| F-12 | JWT `alg:none` accepted on legacy endpoint | Critical | High | **Critical** |
| F-24 | EKS API server public with anonymous-auth residue | Critical | Medium | **High** |
| F-11 | IDOR on `/v2/orders/{id}` — full order data exposure | High | High | **High** |
| F-07 | Helpdesk MFA reset bypass (vishing) | High | Medium | **High** |
| F-21 | Unauthenticated read access to OT historian | High | Medium | **High** |
| F-13 | Blind SQLi on reporting endpoint | High | Medium | **High** |
| F-02/F-09 | Null SMB sessions + LLMNR/NBT-NS enabled | Medium | High | **Medium** |
| F-17/F-18 | Rogue-AP susceptibility, weak EAP cert validation | Medium | Medium | **Medium** |

Full per-finding detail (description, evidence, business impact, validation method) is in `1-Findings-Register.md`.
