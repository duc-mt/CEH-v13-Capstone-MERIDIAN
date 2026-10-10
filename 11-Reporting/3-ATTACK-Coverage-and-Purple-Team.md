# ATT&CK Coverage & Purple Team Outcomes

## ATT&CK Coverage Statistics
| Metric | Value |
|---|---|
| ATT&CK techniques tested | 34 |
| ATT&CK tactics covered | 11 of 14 |
| Critical findings | 4 |
| High findings | 4 |
| Medium findings | 6 |
| Overall detection success rate | 57% |

## Purple Team Summary
| Activity | Detected | Response Time |
|---|---|---|
| DNS/AXFR enumeration | Yes | 12 min |
| SMB enumeration burst | Yes | 9 min |
| Kerberoasting | Partial (volume alert fired, not triaged as AD attack) | 31 min |
| Signed-binary proxy execution (malware sim) | Partial (2 of 3 runs) | 18 min avg |
| AWS PassRole → Lambda chain | No | N/A |
| Rogue AP / Evil Twin | No | N/A |
| Indirect prompt injection (chatbot) | No | N/A |
| Nmap decoy scan | Partial (2 of 10 decoys correlated) | 40 min |

This is the clearest maturity signal in the engagement: **identity and cloud-control-plane attacks had the lowest detection rate**, while classic network-layer noise (DNS/SMB enumeration) was caught fastest — the opposite of where the actual business risk sits (see Risk Register, `0-Executive-Summary-Risk-Assessment.md`).

## ATT&CK Navigator Layer
A ready-to-import layer file is at [`../10-Detection-Engineering/attack-navigator-layer.json`](../10-Detection-Engineering/attack-navigator-layer.json) — drop it into [mitre-attack.github.io/attack-navigator](https://mitre-attack.github.io/attack-navigator/) to visualize this table as a heat-matrix instead of a flat list.

## Taking This From Narrated to Measured
The percentages above are engagement-day estimates. To replace them with real, lab-measured numbers: `../lab-environment/` → stand up the infrastructure → `../10-Detection-Engineering/0-SIEM-Deployment-Guide.md` → deploy detection → `1-Sigma-to-Platform-Conversion.md` → fire each rule for real and record the actual true/false-positive rate.
