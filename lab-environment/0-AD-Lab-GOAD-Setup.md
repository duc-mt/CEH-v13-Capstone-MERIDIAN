# AD Lab Setup — GOAD (Game of Active Directory)

Reproduces the MDX-HQ-DC AD environment (`topology/0-Network-Topology.md`, VLAN10) for Module 04 (Enumeration), Module 06 (System Hacking), and Module 20 (Cryptography — Kerberos encryption types) using [GOAD](https://github.com/Orange-Cyberdefense/GOAD), the standard open-source vulnerable AD lab.

## Prerequisites

- A hypervisor: VMware/VirtualBox/Proxmox with ≥32GB RAM, 100GB disk free
- Vagrant + the provider plugin for your hypervisor
- Ansible ≥2.9
- An isolated/host-only virtual network — **do not bridge to any production LAN**

## Setup

```bash
git clone https://github.com/Orange-Cyberdefense/GOAD.git
cd GOAD
# Pick the "GOAD" lab (one forest, multiple domains/trusts — closest to the
# "2 domains, 3 sites" forest described in 00-Engagement-Charter/0-Scope-and-RoE.md)
./goad.sh -l GOAD -p virtualbox -t install
```

## Mapping GOAD to MDX Roles

| GOAD default | Rename/role for this project | Maps to |
| --- | --- | --- |
| `DC01` (sevenkingdoms.local) | `MDX-HQ-DC` primary DC | `topology/1-IP-VLAN-Addressing-Scheme.md` → 10.40.1.10 |
| A low-priv service account with an SPN | `svc_backup` | Module04 (F-03), Module06 (F-06) |
| A misconfigured OU delegation (GOAD ships several) | The Tier-0 `GenericAll` chain | Module06 (F-06), `diagrams/attack-chain.md` |

## Seeding the Specific Findings

After GOAD is up, apply these to match the project's exact findings instead of GOAD's defaults:

```powershell
# F-03: weak password + Kerberoastable SPN on svc_backup
Set-ADUser svc_backup -ServicePrincipalNames @{Add="MSSQLSvc/backup01:1433"}
Set-ADAccountPassword svc_backup -NewPassword (ConvertTo-SecureString "Summer2024!" -AsPlainText -Force)

# F-02: enable null SMB sessions on a handful of member servers (lab only — never do this against real infra)
# via Group Policy: Network access: Let Everyone permissions apply to anonymous users = Enabled

# F-48: force RC4 ticket encryption on 3 legacy service accounts
Set-ADUser svc_legacy01 -KerberosEncryptionType RC4
```

## Validating Against the Project's Sigma Rules

Once the lab is generating real Windows Security event logs, forward them to the SIEM built in `../10-Detection-Engineering/0-SIEM-Deployment-Guide.md` and confirm `05-kerberoasting.yml` and `20-kerberos-rc4-ticket.yml` actually fire.
