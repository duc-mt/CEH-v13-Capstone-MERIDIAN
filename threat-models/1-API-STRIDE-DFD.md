# STRIDE Threat Model — `api.meridiandynamics-corp.com`

Covers the API surface shared by the portal SPA (`0-Portal-STRIDE-DFD.md`) and the MDX Field Tech mobile app (`../Module17-Hacking-Mobile-Platforms/`) — the dual-consumer design is itself a threat-modeling-relevant fact, since the two clients have very different trust levels.

## Data Flow Diagram
```text
[Portal SPA]  \
               >--(1)--> [api-gateway-02] --(2)--> [GraphQL/REST hybrid layer] --(3)--> [DB]
[Mobile App]  /                 |
                            (4) client_secret auth (mobile only)
```

## STRIDE per Flow
| Flow | Threat | Mitigated? | Finding if not |
|---|---|---|---|
| (1) Mobile→Gateway | Spoofing (hardcoded shared secret usable by anyone who extracts it) | **No** | F-36 |
| (1) Mobile→Gateway | Tampering (no certificate pinning, MITM-able) | **No** | F-37 |
| (2) Gateway→GraphQL layer | Information Disclosure (introspection enabled) | **No** | F-15 |
| (2) Gateway→GraphQL layer | Elevation of Privilege (business-logic abuse, negative quantity) | **No** | F-16 |
| (3) GraphQL→DB | Tampering (SQLi on the adjacent REST reporting endpoint) | **No** | F-13 (Module15) |
| (4) Mobile auth | Repudiation (gateway cannot distinguish "legit app" from "secret extracted from APK") | **No** | Root cause of F-36 |

## Key Structural Finding
The API's authentication model treats "possesses the mobile client secret" as equivalent to "is the legitimate mobile app" — this is a **design-level flaw**, not an implementation bug, and no amount of patching F-36 in isolation fixes it. The architectural fix (recommended in `../11-Reporting/2-Remediation-Roadmap.md`) is per-device/per-install credentials (e.g., OAuth2 device-code flow or mobile attestation) rather than a single shared secret embedded in every build.
