# Cloud IAM Privilege Escalation

| Chain | Technique | Tooling class |
|---|---|---|
| AWS | `iam:PassRole` + `lambda:CreateFunction` on an over-permissioned CI/CD role → EC2 instance role with admin → full account takeover path | Pacu / ScoutSuite-guided manual chaining |
| Azure AD | Guest-account → Application Administrator → credential add on a privileged service principal (T1098.001-equivalent) | AzureHound-class graph analysis |
| Cross-cloud | AWS-stored Azure AD app secret found in an S3 object (F-22 chain) → Azure tenant pivot | Manual correlation |

```bash
# Enumeration-only (no exploitation of production) — IAM policy simulation
aws iam simulate-principal-policy --policy-source-arn <role-arn> --action-names lambda:CreateFunction iam:PassRole
```

## Finding
**F-22 (Critical)** — CI/CD pipeline role can pass itself an admin-equivalent EC2 instance profile, confirmed path to full `mdx-prod` account takeover. A leaked Azure AD app secret in a misconfigured S3 bucket (`s3-assets`, publicly listable) extends this into a cross-cloud compromise chain:

```text
AWS CI/CD Role Abuse (F-22)
   |
   v
AWS Account Takeover (mdx-prod)

Azure AD App Secret in S3 (F-22 chain)
   |
   v
Azure AD Tenant Pivot
```

## Detection Logic
See [`../10-Detection-Engineering/sigma-rules/12-iam-passrole-lambda-chain.yml`](../10-Detection-Engineering/sigma-rules/12-iam-passrole-lambda-chain.yml).

## Topology Reference
See [`../topology/2-Traffic-Flow-Diagrams.md`](../topology/2-Traffic-Flow-Diagrams.md#3-cicd--cloud-takeover-scenario-module-19) for the full CI/CD-to-cloud-takeover traffic flow this finding is based on.
