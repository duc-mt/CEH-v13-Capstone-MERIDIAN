# AI-Based Countermeasures (v13 addition)

Following the phishing/vishing results in `0-Social-Engineering-Campaign.md` (F-07), MDX's AI-assisted email-security and helpdesk-coaching tools were evaluated:

| Control | Result |
| --- | --- |
| AI-based phishing email classifier (inline with mail gateway) | Caught 2 of 3 phishing pretexts pre-delivery; the "vendor invoice" pretext (benign tracking pixel, no macro) evaded it — **F-31** |
| LLM-assisted helpdesk coaching prompt (real-time vishing-risk flagging) | Not yet deployed at time of testing — recommended in `../11-Reporting/2-Remediation-Roadmap.md` as a mitigation for F-07 |

## Recommendation

Combine the existing AI email classifier with a real-time, LLM-based conversational-risk prompt for helpdesk agents during any MFA-reset or credential-related call — directly targets the vishing gap (F-07) alongside the out-of-band verification process control.
