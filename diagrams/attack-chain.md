# Full Compromise Chain — Operation MERIDIAN

```text
Internet
   |
   v
F-04  Public API RCE (api-gateway-02)
   |
   v
Internal Linux Host (foothold)
   |
   v
svc_backup Service Account Discovery (F-03)
   |
   v
Kerberoasting (F-06)
   |
   v
Domain Admin (via Tier-0 OU ACL abuse)
   |
   +------> AWS CI/CD Role Abuse (F-22)
   |             |
   |             v
   |      AWS Account Takeover (mdx-prod)
   |
   +------> Azure AD App Secret in S3 (F-22 chain)
                 |
                 v
         Azure AD Tenant Pivot
```

This single chain is the spine of the engagement: every phase folder in this repo (`01` through `09`) documents one link. See `../11-Reporting/0-Executive-Summary-Risk-Assessment.md` for the business-impact read of this chain.

## Kerberoasting Hop Detail

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
