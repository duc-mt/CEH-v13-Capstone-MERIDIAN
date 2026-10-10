# Cryptography Assessment

**Objective:** assess MDX's use of encryption, PKI, and cryptographic protocols across the on-prem and cloud estate — rolling up TLS/JWT findings already surfaced in earlier modules and adding PKI- and at-rest-encryption-specific review.

## TLS / Transport Encryption

| Target | Finding | Severity |
| --- | --- | --- |
| Legacy customer portal | TLS 1.0 still negotiable (first flagged in `../Module05-Vulnerability-Analysis/`) | Medium |
| Internal service mesh (east-west traffic) | Plaintext HTTP between several microservices inside the EKS cluster — **F-45** | High |
| MQTT/CoAP IoT segment | No transport encryption (ties to F-38/F-39 in `../Module18-IoT-and-OT-Hacking/`) | Medium |

## PKI Review

| Area | Finding |
| --- | --- |
| Internal CA | Internal CA root certificate has a 20-year validity with no documented rotation plan — **F-46** |
| Client certificate validation (WPA2-Enterprise) | Weak validation already identified in `../Module16-Hacking-Wireless-Networks/` (F-18) — root cause traced here to the internal CA issuing certs without strict EKU constraints |
| Certificate transparency monitoring | No active CT-log monitoring for `*.meridiandynamics-corp.com` — a rogue/mis-issued cert would go unnoticed — **F-47** |

## Cryptographic Attack Validation

| Test | Result |
| --- | --- |
| JWT `alg:none` / algorithm confusion | Confirmed exploitable — F-12 (`../Module14-Hacking-Web-Applications/`) |
| Weak password hashing review (on-prem AD) | NTLM-only (no Kerberos AES enforcement) on 3 legacy service accounts — **F-48**, compounds Kerberoasting risk (F-06) |
| At-rest encryption (S3/RDS) | S3 buckets use default SSE-S3 (not customer-managed KMS keys); RDS encryption-at-rest enabled correctly — partial pass, KMS upgrade recommended for defense-in-depth |
| Random number / token generation review | Session tokens and JWT `jti` values use a CSPRNG — pass |

## Finding Summary

Cryptography findings in this engagement are mostly **configuration and lifecycle** issues (algorithm downgrade allowed, long-lived CA, no CT monitoring, weak Kerberos encryption types) rather than broken primitives — consistent with the identity/configuration pattern called out across the rest of this repo.

## Detection Logic

```yaml
title: TLS Negotiation Below Minimum Accepted Version
logsource: {category: network_traffic}
detection:
  selection:
    tls_version: ['SSLv3', 'TLSv1.0', 'TLSv1.1']
  condition: selection
level: medium
tags: [attack.credential_access, attack.t1557]
---
title: Kerberos Ticket Using RC4/NTLM Encryption Type
logsource: {product: windows, service: security}
detection:
  selection:
    EventID: 4768
    TicketEncryptionType: '0x17'
  condition: selection
level: medium
tags: [attack.credential_access, attack.t1558]
```
