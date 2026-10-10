# Lessons Learned

1. **Public-facing services remain the highest-risk entry point.** A single unpatched internet-facing component opened the entire chain in `../diagrams/attack-chain.md`.
2. **Identity misconfigurations created a larger attack surface than software vulnerabilities.** Three of four Critical findings trace to credential/ACL weaknesses, not novel exploits.
3. **Cloud privilege-escalation paths were more impactful than traditional host compromise.** The AWS CI/CD role chain (F-22) reached full account takeover faster than the on-prem AD path reached Domain Admin.
4. **OT segmentation held.** No Level 0/1 write access was achieved or attempted — the Purdue boundary controls worked as designed, though the Level 2/3 read gap (F-21) should still close.
5. **AI-assisted offensive testing found what manual testing missed.** The business-logic flaw in `07-Web-App-and-API-Hacking/1-AI-Driven-Fuzzing.md` was not surfaced by 40+ hours of conventional manual testing in the legacy baseline methodology — and AI-assisted detection triage outperformed point-in-time Sigma rules for cross-phase correlation.
