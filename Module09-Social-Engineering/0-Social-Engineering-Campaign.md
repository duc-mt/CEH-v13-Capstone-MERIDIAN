# Social Engineering Campaign

**Objective:** measure human + helpdesk-process resilience against a realistic phishing/vishing chain.

| Pretext | Vector | Target group | Approval |
|---|---|---|---|
| "IT password-expiry" portal clone | Email → credential-harvest landing page (GoPhish) | 40-user sample, Finance + IT | Pre-approved template #1 |
| "Vendor invoice" lure | Email → benign macro-free tracking pixel + canary doc | 25-user sample, AP team | Pre-approved template #2 |
| Voice pretext (vishing) | Helpdesk impersonation requesting MFA reset | 5 targeted calls, Tier-1 helpdesk | Pre-approved script #3 |

## Results
- 14/40 (35%) clicked the credential-harvest link
- 3/40 (7.5%) submitted credentials
- 1/25 opened the tracking-pixel document
- 2/5 vishing calls succeeded in a helpdesk MFA reset without identity re-verification

## Finding
**F-07 (Critical)** — Helpdesk MFA reset lacks out-of-band verification. Remediation in `../11-Reporting/2-Remediation-Roadmap.md`.
