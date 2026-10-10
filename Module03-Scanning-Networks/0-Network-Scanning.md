# Network Scanning

```bash
# Stealth SYN scan with service/version detection, on-prem range
nmap -sS -sV -O -T3 --top-ports 1000 -oA scan_onprem 10.40.0.0/16

# Cloud-scale fast sweep (authorized AWS ranges only, allow-listed w/ SOC)
masscan -p1-65535 203.0.113.0/24 --rate 2000 -oJ masscan_cloud.json
```

| Host | Open Ports | Service Fingerprint | Notes |
|---|---|---|---|
| 10.40.1.10 | 88,389,445,636 | Windows Server 2019 AD DC | Primary DC, SMB signing check needed |
| 10.40.2.55 | 443,8443 | nginx + custom API | Candidate for `07-Web-App-and-API-Hacking/` |
| 10.40.5.20 | 502,102 | Modbus/S7comm | **OT — read-only enumeration only**, see `08-Wireless-and-IoT-OT-Hacking/2-OT-ICS.md` |

## Decoy / Evasion Baseline
A light evasion baseline is run here and re-validated in `06-Network-Hacking-Sniffing-Evasion/1-IDS-Firewall-Honeypot-Evasion.md`.
