# Network Topology — Meridian Dynamics (MDX)

This is the canonical topology every module in this repo assumes. If a module mentions a host or segment not shown here, that's a documentation gap — flag it (see `../CONTRIBUTING.md`).

## High-Level Architecture

```text
                                   INTERNET
                                       |
                         +-------------+-------------+
                         |                            |
                    Edge WAF/CDN                 Public DNS (crt.sh-visible)
                         |                            |
            +------------+------------+     vpn. mail. portal. api.
            |                         |     sharepoint. s3-assets.
       DMZ / VLAN20              VPN Gateway        historian. <- flagged OT leak (F-01)
     (api-gateway-02             (remote/partner
      10.40.2.0/24)                access)
            |                         |
            +------------+------------+
                         |
                  CORE / FIREWALL
                         |
    +--------+-----------+-----------+--------+-----------------+
    |        |                       |        |                 |
 VLAN10   VLAN30                  VLAN40    VLAN50            VLAN60
 AD/Core  Dev-Build               Corp-WS   OT/ICS (L2-3)     IoT/Warehouse
 10.40.1.x 10.40.3.x              10.40.4.x 10.40.5.x         10.40.6.x
 (DC)     (build server,          (user      (historian/HMI    (MQTT broker,
          NFS export F-28)        laptops)   10.40.5.20)       cameras, badge
                                                                reader, ZigBee)
    |                                            |
    |                                     +------+------+
    |                                     |             |
    |                                Purdue L2-3   Purdue L0-1
    |                                (in scope,    (OUT OF SCOPE
    |                                 read-only)    — never touched)
    |
    +---- Wireless: VLAN70 MDX-Guest (10.40.70.x) / VLAN80 MDX-Corp via 802.1X -> VLAN40

                         |
                  SITE-TO-SITE / SD-WAN
                         |
        +----------------+----------------+
        |                |                 |
   MDX-HQ-DC        MDX-Warehouse-DC   MDX-Branch-DC
   (primary AD      (2nd AD site,      (3rd AD site,
    site, VLAN10-60   VLAN60 IoT        smaller WS/AD
    all present)       fleet lives      presence)
                        here)

                         |
                   CLOUD CONNECTIVITY
                         |
            +------------+------------+
            |                         |
        AWS mdx-prod              Azure AD tenant + M365
    (VPC, IAM, S3, Lambda,       (identity, Exchange Online,
     EKS; CI/CD role             SharePoint; app secret
     mdx-cicd-deploy)             leaked into AWS S3 — F-22 chain)

            |
      MDX Field Tech app (Android/iOS, Module 17)
      -> talks directly to api.meridiandynamics-corp.com (DMZ/VLAN20)
```

## Segment Summary

| Segment | VLAN | CIDR | Purpose | Modules that touch it |
| --- | --- | --- | --- | --- |
| DMZ / App Tier | 20 | `10.40.2.0/24` | Internet-facing API gateway, web apps | 03, 05, 06, 13, 14, 15 |
| AD / Core Services | 10 | `10.40.1.0/24` | Domain Controllers, core infra | 03, 04, 06, 20 |
| Dev / Build | 30 | `10.40.3.0/24` | CI/CD runners, build server, NFS export | 04, 06, 19 |
| Corp Workstations | 40 | `10.40.4.0/24` | End-user laptops/desktops | 06, 08, 09, 12 |
| OT/ICS (Purdue L2–3) | 50 | `10.40.5.0/24` | HMI, historian — **read-only scope boundary** | 03, 18 |
| IoT / Warehouse | 60 | `10.40.6.0/24` | MQTT broker, IP cameras, badge reader, ZigBee sensors | 16, 18 |
| Guest Wi-Fi | 70 | `10.40.70.0/24` | `MDX-Guest` SSID | 16 |
| Corp Wi-Fi | 80 | bridges to VLAN40 | `MDX-Corp` SSID, WPA2-Enterprise | 16 |

## Sites

| Site | Role | Segments present |
| --- | --- | --- |
| MDX-HQ-DC | Primary datacenter + HQ office | All VLANs (10/20/30/40/50/70/80) |
| MDX-Warehouse-DC | Logistics hub | VLAN40, VLAN50 (local HMI), VLAN60 (IoT fleet), VLAN70/80 |
| MDX-Branch-DC | Smaller regional office | VLAN40, VLAN70/80 only — no OT, no dev/build |

## Purdue Model Boundary (Critical — read before Module 18)

```text
Level 4/5  Enterprise IT (AD, ERP, cloud) ----------------\
Level 3    Site Operations (historian, SCADA servers)      | IN SCOPE, read-only
Level 2    Supervisory Control (HMI)                        /
-------------------------------- HARD BOUNDARY, NEVER CROSSED --------------------------------
Level 1    Basic Control (PLCs)              \
Level 0    Process (sensors/actuators)        > OUT OF SCOPE, no write access ever attempted
```
