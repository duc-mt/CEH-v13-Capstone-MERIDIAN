# NIST AI Risk Management Framework (AI RMF 1.0) Mapping

Covers the two AI-specific findings from Module19 (`2-AI-in-Cybersecurity.md`) against AI RMF's four functions — relevant because CEH v13 formally introduces AI security as exam content, and because MDX's AI deployments (support chatbot, fraud-detection model) are now part of its attack surface.

| AI RMF Function | Sub-category | Finding | Gap |
|---|---|---|---|
| **Govern** | Accountability & transparency for third-party data inputs | F-27 | No documented data-provenance policy for the vendor CSV feed powering the fraud-detection model |
| **Map** | Context and risks of the AI system's intended use are documented | F-26 | The support chatbot's trust boundary (user input vs. system prompt) was not threat-modeled before deployment |
| **Measure** | System is evaluated for robustness against adversarial input | F-26 | No red-teaming (e.g., `garak`- or `promptfoo`-class prompt-injection test suites) had been run against the chatbot prior to this engagement |
| **Measure** | Model performance is monitored for data-quality degradation | F-27 | No drift/integrity monitoring on the fraud-model's ingested features |
| **Manage** | Third-party risks are managed as part of the AI system's lifecycle | F-27 | Vendor feed has no integrity validation (checksum/schema contract) before ingestion |

## Recommended Follow-On (beyond this engagement's scope)
- Run a scheduled adversarial-robustness test suite (prompt-injection corpus via `garak` or `promptfoo`-class tooling) against the chatbot as a recurring control, not a one-time pentest finding.
- Add schema + checksum validation at the vendor-feed ingestion point (closes F-27 at the control level, not just the instance level).
- Extend `../11-Reporting/2-Remediation-Roadmap.md`'s "Ongoing" row to include a quarterly AI RMF self-assessment once these controls land.
