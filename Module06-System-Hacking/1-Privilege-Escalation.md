# Privilege Escalation

| Platform | Technique (ATT&CK) | Notes |
|---|---|---|
| Windows host | Token Impersonation (T1134) after local foothold | Standard post-ex module; output logged, not reproduced here |
| Linux host | Sudo misconfiguration (`NOPASSWD` on `/usr/bin/vim`) — T1548.003 | GTFOBins pattern, config captured as evidence |
| Active Directory | Kerberoasting (T1558.003) against `svc_backup` (weak password policy, F-03) | Hash cracked offline in an isolated lab rig, not on client infrastructure |
| AD → Domain Admin | ACL abuse chain mapped via BloodHound (`GenericAll` on a Tier-0 OU) | Attack path graph: `../diagrams/attack-chain.md` |

```text
# hashcat invocation pattern (offline, isolated cracking rig — no client data retained post-test)
hashcat -m 13100 krbtgt_hashes.txt wordlist.txt -r rules/best64.rule
```

## Finding
**F-06** — `svc_backup` → ACL chain → Domain Admin in 3 hops:

```text
svc_backup (Kerberoastable SPN, weak password)
   |
   v
Delegated OU Control (GenericAll grant)
   |
   v
Tier-0 Object Modification
   |
   v
Domain Admin
```

**Residual risk if unpatched:** a single Kerberoastable service account with a weak password currently yields full Domain Admin — rated **Critical**, remediation in `../11-Reporting/2-Remediation-Roadmap.md`.

## Detection Logic
See [`../10-Detection-Engineering/sigma-rules/05-kerberoasting.yml`](../10-Detection-Engineering/sigma-rules/05-kerberoasting.yml) and [`06-acl-abuse.yml`](../10-Detection-Engineering/sigma-rules/06-acl-abuse.yml).
