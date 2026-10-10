# Sniffing & Credential Interception

| Technique | ATT&CK | Tooling class |
|---|---|---|
| LLMNR/NBT-NS poisoning | Adversary-in-the-Middle (T1557.001) | Responder-class tooling — run for 15 min in an isolated VLAN mirror, hashes captured then destroyed |
| ARP spoofing | T1557 | bettercap-class MITM, lab segment only |
| MAC spoofing for NAC bypass | T1200 | `macchanger`-class tooling against a guest-VLAN switchport |

## Finding
**F-09** — LLMNR/NBT-NS still enabled domain-wide; 9 workstation hashes captured in a 15-minute passive window during the authorized lab test.

## Detection Logic
See [`../10-Detection-Engineering/sigma-rules/08-llmnr-nbtns-poisoning.yml`](../10-Detection-Engineering/sigma-rules/08-llmnr-nbtns-poisoning.yml).
