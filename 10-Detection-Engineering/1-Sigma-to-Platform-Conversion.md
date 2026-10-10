# Sigma → Platform Conversion

Converts the 20 vendor-neutral rules in `sigma-rules/` into Elastic/Security-Onion and Splunk queries using the standard `sigma-cli` + `pySigma` toolchain.

## Install
```bash
pip install sigma-cli
sigma plugin install elasticsearch
sigma plugin install splunk
```

## Convert the Whole Library — Elastic (Security Onion)
```bash
sigma convert -t lucene -p ecs_windows sigma-rules/05-kerberoasting.yml
sigma convert -t lucene -p ecs_windows sigma-rules/*.yml -o converted/elastic/
```

## Convert the Whole Library — Splunk
```bash
sigma convert -t splunk sigma-rules/*.yml -o converted/splunk/
```

## Example — 05-kerberoasting.yml → Lucene/ECS
```text
event.code:4769 AND winlog.event_data.TicketEncryptionType:"0x17"
```
Wrap this in Security Onion's alerting (via a scheduled Elastic Watcher/Kibana alert, or a Sigma→EQL rule in a detection-engine index) with the `count() by IpAddress > 15 within 5m` logic expressed as the rule's threshold condition — Sigma's `condition:` block isn't 1:1 translatable to a single Lucene query, so time-windowed/count-based rules (05, 06, 02, 03, 10, 12, 18) need their aggregation wired up natively in whichever alerting engine you're using (Kibana's threshold rule type, or Splunk's `stats count by` + alert action).

## Validation Checklist (per rule)
1. Deploy the converted query/alert.
2. Trigger the matching behavior in `lab-environment/` (e.g., run the Module06 Kerberoasting steps against GOAD).
3. Confirm the alert fires with the correct `IpAddress`/`TargetUserName` populated.
4. Record true/false-positive rate over a short baseline period (even 24h of lab "normal" traffic) before counting the rule as validated.
5. Update `../11-Reporting/3-ATTACK-Coverage-and-Purple-Team.md`'s detection-rate numbers from narrated estimates to actual lab-measured results once this pass is complete.
