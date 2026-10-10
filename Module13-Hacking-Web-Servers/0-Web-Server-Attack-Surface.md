# Web Server Attack Surface

**Objective:** assess the web/application server layer itself (nginx, Spring Boot actuator endpoints, container base images) — distinct from the application-logic testing in `../Module14-Hacking-Web-Applications/`.

| Test | Technique | Tooling class | Result |
| --- | --- | --- | --- |
| Server banner / version fingerprinting | HTTP header + error-page fingerprinting | `whatweb`, `nmap --script http-*` | nginx version matches the vulnerable module identified in `../Module05-Vulnerability-Analysis/` (F-04) |
| Default/sample file discovery | Common-path brute force | `ffuf`, `gobuster` | `/actuator/env` exposed on a Spring Boot microservice (F-14) — carried over from the web-app sweep, but rooted in server misconfiguration, not app logic |
| Directory traversal at the web-server layer | `../../../../etc/passwd`-style probes against static file serving | Manual + Burp | Blocked correctly by nginx's `root` confinement — pass |
| TLS/server hardening | `testssl.sh`, header review (HSTS, CSP, X-Frame-Options) | testssl.sh | Legacy portal still negotiates TLS 1.0 — carried from `../Module05-Vulnerability-Analysis/` prioritization matrix |
| Container base-image hygiene | `trivy image` against the API gateway image | Trivy | Base image carries 4 known-CVE packages beyond the app-level nginx module finding — **F-34** |

## Finding

**F-34** — The `api-gateway` container's base image has 4 outdated OS packages with known CVEs unrelated to the application code itself; patching the base image is a separate remediation track from the app-level RCE fix (F-04).

## Detection Logic

See [`../10-Detection-Engineering/sigma-rules/03-scanner-signature-burst.yml`](../10-Detection-Engineering/sigma-rules/03-scanner-signature-burst.yml) (shared with Module 05's scanning signature).
