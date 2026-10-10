# Notes for Publishing This as a Public Work Sample

If this repo is headed to a public GitHub profile as a CEH v13 / Red Team portfolio piece:

## Before Publishing

- [ ] Confirm every host/IP/org name is fictional (`meridiandynamics-corp.com`, `mdx-prod`, all internal IPs) — grep for any real identifiers you may have substituted in while adapting this to a real lab.
- [ ] If you actually built the `lab-environment/` infrastructure, scrub any real cloud account IDs, real IPs from screenshots, and real API keys/secrets before committing evidence.
- [ ] Re-check `LICENSE` and `CONTRIBUTING.md` still reflect how you want this reused.

## What to Lead With

Reviewers (hiring managers, CEH instructors) skim in this order — put effort there first:

1. `README.md` — does the 20-module structure read as deliberate, not padded?
2. `diagrams/attack-chain.md` — the single compromise chain is the fastest way to show you can think in attack paths, not just run tools.
3. `11-Reporting/0-Executive-Summary-Risk-Assessment.md` — business-framing ability is what separates a junior tester from a consultant.
4. One fully fleshed module (Module06 or Module19 are the deepest) — pick whichever matches the role you're targeting.

## Optional Per-Module Blog-Post Treatment

If you want to extend this further for a blog/portfolio site rather than just a repo: each module's "Objective → Tooling → Execution → Finding → Detection" structure already maps cleanly to a short blog post. Module 06 (System Hacking, the Kerberoasting chain) and Module 19 (Cloud, the IAM takeover) are the two with the strongest narrative hooks if you only have time to adapt two.
