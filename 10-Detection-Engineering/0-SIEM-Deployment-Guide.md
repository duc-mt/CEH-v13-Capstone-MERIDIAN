# SIEM Deployment Guide — Validating the Sigma Rule Library

The 20 rules in `sigma-rules/` are currently unvalidated — written against expected log fields, never fired against real telemetry. This guide closes that gap using Security Onion (fastest path to NSM + SIEM in one) as the primary option, with a lighter ELK/Wazuh path as an alternative.

## Option A — Security Onion (recommended)
```bash
# On a dedicated VM (≥16GB RAM, 4 vCPU), isolated management network
git clone https://github.com/Security-Onion-Solutions/securityonion.git
# Follow the ISO installer: https://docs.securityonion.net/en/2.4/installation.html
# Choose "Standalone" install for a single-box lab deployment
```
Point your `lab-environment/` hosts' log forwarding (Windows Event Forwarding for the GOAD domain controller, Docker log driver for the Juice Shop/seeded-api containers, CloudTrail → S3 → Security Onion's cloud ingest for the AWS sandbox) at this box.

## Option B — ELK + Wazuh (lighter weight)
```bash
docker compose -f wazuh-docker/single-node/docker-compose.yml up -d
# Wazuh agent on the GOAD DC:
# https://documentation.wazuh.com/current/installation-guide/wazuh-agent/wazuh-agent-package-windows.html
```

## Log Sources to Wire Up
| Source | Feeds which rules |
|---|---|
| Windows Security event log (GOAD DC) | 02, 05, 06, 07, 20 |
| DNS server query log | 01 |
| Juice Shop / seeded-api access log | 03, 04, 10, 15 |
| Docker/host network capture (tcpdump on the dmz-lab bridge) | 08, 09, 14, 17, 19 |
| AWS CloudTrail (sandbox account, forwarded via S3 + Lambda shipper) | 12, 18 |
| OT simulator Modbus traffic (SPAN/mirror port) | 11 |
| LLM gateway application log (if you stand up a local LLM demo app) | 13 |
| EKS/Lambda audit log (sandbox) | 16, 18 |

See `1-Sigma-to-Platform-Conversion.md` for turning the 20 Sigma rules into actual Security Onion (Elastic) or Wazuh queries.
