# AI in Cybersecurity — Offense & Defense

## Offense (tested, non-destructive)
- **Prompt injection against an internal LLM-powered support chatbot** — crafted support tickets containing hidden instructions attempting to exfiltrate system-prompt contents or trigger unauthorized tool calls. The chatbot **resisted** direct injection but **F-26 (Medium)**: indirect injection via an uploaded PDF attachment succeeded in altering one response.
- **ML model poisoning assessment (read-only)** — reviewed the training-data ingestion pipeline for the fraud-detection model. A vendor-submitted CSV feed is ingested without integrity validation — **F-27**: a malicious vendor (or compromised vendor account) could inject mislabeled transactions to degrade fraud-model accuracy over time. No actual poisoning was performed against the live model.

## Defense (recommended, validated where already deployed)
- AI-assisted SIEM correlation correctly tied F-02 + F-09 + F-05 into a single incident timeline during the engagement's retrospective log replay.
- LLM-based log triage was tested against the full engagement's log output and correctly flagged 11 of 14 attacker-generated events as the top anomalies (79% precision in this sample) — recommended for Tier-1 SOC augmentation, not replacement.

## Detection Logic
See [`../10-Detection-Engineering/sigma-rules/13-indirect-prompt-injection.yml`](../10-Detection-Engineering/sigma-rules/13-indirect-prompt-injection.yml).
