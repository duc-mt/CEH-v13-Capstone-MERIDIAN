# Closure Evidence — Template & Worked Examples

Every retested finding gets one entry in this format.

```text
Finding ID:        F-06
Original Severity: Critical
Remediation Owner: NetSec/AD Team
Fix Applied:       svc_backup password rotated, gMSA migration completed,
                    Kerberos AES-only enforced on the account
Retest Date:        <date>
Retest Method:      Re-ran the Module06 Kerberoasting TGS request against
                    svc_backup's SPN; attempted offline cracking against
                    the same wordlist/rule set used in the original test
Before:             Ticket (RC4, 0x17) obtained and cracked in <4 min
After:              Ticket now AES256 (0x12); offline cracking attempt
                    against the same wordlist/rule set did not complete
                    within a 24h bounded retest window
Residual Risk:      Low — gMSA removes the human-password weak link entirely;
                    recommend periodic SPN audit to catch future regressions
Status:             CLOSED
```

## Worked Example — F-23 (fast win, typical of 0–30 day fixes)

```text
Finding ID:        F-23
Fix Applied:       S3 Block Public Access enabled account-wide; bucket policy
                    scoped to specific principals
Retest Method:      Anonymous `curl` against the bucket's listing endpoint;
                    `aws s3api get-public-access-block`
Before:             Anonymous listing returned full object index
After:              403 Forbidden; Block Public Access confirmed ON
                    for all 4 settings
Status:             CLOSED
```

## Worked Example — Partial/Compensating Fix

```text
Finding ID:        F-21
Fix Applied:       Historian ACL updated to restrict Modbus reads to the
                    engineering workstation subnet (compensating control —
                    the historian itself has no native authentication)
Retest Method:      Re-ran mbtget from a non-engineering subnet (lab sim,
                    see lab-environment/3-OT-Modbus-Simulator.md)
Before:             Read succeeded from any VLAN50-routable host
After:              Read now times out from outside the engineering subnet;
                    still succeeds from the authorized subnet (expected —
                    no native auth exists at the protocol level)
Residual Risk:      Medium — compensating control, not root-cause fix;
                    native Modbus auth/TLS is not available on this legacy
                    historian without a vendor firmware upgrade
Status:             PARTIALLY CLOSED — compensating control in place
```
