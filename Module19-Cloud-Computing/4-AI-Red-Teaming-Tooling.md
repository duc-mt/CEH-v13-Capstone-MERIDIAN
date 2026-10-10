# AI Red-Teaming Tooling (v13 addition — deepened)

Extends `2-AI-in-Cybersecurity.md`'s F-26/F-27 findings with the tooling classes a follow-on engagement would use to move from "we found one injection gap manually" to "we systematically red-teamed the AI surface."

## Prompt-Injection / LLM Red-Teaming

| Tool class | What it does | Applies to |
| --- | --- | --- |
| `garak`-class scanner | Automated probe corpus for prompt injection, jailbreaks, data-leakage, and training-data extraction against an LLM endpoint | The support chatbot (F-26) |
| `promptfoo`-class eval framework | Regression-tests prompt/guardrail changes against a curated adversarial test set, CI-integratable | Same chatbot, as an **ongoing** control per `../12-GRC-Compliance-Mapping/2-NIST-AI-RMF-Mapping.md` |

```bash
# Illustrative — point at a lab/sandbox LLM endpoint only, never a production
# customer-facing system without explicit authorization for AI-specific testing
garak --model_type rest --model_name mdx-lab-chatbot --probes promptinject,leakreplay
```

## Adversarial ML / Model Integrity

| Tool class | What it does | Applies to |
| --- | --- | --- |
| Adversarial-robustness toolkits (e.g., ART-class libraries) | Generate adversarial/poisoned sample batches against a model **copy**, offline | Fraud-detection model (F-27), tested against a cloned model + synthetic data only, never the live model |
| Data-lineage/schema validation tooling | Enforces a contract on ingested vendor feeds | Closes F-27 at the control level |

## Where This Fits the Engagement

Both F-26 and F-27 were found through **manual, single-pass testing** in the original engagement. The tooling above is what a dedicated AI red-team follow-on would run on a recurring basis — recommended as its own scoped mini-engagement rather than folded into the next annual pentest, since AI surfaces drift (model/prompt updates) faster than typical infrastructure.
