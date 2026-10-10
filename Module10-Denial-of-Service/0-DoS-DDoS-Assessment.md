# Denial-of-Service / DDoS Resilience Assessment

**Objective:** validate rate-limiting and DDoS-mitigation configuration **without impacting production** (volumetric testing against prod is explicitly out of scope — see `../00-Engagement-Charter/0-Scope-and-RoE.md`).

## Test Environment
All DoS/DDoS testing below was run against an isolated staging replica of `api.meridiandynamics-corp.com`, never against the production endpoint.

| Technique (ATT&CK T1498 / T1499) | Tooling class | Result |
|---|---|---|
| SYN flood | `hping3`-class, rate-limited | Staging WAF rate-limited at 5k req/s as configured — pass |
| Application-layer (Slowloris-style) | Low-and-slow connection exhaustion | Staging reverse proxy timeout correctly recycled held connections — pass |
| Amplification awareness (DNS/NTP reflection) | Configuration review only, no live reflection traffic generated | MDX's edge network correctly filters spoofed-source UDP from NTP/DNS amplification sources — pass |
| Botnet/C2 DDoS framing | Architecture review only (no botnet operated) | MDX has no current volumetric-DDoS scrubbing contract with its ISP/CDN — **F-32**, gap noted for business continuity planning |

## Finding
**F-32** — No upstream DDoS scrubbing/CDN contract currently covers `portal.meridiandynamics-corp.com`; a real volumetric attack would rely entirely on the edge WAF's connection-level rate limiting, which was only validated up to 5k req/s in staging.

## Detection Logic
```yaml
title: Volumetric Request Rate Anomaly (Staging-Validated Pattern)
logsource: {category: webserver}
detection:
  selection:
    requests_per_second: '>3000'
  timeframe: 10s
  condition: selection
level: high
tags: [attack.impact, attack.t1498]
```
