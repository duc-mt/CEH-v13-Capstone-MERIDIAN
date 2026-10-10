# IoT (Building / Badge Systems)

| Device Class | Technique | Result |
|---|---|---|
| IP cameras (8x) | Default credential check, firmware pull via `binwalk` | 3 of 8 on default creds — **F-19** |
| Badge reader controller | Unencrypted Wiegand-over-IP traffic capture (passive) | Cleartext badge IDs observable on VLAN — **F-20** |

## Mobile Platform Note
No MDX-managed mobile devices were in scope for this engagement; MDM enrollment and app-vetting review is flagged as a candidate scope addition for a future engagement.
