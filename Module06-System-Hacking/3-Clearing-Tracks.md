# Clearing Tracks (Detection Validation, Not Actual Evasion)

This phase validates whether MDX's logging pipeline survives an attacker's attempt to clear tracks — it does **not** perform actual destructive log clearing against production.

| Technique | ATT&CK | Purpose in this engagement |
| --- | --- | --- |
| Clear-EventLog awareness test | T1070.001 | Verify SIEM forwards logs *before* local clearing could occur (fed centrally — confirmed effective) |
| Timestomp awareness test | T1070.006 | Verify EDR flags MAC-time anomalies independent of local log state |

## Result

Centralized log forwarding meant local event-log clearing would **not** have blinded the SOC — this is a positive control finding, documented for the report but not counted against MDX's risk register.
