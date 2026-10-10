# Findings Register

Every finding in this repo follows the same structure. Use this as the template for any new finding added to the project.

```text
Finding
├── ID & Title
├── Description
├── Evidence (artifact reference, timestamp)
├── CVSS / Severity
├── Likelihood
├── Business Impact
├── Remediation
└── Validation Method
```

## Example — F-22

| Field | Value |
| --- | --- |
| ID | F-22 |
| Title | CI/CD IAM Role → Full AWS Account Takeover |
| Description | The `mdx-cicd-deploy` role holds `iam:PassRole` + `lambda:CreateFunction` without a resource/condition restriction, allowing it to pass itself an admin-equivalent EC2 instance profile. |
| Evidence | `aws iam simulate-principal-policy` output, `09-Cloud-and-AI-Security/0-Cloud-IAM-Privilege-Escalation.md` |
| CVSS / Severity | Critical |
| Likelihood | High — any compromised CI/CD credential reaches this path directly |
| Business Impact | Full control of `mdx-prod`: data exfiltration, service disruption, lateral pivot into Azure via the co-located app secret (F-22 chain) |
| Remediation | Scope IAM role to least privilege; add explicit `iam:PassedToService` condition; rotate the leaked Azure AD secret |
| Validation Method | Policy simulation only — no production resource was created or modified |

See each phase folder (`01`–`09`) for the full list of F-01 through F-27, cross-referenced to their source phase.
