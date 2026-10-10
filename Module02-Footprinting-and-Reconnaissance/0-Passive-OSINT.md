# Passive OSINT

**Objective:** build a complete external + cloud attack-surface map with zero packets sent to MDX infrastructure.

| Tool | Purpose |
| --- | --- |
| Shodan / Censys | Internet-facing asset discovery, exposed RDP/SMB/ICS banners |
| crt.sh / SecurityTrails | Certificate transparency → subdomain seed list |
| GitHub dorking (`org:meridiandynamics`) | Leaked API keys, internal hostnames in commit history |
| LinkedIn + Hunter.io | Org chart, email naming convention (`first.last@`) |
| cloud_enum / Pacu (passive mode) | Enumerate likely S3 bucket / Azure storage names |

```bash
# Subdomain seed collection (passive only)
amass enum -passive -d meridiandynamics-corp.com -o subs.txt
theHarvester -d meridiandynamics-corp.com -b crtsh,hunter,shodan -f mdx_osint.html
```

**Expected output (amass, trimmed):**

```text
vpn.meridiandynamics-corp.com
mail.meridiandynamics-corp.com
sharepoint.meridiandynamics-corp.com
s3-assets.meridiandynamics-corp.com
historian.meridiandynamics-corp.com   <-- flagged: possible OT exposure
```

## Detection Logic

Passive OSINT is, by definition, undetectable by the target. See `02-Scanning-and-Enumeration/` for the first phase that generates real telemetry.
