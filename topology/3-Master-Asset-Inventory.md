# Master Asset Inventory

One row per distinct asset referenced anywhere in this repo. This is the "what exists" view; `../appendix/0-Findings-Index.md` is the "what was found" view; `0-Network-Topology.md` is the "how it's wired" view.

| Asset | Type | Location | Owner (fictional) | Findings against it |
|---|---|---|---|---|
| Primary DC (10.40.1.10) | Windows Server 2019 | MDX-HQ-DC / VLAN10 | NetSec/AD Team | F-02, F-03, F-06, F-48 |
| `api-gateway-02` (10.40.2.55) | nginx + custom API | MDX-HQ-DC / VLAN20 | AppDev | F-04, F-05, F-11, F-12, F-14, F-15, F-16, F-34 |
| Build server (10.40.3.40) | Linux, NFS export | MDX-HQ-DC / VLAN30 | DevOps | F-28 |
| Corp workstation pool | Windows 10/11 | All 3 sites / VLAN40 | IT Ops | F-02, F-07, F-08, F-09 |
| Historian/HMI (10.40.5.20) | Legacy Windows, Modbus/S7comm | MDX-HQ-DC + MDX-Warehouse-DC / VLAN50 | OT Engineering | F-21 |
| MQTT broker | Embedded/Linux | MDX-Warehouse-DC / VLAN60 | Facilities/OT | F-38 |
| IP cameras (x8) | Embedded | VLAN60 | Facilities | F-19 |
| Badge reader controller | Embedded | VLAN60 | Facilities/Security | F-20 |
| ZigBee sensor network | Embedded | VLAN60 | Facilities | F-40 |
| `MDX-Guest` SSID | WPA2 (open-ish) | All 3 sites / VLAN70 | NetSec | F-17 |
| `MDX-Corp` SSID | WPA2-Enterprise | All 3 sites / VLAN80 | NetSec | F-18 |
| `mdx-prod` AWS account | Cloud | AWS | Cloud Eng | F-22, F-23, F-24, F-41–F-44 |
| `mdx-cicd-deploy` IAM role | Cloud IAM | AWS | DevOps/Cloud Eng | F-22 |
| EKS cluster | Container platform | AWS | Cloud Eng | F-24, F-34, F-41–F-43 |
| Lambda functions | Serverless | AWS | AppDev/Cloud Eng | F-22, F-41, F-44 |
| Azure AD tenant / M365 | Identity + SaaS | Azure | IT Ops | F-22 (chain) |
| MDX Field Tech app | Mobile (Android/iOS) | N/A (distributed) | AppDev (mobile) | F-35, F-36, F-37 |
| LLM support chatbot | Internal AI service | Cloud-hosted | AppDev/AI Platform | F-26 |
| Fraud-detection ML model | Internal AI service | Cloud-hosted | Data Eng | F-27 |
| Internal CA | PKI | MDX-HQ-DC | NetSec | F-46, F-47 |

## Coverage Check
Every finding ID (F-01 through F-48) in `../appendix/0-Findings-Index.md` traces to exactly one row above except the engagement-process findings (F-29, F-30, F-31, F-32) which are control/process validations rather than asset-specific — those are indexed by module only.
