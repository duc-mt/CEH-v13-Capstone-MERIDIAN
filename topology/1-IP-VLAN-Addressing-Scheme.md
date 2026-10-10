# IP & VLAN Addressing Scheme

Canonical addressing table — every IP/host referenced anywhere in this repo should appear here. If you add a new finding that touches a new host, add it here too (see `../CONTRIBUTING.md`).

## On-Prem (MDX-HQ-DC unless noted)

| IP | VLAN | Hostname/Role | OS/Platform | Referenced in |
| --- | --- | --- | --- | --- |
| 10.40.1.10 | 10 | Primary Domain Controller | Windows Server 2019 | Module03, Module04 (F-02/F-03), Module06 (F-06), Module20 (F-48) |
| 10.40.2.55 | 20 | `api-gateway-02` | nginx + custom API | Module03, Module05 (F-04), Module06 (F-05), Module13 (F-34) |
| 10.40.3.40 | 30 | Build server / CI runner | Linux | Module04 (F-28), Module19 (CI/CD role origin) |
| 10.40.4.0/24 | 40 | Corp workstation pool | Windows 10/11 | Module06 (privesc targets), Module08 (LLMNR victims), Module09 (phishing targets) |
| 10.40.5.20 | 50 | Historian / SCADA supervisory host | Windows (legacy) | Module03, Module18 (F-21) |
| 10.40.6.0/24 | 60 | IoT/warehouse segment (MQTT broker, 8x IP cameras, badge reader controller, ZigBee coordinator) | Mixed embedded | Module16 (badge/camera), Module18 (F-19/F-20/F-38/F-39/F-40) |
| 10.40.70.0/24 | 70 | `MDX-Guest` Wi-Fi client pool | — | Module16 (F-17) |
| — | 80 | `MDX-Corp` Wi-Fi (802.1X, bridges into VLAN40) | — | Module16 (F-18) |

## MDX-Warehouse-DC (second AD site)

| IP | VLAN | Hostname/Role | Referenced in |
| --- | --- | --- | --- |
| 10.40.6.0/24 | 60 | Local IoT fleet (sensors feeding the HQ MQTT broker) | Module18 |
| 10.40.5.0/24 (subset) | 50 | Local HMI for warehouse conveyor/dock systems (Level 2 only) | Module18 |

## MDX-Branch-DC (third AD site)

No dedicated findings — workstation-only site, included in the AD forest's trust/replication topology referenced in Module 04/06 but not individually enumerated in this engagement.

## Public DNS / External Hostnames

| Hostname | Points to | Referenced in |
| --- | --- | --- |
| `portal.meridiandynamics-corp.com` | DMZ (VLAN20) — customer SPA | Module11, Module13, Module14, Module15, Module20 |
| `api.meridiandynamics-corp.com` | DMZ (VLAN20) — `api-gateway-02` | Module05, Module06, Module11, Module14, Module17 |
| `vpn.meridiandynamics-corp.com` | VPN gateway | Module02 |
| `mail.meridiandynamics-corp.com` | M365 (Azure AD) | Module02, Module09 |
| `sharepoint.meridiandynamics-corp.com` | M365 (Azure AD) | Module02 |
| `s3-assets.meridiandynamics-corp.com` | AWS S3 (`mdx-prod`) | Module02, Module19 (F-22, F-23) |
| `historian.meridiandynamics-corp.com` | 10.40.5.20 (OT, VLAN50) | Module02 (F-01, zone-transfer leak), Module18 |

## Cloud

| Resource | Platform | Referenced in |
| --- | --- | --- |
| `mdx-prod` account | AWS | Module19 (F-22, F-23, F-24, F-41–F-44) |
| `mdx-cicd-deploy` IAM role | AWS | Module19 (F-22) |
| EKS cluster | AWS | Module13 (F-34), Module19 (F-24, F-41–F-43) |
| Azure AD tenant / M365 | Azure | Module02, Module19 (F-22 chain) |

## Mobile

| Asset | Referenced in |
| --- | --- |
| "MDX Field Tech" app (Android/iOS) — calls `api.meridiandynamics-corp.com` directly, bypassing the SPA | Module17 (F-35, F-36, F-37) |
