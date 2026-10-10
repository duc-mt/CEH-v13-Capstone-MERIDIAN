# STRIDE Threat Model — Customer Portal (`portal.meridiandynamics-corp.com`)

Complements the empirical findings in `../Module11-Session-Hijacking/`, `../Module13-Hacking-Web-Servers/`, and `../Module14-Hacking-Web-Applications/` with the design-level threat model that would normally precede (and predict) them.

## Data Flow Diagram

```text
[Customer Browser] --(1) HTTPS--> [Edge WAF/CDN] --(2)--> [Portal SPA, DMZ/VLAN20]
                                                                 |
                                                            (3) HTTPS/JSON
                                                                 v
                                                      [api-gateway-02, DMZ/VLAN20]
                                                                 |
                                                     (4) internal service calls
                                                                 v
                                                   [Order Service] [Auth Service]
                                                                 |
                                                            (5) LDAP/Kerberos
                                                                 v
                                                         [AD, VLAN10]
```

## STRIDE per Flow

| Flow | Threat | Mitigated? | Finding if not |
| --- | --- | --- | --- |
| (1) Browser→CDN | Tampering (MITM if TLS downgraded) | Partial | F-45-adjacent (TLS 1.0 still negotiable, Module05) |
| (2) CDN→SPA | Spoofing (session fixation) | Yes | Pass, see Module11 |
| (3) SPA→Gateway | Information Disclosure (IDOR) | **No** | F-11 |
| (3) SPA→Gateway | Elevation of Privilege (JWT alg confusion) | **No** | F-12 |
| (4) Gateway→Order Service | Repudiation (no per-call audit trail beyond gateway log) | Partial | Not independently findings-tracked — flagged here as a model gap |
| (4) Gateway→Auth Service | Denial of Service (no rate limit) | **No** | API8 finding, Module14 |
| (5) Auth Service→AD | Tampering (relay if SMB signing absent) | **No** | F-02-adjacent |

## Trust Boundaries

```text
Untrusted  |  CDN/WAF  |  DMZ (Portal SPA + Gateway)  |  Internal (Order/Auth svc)  |  AD (VLAN10)
```

Three of the seven flows above cross the DMZ→Internal boundary without an independent authorization check beyond the JWT itself — this is the structural root cause behind F-11, F-12, and the API8 rate-limiting gap: a single compromised/forged token reaches further than the architecture intends.
