# Remediation Validation / Retest Methodology

**Not an official CEH v13 module** — added because a real engagement doesn't end at the findings register (`../11-Reporting/1-Findings-Register.md`); it ends when fixes are verified. Numbered 21 to keep it out of the way of the official 1–20 sequence.

## Scope

Retest is run only against findings MDX marked "remediated" in their tracker, following the timeframes in `../11-Reporting/2-Remediation-Roadmap.md`. Each retest:

1. Re-runs the **exact original test** from the source module (same tool, same technique) — not a new/different test.
2. Captures before/after evidence side by side.
3. Is independently timestamped and, where the original finding had a Sigma rule, re-validates that the rule still fires or correctly no longer fires (for compensating-control fixes vs. root-cause fixes).

## Candidates for This Capstone's Retest Pass

Prioritized by the 0–30 day roadmap tier (fastest to have real remediation evidence available):

| Finding | Original Module | Fix Expected | Retest Method |
| --- | --- | --- | --- |
| F-04 | Module05 | nginx module patched/removed | Re-run `nuclei` against the same template set |
| F-06 | Module06 | `svc_backup` reset + gMSA enforced | Re-attempt Kerberoasting; confirm TGS request yields no crackable ticket |
| F-12 | Module14/Module20 | JWT `alg:none` rejected | Re-run the algorithm-confusion Burp test |
| F-23 | Module19 | S3 public listing closed | Re-run `aws s3api get-bucket-acl` / anonymous `curl` |

See `1-Closure-Evidence.md` for the evidence template and `2-Closure-Letter.md` for the client-facing sign-off document.
