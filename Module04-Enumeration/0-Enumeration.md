# Enumeration

| Protocol | Tool | What it reveals |
| --- | --- | --- |
| SMB/AD | `enum4linux-ng`, `crackmapexec smb --shares` | Null-session shares, OS build, domain trusts |
| LDAP | `ldapsearch -x -H ldap://10.40.1.10 -b "dc=corp,dc=local"` | User/group OUs, password policy, service accounts |
| SNMP | `onesixtyone`, `snmpwalk -v2c -c public` | Community strings, device inventory |
| Cloud IAM | `aws iam list-users / list-roles --profile mdx-readonly` | Over-privileged roles, stale access keys |

```bash
crackmapexec smb 10.40.0.0/24 --shares -u '' -p ''
ldapsearch -x -H ldap://10.40.1.10 -D '' -w '' -b 'dc=corp,dc=local' '(objectClass=user)' sAMAccountName | head
```

## Findings

- **F-02** — Null SMB sessions enabled on 14 hosts.
- **F-03** — Service account `svc_backup` has `PASSWD_NOTREQD` flag set, and a Kerberoastable SPN (picked up again in `04-System-Hacking/1-Privilege-Escalation.md`).

## Detection Logic

See [`../10-Detection-Engineering/sigma-rules/02-smb-enumeration-burst.yml`](../10-Detection-Engineering/sigma-rules/02-smb-enumeration-burst.yml).

## BGP & NFS Enumeration (v13 addition)

| Protocol | Tool | What it reveals |
| --- | --- | --- |
| BGP | `bgpdump`, public looking-glass queries against MDX's announced ASN | Peering relationships, announced prefixes — useful for mapping MDX's full public IP footprint beyond DNS-derived scope |
| NFS | `showmount -e <host>`, `rpcinfo -p <host>` | Exported shares, no_root_squash misconfigurations |

```bash
showmount -e 10.40.3.40
rpcinfo -p 10.40.3.40
```

**Finding F-28** — An NFS export on the build server (`10.40.3.40:/srv/builds`) is exported with `no_root_squash` to the entire `10.40.0.0/16` range, allowing any host on that range to write as root to build artifacts (supply-chain risk, flagged for `../Module06-System-Hacking/`).
