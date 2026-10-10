# Gaining Access

**Objective:** gain a documented initial foothold, matched against a detection control, without destructive payloads.

| Sub-stage | Technique (ATT&CK) | Notes |
|---|---|---|
| Initial access | Exploitation of Public-Facing App (T1190) via F-04 | Executed in an isolated maintenance window, WAF bypass payload logged and shared with Blue Team post-test |
| Alt. vector | Valid Accounts (T1078) via password-spray against `svc_backup` (F-03) | Single low-and-slow spray, 1 attempt/account/30 min to stay under lockout threshold |

**Evidence artifact:** `F-05 — RCE on api-gateway-02 confirmed via canary beacon callback (DNS, not shell) at <timestamp>; screenshot + request/response pair retained.`

## Detection Logic
See [`../10-Detection-Engineering/sigma-rules/04-public-app-exploitation.yml`](../10-Detection-Engineering/sigma-rules/04-public-app-exploitation.yml).
