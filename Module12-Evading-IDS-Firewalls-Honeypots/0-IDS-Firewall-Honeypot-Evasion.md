# IDS / Firewall / Honeypot Evasion

```bash
# Nmap decoy + fragmentation to baseline IDS alerting fidelity (authorized, SOC-aware window)
nmap -D RND:10 -f -sS --data-length 24 -T2 10.40.2.0/24
```

| Evasion technique | Result |
|---|---|
| Decoy scanning (`-D`) | SOC alerted on 2 of 10 decoys only — **F-10: decoy correlation gap** |
| Packet fragmentation | IDS reassembled correctly, alert fired — pass |
| Honeypot interaction | A decoy SMB share (`FINANCE_BACKUP`) was touched and correctly alerted — pass, honeypot program validated |

## Denial-of-Service Note
Volumetric DoS testing was explicitly **out of scope** against production (see `../00-Engagement-Charter/0-Scope-and-RoE.md`); a SYN-flood baseline was instead run against an isolated staging replica to confirm rate-limiting configuration, with results folded into the IDS evasion findings above.

## Detection Logic
See [`../10-Detection-Engineering/sigma-rules/09-decoy-scan-correlation-gap.yml`](../10-Detection-Engineering/sigma-rules/09-decoy-scan-correlation-gap.yml).
