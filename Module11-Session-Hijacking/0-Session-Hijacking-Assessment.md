# Session Hijacking Assessment

**Objective:** test TCP/web session-management controls on `portal.meridiandynamics-corp.com` and `api.meridiandynamics-corp.com`.

| Test | Technique (ATT&CK T1185 / T1539) | Tooling class | Result |
| --- | --- | --- | --- |
| Session cookie theft via XSS sink | Reflected-XSS probe on search parameter | Burp Suite / ZAP | Input is correctly sanitized server-side — pass |
| Cookie attribute review | Manual inspection via browser devtools + ZAP | DevTools / ZAP | `HttpOnly`, `Secure`, `SameSite=Strict` all set correctly — pass |
| TCP session hijacking (sequence prediction) | Passive capture + sequence-number analysis | Wireshark | Modern OS stacks use cryptographically random ISNs — not exploitable, pass |
| Session fixation | Pre-login session ID reused post-authentication? | Manual + Burp | Session ID correctly rotates on login — pass |
| JWT replay (stale token reuse) | Captured token replayed after logout | Burp Repeater | **F-33** — API accepts a JWT for up to 15 minutes past user-initiated logout (no server-side revocation list), a session-hijacking-adjacent gap |

## Finding

**F-33 (Medium)** — No server-side JWT revocation/blocklist on logout; a stolen token remains valid for its full TTL (15 min) even after the legitimate user logs out. Ties into the JWT `alg:none` finding (F-12) in `../Module14-Hacking-Web-Applications/`.

## Detection Logic

```yaml
title: JWT Used After Logout Event
logsource: {category: application}
detection:
  selection:
    event: 'logout'
  followed_by:
    event: 'api_request'
    same_jwt_jti: true
    within: 15m
  condition: selection and followed_by
level: medium
tags: [attack.credential_access, attack.t1539]
```
