# Maintaining Access

- Scheduled Task persistence (T1053.005) on a jump host — created, documented, **removed same day**.
- Simulated C2 beacon over DNS (low-and-frequency, allow-listed with SOC in advance) to validate egress-filtering gaps — no real C2 framework deployed against production.
- AD persistence technique named only: shadow-credential abuse path **identified and reported, not executed** — would create a Tier-0 backdoor, which is out of RoE for execution, but in-scope for identification.

All persistence artifacts created during this phase were removed before the engagement moved on, per the Engagement Charter's "clean-as-you-go" principle.
