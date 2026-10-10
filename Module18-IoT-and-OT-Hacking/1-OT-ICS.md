# OT / ICS (Read-Only, Purdue Level 2–3 Only)

| Protocol | Technique | Result |
| --- | --- | --- |
| Modbus/TCP (historian) | Passive function-code enumeration (`mbtget` read-only) | Unauthenticated read access to historian tags — **F-21**, no write attempted (RoE) |
| S7comm (HMI gateway) | Banner grab only | Legacy firmware version identified, CVE lookup performed, **not exploited** (Purdue L1 boundary) |

## Purdue Model Safety Note

All OT interaction stayed at Level 2–3 (HMI/historian/SCADA supervisory) per `../00-Engagement-Charter/0-Scope-and-RoE.md` — no engineering-workstation or PLC-level (L0/L1) write operations were attempted at any point, consistent with ICS pentest safety practice (IEC 62443 test-environment guidance).

## Detection Logic

See [`../10-Detection-Engineering/sigma-rules/11-unauthorized-modbus-read.yml`](../10-Detection-Engineering/sigma-rules/11-unauthorized-modbus-read.yml).

## Topology Reference

See [`../topology/0-Network-Topology.md`](../topology/0-Network-Topology.md) for the Purdue Level boundary diagram and [`../topology/2-Traffic-Flow-Diagrams.md`](../topology/2-Traffic-Flow-Diagrams.md#6-ot-read-only-boundary-scenario-module-18) for the read-only OT traffic flow this module validates.
