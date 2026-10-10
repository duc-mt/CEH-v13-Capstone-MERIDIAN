# SQL Injection Assessment

**Objective:** detect and validate injection vulnerabilities on the reporting endpoint identified during `../Module05-Vulnerability-Analysis/` triage, following a staged, low-risk methodology.

## Methodology

1. **Detection** — automated + manual boolean/time-based probes
2. **Confirmation** — minimal, non-destructive proof (single `SLEEP()`/boolean differential, no data dumped beyond a canary marker)
3. **Classification** — technique type (error-based, blind boolean, blind time-based, UNION-based, out-of-band)
4. **Impact assessment** — database privileges of the connecting account, reachable schemas
5. **Prevention validation** — confirm parameterized queries fix the issue in a staging retest

```bash
sqlmap -u "https://portal.meridiandynamics-corp.com/report?id=1" --level=2 --risk=1 --batch --technique=B
```

## Finding

**F-13 (High)** — Blind boolean-based SQL injection confirmed on the `report?id=` parameter. The connecting database account has read access beyond the reporting schema (cross-schema read), though no write/DDL privileges — reduces but does not eliminate business impact (sensitive read exposure).

| Technique | Confirmed? | Notes |
| --- | --- | --- |
| Error-based | No | Errors are suppressed in production (generic 500 page) |
| Blind boolean-based | **Yes** | Confirmed via `AND 1=1` / `AND 1=2` differential response length |
| Blind time-based | Yes | `SLEEP(5)` payload produced a 5s+ response delay |
| UNION-based | Not attempted | Column count/type enumeration judged unnecessary once blind extraction was confirmed and RoE favored minimal footprint |
| Out-of-band (DNS exfil) | Not attempted | Would require DNS exfil infrastructure beyond RoE for this low-risk validation |

## Prevention Validation

A staging build with parameterized queries (confirmed via code review, not a live retest against production) closes the boolean/time-based differential — recommended fix matches standard prepared-statement remediation.

## Detection Logic

```yaml
title: SQL Injection Probe Pattern (Boolean/Time-Based)
logsource: {category: webserver}
detection:
  selection:
    url|contains: ['AND 1=1', 'AND 1=2', 'SLEEP(', 'WAITFOR DELAY']
  condition: selection
level: high
tags: [attack.initial_access, attack.t1190]
```
