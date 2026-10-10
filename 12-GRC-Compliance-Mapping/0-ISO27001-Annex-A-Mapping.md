# ISO/IEC 27001:2022 Annex A Control Mapping

Maps this engagement's findings to the Annex A control set they evidence a gap in — turns the findings register into an audit-ready input rather than a standalone pentest report.

| Annex A Control | Control Name | Findings | Gap |
|---|---|---|---|
| A.5.15 | Access control | F-02, F-03, F-11, F-28 | Null sessions, weak service-account policy, missing object-level auth, NFS no_root_squash |
| A.5.17 | Authentication information | F-06, F-12, F-36, F-48 | Kerberoastable account, JWT alg:none, hardcoded mobile secret, weak Kerberos encryption |
| A.5.23 | Information security for cloud services | F-22, F-23, F-24, F-41–F-44 | CI/CD IAM over-permission, public S3, public EKS API, unsigned containers |
| A.5.30 | ICT readiness for business continuity | F-32 | No DDoS scrubbing contract |
| A.6.3 | Awareness, education and training | F-07, F-31 | Vishing-susceptible helpdesk process, AI phishing classifier gap |
| A.8.8 | Management of technical vulnerabilities | F-04, F-05, F-34 | Unpatched nginx module, vulnerable container base image |
| A.8.9 | Configuration management | F-14, F-25, F-41 | Exposed actuator endpoint, overly permissive NSG, no Pod Security Standards |
| A.8.12 | Data leakage prevention | F-20, F-23, F-29 | Cleartext badge IDs, public bucket, DLP missed steganographic canary |
| A.8.16 | Monitoring activities | F-10, F-26 | Decoy-scan correlation gap, undetected indirect prompt injection |
| A.8.20 | Networks security | F-02, F-09, F-21, F-38, F-39 | Flat segmentation symptoms: null SMB, LLMNR, unauth OT read, unauth MQTT/CoAP |
| A.8.24 | Use of cryptography | F-12, F-45, F-46, F-47, F-48 | JWT alg confusion, plaintext east-west, CA lifecycle, no CT monitoring, weak Kerberos |
| A.8.26 | Application security requirements | F-11, F-13, F-15, F-16 | IDOR, SQLi, GraphQL introspection, business-logic flaw |
| A.8.28 | Secure coding | F-13, F-37 | SQLi root cause, insecure mobile data storage |

## Coverage Summary
27 of 48 findings map directly to an Annex A control gap; the remainder (process/positive-control findings like F-30, or narrowly technical ones like F-40 ZigBee key exposure) are better tracked operationally than at the ISMS-control level — see `../11-Reporting/2-Remediation-Roadmap.md` for those.
