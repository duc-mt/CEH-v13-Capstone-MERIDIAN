# OWASP Top 10 & API Top 10 Coverage

## Scope Targets
- `portal.meridiandynamics-corp.com` (customer-facing React SPA + REST API)
- `api.meridiandynamics-corp.com/v2` (internal + partner-facing GraphQL/REST hybrid)

| Category | Test Performed | Result |
|---|---|---|
| A01 Broken Access Control | IDOR sweep on `/v2/orders/{id}` via Burp Intruder | **F-11** — IDOR confirmed, any authenticated user can view any order by ID |
| A02 Cryptographic Failures | TLS config scan (`testssl.sh`), JWT algorithm confusion test (`alg:none`, RS256→HS256) | JWT accepts `alg:none` on one legacy endpoint — **F-12 Critical** |
| A03 Injection | GraphQL injection via introspection-derived fuzzing (SQL injection split out to Module 15) | See `../Module15-SQL-Injection/` for F-13 detail |
| A05 Security Misconfiguration | Default admin panel discovery via `ffuf` | Exposed `/actuator/env` on a Spring Boot microservice — **F-14**, leaks DB connection string |
| API8 Lack of Resource & Rate Limiting | Burp Turbo Intruder burst test | No rate limiting — password-reset endpoint abusable for enumeration |

```bash
ffuf -w common-api-paths.txt -u https://api.meridiandynamics-corp.com/FUZZ -mc 200,301,302,403
```

See `../Module11-Session-Hijacking/` for session/cookie/JWT-specific testing (F-33), and `../Module13-Hacking-Web-Servers/` for server-layer findings (F-34).

## Detection Logic
See [`../10-Detection-Engineering/sigma-rules/10-idor-sequential-access.yml`](../10-Detection-Engineering/sigma-rules/10-idor-sequential-access.yml).
