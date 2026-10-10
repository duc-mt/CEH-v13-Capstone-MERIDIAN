# Container & Serverless Security (v13 addition)

## Container Security (EKS)
| Test | Tooling class | Result |
|---|---|---|
| Pod Security Standards review | `kubectl` + policy-as-code review (OPA/Gatekeeper) | No `restricted` PSS enforced — pods can run as root — **F-41** |
| Image provenance / signing | `cosign` verification against the registry | Images are unsigned; no admission-controller enforcement of signed images — **F-42** |
| Secrets-in-env review | `kubectl get pods -o yaml` review (read-only) | Database credentials passed as plaintext env vars instead of mounted secrets/External Secrets Operator — **F-43**, compounds F-24 (public EKS API) |

## Serverless Security (Lambda)
| Test | Tooling class | Result |
|---|---|---|
| Over-privileged execution roles | IAM policy review | Several Lambda functions carry `*:*` wildcard actions far beyond their function — directly related to the F-22 PassRole chain |
| Dependency/supply-chain review | `npm audit` / `pip-audit` against deployed function packages | 2 functions bundle a dependency with a known critical CVE — **F-44** |
| Event-source injection | Crafted malformed S3-event payloads against a test function | Function correctly validates and rejects malformed events — pass |

## Findings Summary
**F-41 to F-44** extend the cloud risk picture beyond the IAM chain in `0-Cloud-IAM-Privilege-Escalation.md`: container and serverless workloads inherit the same "identity and configuration over code vulnerabilities" pattern seen across the rest of this engagement (see `../11-Reporting/2-Remediation-Roadmap.md` Strategic Recommendation #1).

## Detection Logic
```yaml
title: Lambda Function Invoked With Wildcard IAM Action
logsource: {product: aws, service: cloudtrail}
detection:
  selection:
    eventName: 'Invoke'
    executionRolePolicy|contains: '"Action":"*"'
  condition: selection
level: high
tags: [attack.privilege_escalation, attack.t1078.004]
```
