# Operation MERIDIAN — CEH v13 Full-Spectrum Capstone

![Markdown Lint](https://github.com/duc-mt/CEH-v13-Capstone-MERIDIAN/actions/workflows/markdown-lint.yml/badge.svg)
![Link Check](https://github.com/duc-mt/CEH-v13-Capstone-MERIDIAN/actions/workflows/link-check.yml/badge.svg)
![Sigma Rules](https://github.com/duc-mt/CEH-v13-Capstone-MERIDIAN/actions/workflows/validate-sigma-rules.yml/badge.svg)
![ATT&CK Layer](https://github.com/duc-mt/CEH-v13-Capstone-MERIDIAN/actions/workflows/validate-attack-navigator-json.yml/badge.svg)
![Terraform Validate](https://github.com/duc-mt/CEH-v13-Capstone-MERIDIAN/actions/workflows/terraform-validate.yml/badge.svg)
![Docker Validate](https://github.com/duc-mt/CEH-v13-Capstone-MERIDIAN/actions/workflows/docker-validate.yml/badge.svg)

A modernized, hybrid-enterprise Red Team capstone project structured around the **official 20-module CEH v13 syllabus**, run as one continuous engagement narrative rather than 20 disconnected labs.

> **Baseline note:** this project is thematically derived from a legacy 2021 `Ethical-Hacking-Labs` tool index. The module structure follows CEH v13; the architecture, scenario, cloud/AI/IoT coverage, and detection-engineering layer are entirely new. Exploitation/credential-theft steps are documented at the **technique and tooling-class level** (ATT&CK-mapped), not as copy-paste weaponized scripts — consistent with professional Red Team report conventions and CEH exam expectations.

## The Scenario

**Meridian Dynamics (MDX)** — a fictional mid-market manufacturing + logistics group running a hybrid environment:
- On-prem datacenter: VMware, Windows AD, legacy OT/SCADA
- AWS (`mdx-prod`): VPCs, IAM, S3, Lambda, EKS
- Azure AD tenant + Microsoft 365
- A field-logistics mobile app (Android/iOS)
- A warehouse IoT sensor fleet (MQTT/CoAP/ZigBee)

One Red Team engagement runs the entire CEH v13 kill chain against this environment end-to-end, from passive OSINT to cross-cloud account takeover, with detection engineering validated at every module.

## Repo Structure

```text
00-Engagement-Charter/                    Scope, Rules of Engagement, stop-conditions

Module01-Introduction-to-Ethical-Hacking/
Module02-Footprinting-and-Reconnaissance/
Module03-Scanning-Networks/
Module04-Enumeration/
Module05-Vulnerability-Analysis/
Module06-System-Hacking/
Module07-Malware-Threats/
Module08-Sniffing/
Module09-Social-Engineering/
Module10-Denial-of-Service/
Module11-Session-Hijacking/
Module12-Evading-IDS-Firewalls-Honeypots/
Module13-Hacking-Web-Servers/
Module14-Hacking-Web-Applications/
Module15-SQL-Injection/
Module16-Hacking-Wireless-Networks/
Module17-Hacking-Mobile-Platforms/
Module18-IoT-and-OT-Hacking/
Module19-Cloud-Computing/
Module20-Cryptography/

10-Detection-Engineering/                 Sigma rules, SIEM deployment guide, Sigma→platform conversion, ATT&CK Navigator layer
11-Reporting/                             Executive summary, findings register, remediation roadmap, ATT&CK/Purple Team metrics, lessons learned
12-GRC-Compliance-Mapping/                ISO 27001 Annex A, NIST 800-53, and NIST AI RMF control mappings
topology/                                 Network topology, VLAN/IP addressing, cross-module traffic-flow diagrams, master asset inventory
diagrams/                                 Full end-to-end compromise-chain diagram
appendix/                                 Findings index (F-01 → F-48), glossary, tooling reference
Module21-Remediation-Validation-Retest/   Unofficial — retest methodology, closure evidence, closure-letter template
lab-environment/                          Vagrant/Docker/Terraform configs to make every module actually reproducible, not just documented
threat-models/                            STRIDE data-flow threat models for the portal and API, predicting findings from design
portfolio/                                One-page executive brief + notes for publishing this as a public work sample
```

## How to Use This Repo

1. Read `00-Engagement-Charter/` first — every module after it assumes that scope and RoE.
2. Read `topology/0-Network-Topology.md` next — it's the map every module's IPs, VLANs, and pivots refer back to.
3. Work `Module01` → `Module20` in order; most module folders follow **Objective → Tooling → Execution Pattern → Evidence/Finding → Detection Logic**.
4. Cross-reference `10-Detection-Engineering/sigma-rules/` while reading any module — each finding links to its rule file.
5. `topology/2-Traffic-Flow-Diagrams.md` has one data-flow diagram per cross-module scenario (initial access, CI/CD→cloud takeover, mobile→API, IoT, OT boundary, phishing) — read the relevant one alongside the module that exercises it.
6. `11-Reporting/` is the capstone deliverable: it rolls every module's findings into one risk register, ATT&CK/Purple Team metrics, and a remediation roadmap.
7. `appendix/0-Findings-Index.md` is the single table of all 48 findings with severity and source module; `topology/3-Master-Asset-Inventory.md` is the same findings mapped by asset instead of by module.
8. Want this to go beyond paper? `lab-environment/` has the Vagrant/Docker/Terraform to actually stand up MDX's AD, web/API, cloud, and OT segments and reproduce every finding for real.
9. `threat-models/` (STRIDE) shows the design-level reasoning that predicts several of the Module 11/13/14/17 findings before you ever run a tool.
10. `12-GRC-Compliance-Mapping/` and `Module21-Remediation-Validation-Retest/` are the two pieces that turn this from "a pentest report" into "an audit-ready, closed-loop engagement."
11. `portfolio/0-Executive-Brief.md` is the one-page version if you only have thirty seconds with a stakeholder.

## CEH v13 Module Coverage

| # | Module | Folder |
|---|---|---|
| 01 | Introduction to Ethical Hacking | `Module01-Introduction-to-Ethical-Hacking/` |
| 02 | Footprinting and Reconnaissance | `Module02-Footprinting-and-Reconnaissance/` |
| 03 | Scanning Networks | `Module03-Scanning-Networks/` |
| 04 | Enumeration | `Module04-Enumeration/` |
| 05 | Vulnerability Analysis | `Module05-Vulnerability-Analysis/` |
| 06 | System Hacking | `Module06-System-Hacking/` |
| 07 | Malware Threats | `Module07-Malware-Threats/` |
| 08 | Sniffing | `Module08-Sniffing/` |
| 09 | Social Engineering | `Module09-Social-Engineering/` |
| 10 | Denial-of-Service | `Module10-Denial-of-Service/` |
| 11 | Session Hijacking | `Module11-Session-Hijacking/` |
| 12 | Evading IDS, Firewalls, and Honeypots | `Module12-Evading-IDS-Firewalls-Honeypots/` |
| 13 | Hacking Web Servers | `Module13-Hacking-Web-Servers/` |
| 14 | Hacking Web Applications | `Module14-Hacking-Web-Applications/` |
| 15 | SQL Injection | `Module15-SQL-Injection/` |
| 16 | Hacking Wireless Networks | `Module16-Hacking-Wireless-Networks/` |
| 17 | Hacking Mobile Platforms | `Module17-Hacking-Mobile-Platforms/` |
| 18 | IoT and OT Hacking | `Module18-IoT-and-OT-Hacking/` |
| 19 | Cloud Computing | `Module19-Cloud-Computing/` |
| 20 | Cryptography | `Module20-Cryptography/` |


## CI & Automation

Every push/PR is validated automatically — nothing here is "trust the docs," it's checked:

| Workflow | Validates | Triggers on |
|---|---|---|
| `markdown-lint.yml` | Markdown formatting consistency across all 89+ files | Any `.md` change |
| `link-check.yml` | Every internal cross-reference (`[text](../path.md)`) actually resolves, plus external links weekly | Any `.md` change, weekly schedule |
| `validate-sigma-rules.yml` | Every Sigma rule parses, converts cleanly, and has required fields (`title`, `id`, `logsource`, `detection`, `level`) | Changes under `10-Detection-Engineering/sigma-rules/` |
| `validate-attack-navigator-json.yml` | The Navigator layer is valid JSON with correctly formatted technique IDs | Changes to `attack-navigator-layer.json` |
| `terraform-validate.yml` | `terraform fmt -check` + `terraform validate` on the lab IAM config — **never runs `apply`** | Changes under `lab-environment/terraform/` |
| `docker-validate.yml` | `docker compose config`, Dockerfile lint (hadolint), `npm audit` on the seeded API | Changes under `lab-environment/docker/` |
| `release-package.yml` | Builds and attaches a zip to GitHub Releases | Push of a `v*` tag |

Update the `your-org/operation-meridian` placeholder in the badges above and in `.github/dependabot.yml`'s PR limits once this is pushed to your actual GitHub repo.

## Contributing & Issues
See `CONTRIBUTING.md`. Use the **New Finding** issue template to propose additional findings, or the **Documentation Bug** template for broken cross-references/topology mismatches — CI's link-checker catches most of these automatically, but asset/topology consistency across modules is still a manual review item (see the PR template's checklist).

## Rules of Engagement — TL;DR

Full RoE lives in `00-Engagement-Charter/`. Highlights:
- No destructive payloads, no real ransomware simulation, no physical intrusion.
- OT testing is **read-only**, Purdue Level 2–3 only — no PLC/sensor/actuator writes, ever.
- Only synthetic canary data is used for any exfiltration demonstration.
- Any evidence of a pre-existing, unrelated compromise = immediate stop and handoff to IR.
- The mobile app (Module 17) was added to scope mid-engagement via a signed addendum — see that module's scope note.

## License

Educational / authorized-engagement training purposes only. See `LICENSE`.
