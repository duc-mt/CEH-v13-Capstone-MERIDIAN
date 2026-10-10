# Remediation Roadmap

| Timeframe | Action | Owner | Maps to |
| --- | --- | --- | --- |
| **0–30 days** | Patch/remove vulnerable nginx module (F-04); reset `svc_backup` + enforce gMSA; disable JWT `alg:none`; close public S3 listing (F-23); restrict EKS API endpoint | IT Ops + Cloud Eng | F-04, F-06, F-12, F-23, F-24 |
| **0–30 days** | Mandate out-of-band verification for helpdesk MFA resets | Service Desk | F-07 |
| **30–60 days** | Disable LLMNR/NBT-NS domain-wide; remediate Tier-0 OU ACLs (`GenericAll`); disable null SMB sessions | NetSec/AD Team | F-02, F-06, F-09 |
| **30–60 days** | Implement object-level authorization checks (fix IDOR class, F-11); add GraphQL introspection restriction + rate limiting | AppDev | F-11, F-15, API8 |
| **60–90 days** | Scope down CI/CD IAM role (least privilege), rotate leaked Azure AD secret, enable S3/Storage integrity validation on vendor feeds | Cloud Eng, Data Eng | F-22, F-27 |
| **60–90 days** | WPA2-Enterprise cert validation hardening; IoT device credential rotation + network segmentation; OT read-access ACL on historian | NetSec, Facilities | F-17–F-21 |
| **Ongoing** | Tune EDR for signed-binary proxy execution (F-08); build SIEM correlation rule for IAM PassRole+Lambda chain; add indirect-prompt-injection detection on LLM gateway | SOC/Detection Eng | F-08, F-22, F-26 |

## Strategic Recommendations

1. **Identity is the primary blast radius.** Three of four Critical findings (F-06, F-12, F-22) trace back to identity/credential weaknesses, not novel exploits — prioritize identity hardening over point-patching.
2. **Cross-domain correlation is the biggest detection gap.** Individually logged events were each technically loggable but never correlated into a single incident in real time — invest in a correlation/UEBA layer before adding more point detections.
3. **AI cuts both ways.** AI-assisted fuzzing (F-16) found a business-logic flaw 40+ hours of manual testing missed; AI-assisted triage achieved 79% precision flagging attacker activity. The same LLM support chatbot is also a new attack surface (F-26) — govern AI deployments with the same rigor as any other internet-facing service.
4. **OT boundary held.** No Level 0/1 write access was achieved or attempted; the Purdue L2/L3 read-only exposure (F-21) should still be closed before it becomes a pivot point for a less-constrained adversary.

## Compliance & Governance Framing

See `../12-GRC-Compliance-Mapping/` to translate the findings above into ISO 27001 Annex A and NIST 800-53 control-gap language (and NIST AI RMF for F-26/F-27) for audit or board-level reporting.

## Verifying These Fixes Actually Land

`../Module21-Remediation-Validation-Retest/` defines the retest methodology and closure-evidence format for confirming each row above is actually closed, not just marked closed in a tracker.
