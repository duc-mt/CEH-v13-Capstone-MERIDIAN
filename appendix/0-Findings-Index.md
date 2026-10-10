# Findings Index (F-01 → F-48)

| ID | Title | Module | Severity |
|---|---|---|---|
| F-01 | Zone transfer permitted on secondary DNS | Module02-Footprinting | Medium |
| F-02 | Null SMB sessions on 14 hosts | Module04-Enumeration | Medium |
| F-03 | `svc_backup` PASSWD_NOTREQD + Kerberoastable SPN | Module04-Enumeration | High |
| F-04 | Vulnerable nginx module on internet-facing gateway | Module05-Vulnerability-Analysis | Critical |
| F-05 | RCE confirmed on api-gateway-02 | Module06-System-Hacking | Critical |
| F-06 | Kerberoasting → Domain Admin in 3 hops | Module06-System-Hacking | Critical |
| F-07 | Helpdesk MFA reset bypass (vishing) | Module09-Social-Engineering | High |
| F-08 | EDR miss rate on signed-binary proxy execution | Module07-Malware-Threats | Medium |
| F-09 | LLMNR/NBT-NS enabled domain-wide | Module08-Sniffing | Medium |
| F-10 | Decoy-scan correlation gap | Module12-Evading-IDS-Firewalls-Honeypots | Medium |
| F-11 | IDOR on `/v2/orders/{id}` | Module14-Hacking-Web-Applications | High |
| F-12 | JWT `alg:none` accepted | Module14-Hacking-Web-Applications | Critical |
| F-13 | Blind SQL injection on reporting endpoint | Module15-SQL-Injection | High |
| F-14 | `/actuator/env` exposed, leaks DB connection string | Module13-Hacking-Web-Servers | High |
| F-15 | GraphQL introspection enabled | Module14-Hacking-Web-Applications | Medium |
| F-16 | AI fuzzing found business-logic flaw (negative qty) | Module14-Hacking-Web-Applications | High |
| F-17 | Rogue AP susceptibility | Module16-Hacking-Wireless-Networks | Medium |
| F-18 | Weak EAP-PEAP cert validation | Module16-Hacking-Wireless-Networks | Medium |
| F-19 | Default creds on 3/8 IP cameras | Module18-IoT-and-OT-Hacking | Medium |
| F-20 | Cleartext badge IDs on VLAN | Module18-IoT-and-OT-Hacking | Medium |
| F-21 | Unauthenticated read on OT historian | Module18-IoT-and-OT-Hacking | High |
| F-22 | CI/CD role → AWS account takeover + Azure pivot | Module19-Cloud-Computing | Critical |
| F-23 | Public S3 bucket listing | Module19-Cloud-Computing | High |
| F-24 | EKS API server public, anonymous-auth residue | Module19-Cloud-Computing | Critical |
| F-25 | Overly permissive NSG (RDP from Internet) | Module19-Cloud-Computing | High |
| F-26 | Indirect prompt injection via PDF upload | Module19-Cloud-Computing | Medium |
| F-27 | Unvalidated vendor feed into fraud-detection model | Module19-Cloud-Computing | Medium |
| F-28 | NFS export with `no_root_squash` on build server | Module04-Enumeration | High |
| F-29 | DLP missed steganographically embedded canary | Module06-System-Hacking | Medium |
| F-30 | EDR correctly blocked unsigned kernel module (positive control) | Module06-System-Hacking | Informational |
| F-31 | AI phishing classifier missed the macro-free pretext | Module09-Social-Engineering | Medium |
| F-32 | No DDoS scrubbing/CDN contract on the customer portal | Module10-Denial-of-Service | Medium |
| F-33 | No server-side JWT revocation after logout | Module11-Session-Hijacking | Medium |
| F-34 | Container base image carries 4 known-CVE OS packages | Module13-Hacking-Web-Servers | Medium |
| F-35 | Mobile app over-requests SMS/location permissions | Module17-Hacking-Mobile-Platforms | Medium |
| F-36 | Hardcoded API client secret in mobile app builds | Module17-Hacking-Mobile-Platforms | Critical |
| F-37 | Android auth token stored unencrypted, no cert pinning | Module17-Hacking-Mobile-Platforms | High |
| F-38 | Anonymous MQTT broker access | Module18-IoT-and-OT-Hacking | Medium |
| F-39 | CoAP sensors transmit without DTLS | Module18-IoT-and-OT-Hacking | Medium |
| F-40 | ZigBee network key exposed during pairing | Module18-IoT-and-OT-Hacking | Medium |
| F-41 | No restricted Pod Security Standards on EKS | Module19-Cloud-Computing | High |
| F-42 | Container images unsigned, no admission enforcement | Module19-Cloud-Computing | Medium |
| F-43 | DB credentials as plaintext Lambda/pod env vars | Module19-Cloud-Computing | High |
| F-44 | Lambda dependency with known critical CVE | Module19-Cloud-Computing | High |
| F-45 | Plaintext HTTP between EKS microservices | Module20-Cryptography | High |
| F-46 | Internal CA root cert: 20-year validity, no rotation plan | Module20-Cryptography | Medium |
| F-47 | No certificate-transparency log monitoring | Module20-Cryptography | Medium |
| F-48 | Legacy service accounts allow RC4/NTLM Kerberos encryption | Module20-Cryptography | Medium |

Critical count: **7** (F-04, F-05, F-06, F-12, F-22, F-24, F-36 — see `../11-Reporting/0-Executive-Summary-Risk-Assessment.md` for the risk-register view, which should be read as the canonical roll-up over this full list).
