# Mobile Platform Assessment

**Scope note:** No MDX-managed mobile devices or a published MDX mobile app were in the original scope (`../00-Engagement-Charter/0-Scope-and-RoE.md`). During the engagement, the "MDX Field Tech" Android/iOS app (used by field logistics staff) was identified via the `03-Vulnerability-Analysis` cloud asset review and added to scope under a signed scope-change addendum.

## Android Assessment

| Test | Tooling class | Result |
| --- | --- | --- |
| Static analysis (manifest, permissions) | `apktool`, `MobSF`-class static scanner | App requests `READ_SMS` and `ACCESS_FINE_LOCATION` with no clear feature justification — **F-35** |
| Hardcoded secrets in APK | `MobSF`, `grep` over decompiled source | API gateway client secret hardcoded in the APK — **F-36 (Critical)**, directly usable against `api.meridiandynamics-corp.com` |
| Insecure data storage | Device-local SQLite inspection (test device, not user data) | Auth token stored unencrypted in app-private SQLite DB — **F-37** |
| Network traffic inspection | MITM proxy (Burp) against a test device | Certificate pinning not implemented — MITM succeeded, confirming F-37's token is interceptable in transit |

## iOS Assessment

| Test | Tooling class | Result |
| --- | --- | --- |
| IPA static analysis | `class-dump`-class tooling | Same hardcoded API gateway secret present in the iOS build — ties to F-36 |
| Keychain usage review | Manual (jailbroken test device) | Auth token correctly stored in Keychain (unlike Android's SQLite) — partial pass, Android-only finding |

## Finding Summary

**F-36 (Critical)** — A hardcoded API client secret in both mobile app builds is directly usable to call `api.meridiandynamics-corp.com/v2` without legitimate user authentication, compounding the IDOR (F-11) and rate-limiting gaps (API8) found in `../Module14-Hacking-Web-Applications/`.

## Detection Logic

```yaml
title: API Calls Using the Known-Hardcoded Mobile Client Secret
logsource: {category: application, service: api_gateway}
detection:
  selection:
    client_secret: '<known-leaked-value-pattern>'
  condition: selection
level: critical
tags: [attack.credential_access, attack.t1552.001]
```

## Topology Reference

See [`../topology/2-Traffic-Flow-Diagrams.md`](../topology/2-Traffic-Flow-Diagrams.md#4-mobile-app--api-scenario-module-17) for how this app's traffic reaches `api-gateway-02` and compounds F-11.
