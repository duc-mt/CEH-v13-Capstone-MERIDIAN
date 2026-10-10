# Traffic-Flow Diagrams by Scenario

Each diagram below is the data-flow view behind one engagement scenario, cross-referenced to the modules and findings that exercise it. See `0-Network-Topology.md` for the static segment map and `../diagrams/attack-chain.md` for the single end-to-end compromise chain.

## 1. Legitimate User Login (baseline, for comparison)
```text
Browser --HTTPS--> Edge WAF/CDN --HTTPS--> portal.meridiandynamics-corp.com (DMZ/VLAN20)
   |
   v
Auth request --> api-gateway-02 (10.40.2.55) --> validates JWT --> Order/Account services
   |
   v
HttpOnly/Secure/SameSite cookie set (Module11 — pass, except F-33 logout-revocation gap)
```

## 2. Initial-Access Scenario (Module 05/06) — public RCE to foothold
```text
Internet
   |
   v
F-04 vulnerable nginx module on api-gateway-02 (DMZ/VLAN20)
   |  RCE confirmed (F-05) via DNS canary callback
   v
Internal Linux host on DMZ/VLAN20 (attacker foothold)
   |  pivot (firewall rule allows DMZ->VLAN10 LDAP/Kerberos for app-to-AD auth)
   v
AD VLAN10 — svc_backup discovery (F-03) -> Kerberoasting (F-06) -> Domain Admin
```
*Note:* the DMZ→VLAN10 pivot above relies on an over-permissive firewall rule (app-to-AD auth traffic); tightening that rule to specific ports/destinations is folded into `../11-Reporting/2-Remediation-Roadmap.md`.

## 3. CI/CD → Cloud Takeover Scenario (Module 19)
```text
Build server (10.40.3.40, VLAN30)
   |  NFS no_root_squash (F-28) OR compromised CI credential
   v
mdx-cicd-deploy IAM role (AWS)
   |  iam:PassRole + lambda:CreateFunction (F-22)
   v
Admin-equivalent EC2 instance profile
   |
   v
Full mdx-prod account takeover
   |  leaked Azure AD app secret found in public S3 (s3-assets, F-23)
   v
Azure AD tenant pivot
```

## 4. Mobile App → API Scenario (Module 17)
```text
MDX Field Tech app (Android/iOS, field device, untrusted network)
   |  hardcoded client secret (F-36), no cert pinning (F-37)
   v
MITM-capable attacker on same network as field device
   |  intercepts auth token (F-37) or reuses hardcoded secret directly
   v
api.meridiandynamics-corp.com (DMZ/VLAN20)
   |  no object-level authorization check
   v
IDOR (F-11) — any order ID readable regardless of which user's token/secret was used
```

## 5. IoT/Warehouse Scenario (Module 18)
```text
Warehouse sensors (VLAN60, MDX-Warehouse-DC)
   |  MQTT anonymous subscribe (F-38) / CoAP no DTLS (F-39) / ZigBee key exposure (F-40)
   v
Passive attacker on VLAN60
   |  reads door-sensor open/close events, dock proximity data, decrypted ZigBee traffic
   v
Physical-security-adjacent intelligence (badge timing correlation, F-20)
```
*This flow does not reach VLAN50 (OT) or AD — it is a confidentiality/telemetry-exposure issue, not a pivot path, and is scoped and reported as such.*

## 6. OT Read-Only Boundary Scenario (Module 18)
```text
Attacker foothold anywhere on VLAN10/20/30/40 (post-Scenario-2)
   |  routed access to VLAN50 (OT/ICS, Level 2-3) — no ACL restricting source
   v
Historian / HMI (10.40.5.20)
   |  unauthenticated Modbus read (F-21)
   v
Tag data readable  ---X---  Level 0/1 (PLCs/sensors) — HARD BOUNDARY, never crossed, never attempted
```

## 7. Phishing → Credential Harvest Scenario (Module 09)
```text
GoPhish campaign email --> Corp workstation user (VLAN40)
   |  35% click-through, 7.5% credential submission
   v
Harvested creds tested against vpn.meridiandynamics-corp.com and portal (no lockout bypass attempted)
   |
   v
Vishing pretext against Helpdesk (independent vector)
   |  F-07 — MFA reset without out-of-band verification
   v
Attacker-controlled MFA on a legitimate account
```
