# Security Policy

## About This Repository

This repository documents a **fictional** Red Team engagement (Meridian Dynamics / MDX) built for CEH v13 capstone and training purposes. It contains:

- Technique-level, ATT&CK-mapped descriptions of offensive security methodology (not weaponized exploit code)
- Sigma detection rules
- Infrastructure-as-code (`lab-environment/`) that is **intentionally vulnerable by design**, meant for deployment only in an isolated personal/sandbox lab

## Reporting a Problem With This Repository

If you find:

- A technique description that crosses from "educational/technique-level" into something that reads as a ready-to-run weaponized exploit
- A `lab-environment/` config that could plausibly cause harm if misapplied outside an isolated lab (e.g., something that doesn't fail safely)
- Any content that could reasonably facilitate unauthorized access to real systems

Please open an issue using the **Documentation Bug** template, or contact the maintainer directly rather than filing a public issue if the concern itself is sensitive.

## Using This Repository Safely

- **Never** run anything in `lab-environment/` against infrastructure you don't own or aren't explicitly authorized to test.
- The `lab-environment/terraform/` configuration provisions deliberately over-permissioned AWS IAM roles — deploy only in a disposable sandbox account, and always `terraform destroy` when done.
- Nothing in this repository is authorization to test any real system. See `00-Engagement-Charter/0-Scope-and-RoE.md` for how a real Rules-of-Engagement document should look before any testing occurs.

## Supported Versions

This is a training/portfolio project, not a software product — there are no versioned "supported releases" in the usual sense. The `main` branch is always the current, maintained version.
