# Lab Environment — Making Operation MERIDIAN Runnable

Everything in `Module01`–`Module20` is currently *documented* against the fictional MDX topology. This folder is the bridge to making it *reproducible*: real infrastructure you stand up in an isolated lab (local Vagrant/Proxmox/Docker, or your own cloud sandbox — never a shared or production account) that actually reproduces each finding.

| Component | Replaces | Setup guide |
|---|---|---|
| Active Directory domain (GOAD) | MDX-HQ-DC (`topology/0-Network-Topology.md`) | `0-AD-Lab-GOAD-Setup.md` |
| Vulnerable web/API target (Juice Shop + seeded API) | `portal`/`api.meridiandynamics-corp.com` | `1-Vulnerable-Web-API-Target.md` |
| AWS sandbox (Terraform) | `mdx-prod` | `2-AWS-Terraform-Sandbox.md` |
| OT/Modbus simulator | Historian/HMI (10.40.5.20) | `3-OT-Modbus-Simulator.md` |

## Ground Rules for the Lab
1. **Isolated network only** — host-only/NAT Vagrant network or a dedicated cloud sandbox account, never bridged to a production LAN.
2. **Your own cloud account, never a client's** — the Terraform in `2-AWS-Terraform-Sandbox.md` intentionally creates an over-permissioned IAM role; run it only in a throwaway sandbox account and `terraform destroy` when done.
3. **Snapshot before exploitation** — AD lab and web target should be snapshotted so you can reset after each module's testing.
4. Once the lab is live, replace the narrated "Expected output" blocks in each module with your own real command output and screenshots — that's the single biggest credibility upgrade available to this project.
