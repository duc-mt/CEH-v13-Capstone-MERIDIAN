# Operation MERIDIAN — One-Page Executive Brief

**Engagement:** Continuous Red Team, hybrid enterprise (on-prem + AWS + Azure) · **Duration:** 4 weeks · **Methodology:** CEH v13 full-spectrum, 20 modules · **Full report:** `../11-Reporting/`

## The Headline
A single unpatched internet-facing component led to full on-prem Domain Admin, full AWS production account takeover, and a pivot into Azure AD — in under 72 hours of active testing.

```text
Internet --> Public API RCE --> Domain Admin --> AWS Account Takeover --> Azure AD Pivot
```
Full chain: `../diagrams/attack-chain.md`

## By the Numbers
| Metric | Value |
|---|---|
| CEH v13 modules executed | 20 of 20 |
| Total findings | 48 |
| Critical findings | 7 |
| ATT&CK techniques exercised | 34 across 11 tactics |
| Overall detection success rate | 57% |
| Time to full compromise chain | <72 hours active testing |

## Top 3 Things to Fix First (0–30 days)
1. Patch the internet-facing nginx RCE and reset the Kerberoastable service account (closes the #1 attack path).
2. Scope the CI/CD IAM role to least privilege and rotate the leaked Azure AD secret (closes the cloud-takeover path).
3. Require out-of-band verification for helpdesk MFA resets (closes the human/process gap attackers reached fastest).

## The One Strategic Takeaway
**Identity, not software bugs, is the primary blast radius.** Three of four Critical findings trace to credential and access-control weaknesses rather than novel exploits — see `../11-Reporting/2-Remediation-Roadmap.md` Strategic Recommendation #1.

Full findings index: `../appendix/0-Findings-Index.md` · GRC mapping: `../12-GRC-Compliance-Mapping/`
