# Cybersecurity Postgraduate Certificate — Cambrian College (Portfolio)

[![Portfolio CI](https://github.com/RossMora/cybersecurity-postgraduate-certificate-cambrian-college-ontario/actions/workflows/portfolio-ci.yml/badge.svg)](https://github.com/RossMora/cybersecurity-postgraduate-certificate-cambrian-college-ontario/actions/workflows/portfolio-ci.yml)

This public portfolio collects coursework and hands-on projects from the **Cybersecurity Postgraduate Certificate** at Cambrian College (Sudbury, Ontario), completed after a Bachelor of Applied Information Systems Technology (BAIST) at the Northern Alberta Institute of Technology (Edmonton).

## At a Glance

- **Course grade (Network Defense):** 93/100
- **Vulnerability remediation rate (final exam):** 95.7% (45 of 47 findings)
- **Hosts hardened in the capstone lab:** 7 VMs across Windows / Linux / OPNsense
- **GPOs configured in AD/GPO work:** 50+
- **Tooling:** Nessus, Nmap, OpenVAS/Greenbone, Wazuh, OPNsense, Active Directory & GPO, Bash, PowerShell, Ansible

## Skills → Roles

- **SOC Tier 1/2** — triage Wazuh alerts, enrich indicators, escalate with evidence
- **Vulnerability Management** — baseline, scan, prioritize, verify remediation
- **Network Security** — segmentation, firewall policy (OPNsense), IDS rules, packet analysis
- **Platform Hardening** — Windows (GPO/Defender), Linux (CIS-style), scripted patching

## How to Review This Portfolio

The portfolio is organized term → course. The Fall 2024 Network Defense course is the most extensive write-up.

```text
CC/
  September 2024/
    network-defense-fall-2024/                 ← CSC-7303-002, 93536
      README.md                                ← Course portfolio (start here)
      MIDTERM_PROJECT_SUMMARY.md               ← Multi-system hardening project (93/100)
      FINAL_EXAM_VULNERABILITY_ASSESSMENT.md   ← Vulnerability assessment (95.7% closure)
      EVIDENCE_INDEX.md                        ← Grouped screenshot captions
      SCRIPTS_README.md                        ← Script usage notes
      assignments/                             ← Lab and project PDFs
      scripts/                                 ← Hardening / remediation scripts
      scripts-extra/                           ← Lab infra & intentionally vulnerable baselines
      screenshots/                             ← Visual evidence
```

### Suggested reading paths

**5 minutes** — Read the *At a Glance* block above, then skim the [Network Defense course README](CC/September%202024/network-defense-fall-2024/README.md).

**15 minutes** — Read the [Midterm summary](CC/September%202024/network-defense-fall-2024/MIDTERM_PROJECT_SUMMARY.md) and the [Final exam vulnerability assessment](CC/September%202024/network-defense-fall-2024/FINAL_EXAM_VULNERABILITY_ASSESSMENT.md), then look at the four `Fix_*.sh` scripts in `CC/September 2024/network-defense-fall-2024/scripts/`.

**30 minutes** — Add the [Weekly Portfolio PDF](CC/September%202024/network-defense-fall-2024/WEEKLY_PORTFOLIO.pdf) plus the assignment PDFs in `CC/September 2024/network-defense-fall-2024/assignments/` for week-by-week deliverables.

## Quick Links

- [Network Defense — Fall 2024](CC/September%202024/network-defense-fall-2024/README.md)
- [Weekly Portfolio (PDF)](CC/September%202024/network-defense-fall-2024/WEEKLY_PORTFOLIO.pdf)

## References

- [Wazuh Documentation](https://documentation.wazuh.com/)
- [Nessus Product Page](https://www.tenable.com/products/nessus)
- [OPNsense Documentation](https://docs.opnsense.org/)
- [Greenbone (OpenVAS) Documentation](https://docs.greenbone.net/)

---

© 2025 Ross Moravec. See [LICENSE](LICENSE) for usage.
