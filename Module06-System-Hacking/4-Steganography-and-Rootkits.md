# Steganography & Rootkits (v13 addition)

## Steganography — Covert Evidence-Handling Channel Test

To validate DLP coverage of non-obvious exfiltration channels, a synthetic canary string was embedded in the LSBs of a benign PNG (`steghide`-class tooling) and uploaded through an approved file-sharing path.

```bash
steghide embed -cf cover.png -ef canary.txt -p '<test-passphrase>'
```

**Finding F-29** — DLP did not flag the steganographically embedded canary file; content-inspection is signature/metadata based only, not byte-distribution based. Recommendation folded into `../11-Reporting/2-Remediation-Roadmap.md`.

## Rootkit Awareness Test

A benign, non-persistent kernel-module-loading test (reverted immediately) was used to validate whether MDX's EDR flags unsigned kernel module load attempts on a lab-isolated Linux host — **not performed against production**.

**Finding F-30** — EDR correctly blocked the unsigned module load attempt and alerted within 2 minutes — positive control finding.
