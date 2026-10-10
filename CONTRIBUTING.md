# Contributing

This is a capstone training project. If you fork it for your own CEH v13
study or to run a similar exercise in your own lab:

- Keep the **fictional org** (or swap in your own lab's fictional name) —
  never document real, non-consensual targets.
- Keep exploitation/credential-theft steps at technique + ATT&CK-ID level
  unless you are writing for your own isolated lab environment.
- Every new finding should follow the `11-Reporting/1-Findings-Register.md`
  format: ID, Description, Evidence, CVSS, Likelihood, Business Impact,
  Remediation, Validation Method.
- Every new offensive technique should ship with a matching Sigma rule in
  `10-Detection-Engineering/sigma-rules/`.
