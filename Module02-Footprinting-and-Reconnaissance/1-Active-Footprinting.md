# Active Footprinting

```bash
dnsrecon -d meridiandynamics-corp.com -t axfr,std
nmap -sL -Pn -iL subs_resolved.txt -oA active_recon_pass1
```

## Finding
**F-01 — Zone Transfer Permitted on Secondary DNS.** The secondary nameserver for `meridiandynamics-corp.com` allowed a full AXFR, leaking the complete internal + external zone file including a previously-unknown host (`historian.meridiandynamics-corp.com`).

## Detection Logic
See [`../10-Detection-Engineering/sigma-rules/01-dns-axfr-enumeration.yml`](../10-Detection-Engineering/sigma-rules/01-dns-axfr-enumeration.yml).

Active DNS/AXFR attempts are the **first telemetry event** MDX's SOC should see in this engagement.
