## What does this PR change?

<!-- One or two sentences. Which module(s)/finding(s)/topology file(s)? -->

## Checklist

- [ ] Fictional org/scenario only — no real, non-consensual targets named or implied
- [ ] Exploitation/credential-theft content stays at technique + ATT&CK-ID level (see `CONTRIBUTING.md`), unless this PR is scoped to `lab-environment/` content for your own isolated lab
- [ ] New finding follows the format in `11-Reporting/1-Findings-Register.md`
- [ ] New finding added to `appendix/0-Findings-Index.md` and, if asset-specific, `topology/3-Master-Asset-Inventory.md`
- [ ] New offensive technique has a matching Sigma rule in `10-Detection-Engineering/sigma-rules/`
- [ ] New/changed IPs, hosts, or segments added to `topology/1-IP-VLAN-Addressing-Scheme.md`
- [ ] If this touches `lab-environment/terraform/` or `lab-environment/docker/` — CI (`terraform-validate.yml` / `docker-validate.yml`) passes
- [ ] Cross-references (`[text](../path.md)`) checked — link-check CI will catch broken ones, but a quick look first helps

## Why

<!-- Context for the change, if not obvious from the above. -->
