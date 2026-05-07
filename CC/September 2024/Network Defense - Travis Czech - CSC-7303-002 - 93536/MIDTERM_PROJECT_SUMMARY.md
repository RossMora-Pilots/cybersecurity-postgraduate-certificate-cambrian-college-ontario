# Midterm Project — Multi-System Security Hardening & Integration

**Course:** CSC-7303 Network Defense (Cambrian College, Fall 2024)
**Grade:** 93/100

## Executive Summary

This midterm project hardened a five-host lab environment (Windows Server 2022 DC, Windows 11 client, Ubuntu 24, CentOS Stream 9, OPNsense gateway) and bound the hosts together with centralized identity (AD/GPO) and centralized monitoring (Wazuh). Each system was treated as a layer of defense-in-depth: the perimeter at OPNsense, identity and policy at the DC, host-level controls on each endpoint, and detection on top.

## Architecture

```
                ┌────────────┐
                │  Internet  │
                └──────┬─────┘
                       │
              ┌────────┴────────┐
              │  OPNsense GW    │  default-deny inbound, NAT, segmentation
              └────────┬────────┘
              ┌────────┼────────┬─────────────────┐
              │        │        │                 │
        ┌─────┴───┐ ┌──┴───┐ ┌──┴───┐         ┌───┴────┐
        │ WS 2022 │ │Ubuntu│ │CentOS│  …      │ Win 11 │
        │  DC/DNS │ │      │ │      │         │ client │
        └─────┬───┘ └──┬───┘ └──┬───┘         └───┬────┘
              │        │        │                 │
              └────────┴────────┴────────┬────────┘
                                          │
                                  ┌───────┴───────┐
                                  │  Wazuh SIEM   │
                                  └───────────────┘
```

## What I Built

### Identity & Policy (Windows Server 2022)

- Promoted to **Domain Controller** with AD DS + DNS for `LAB.LOCAL`.
- Created an OU structure (`Servers`, `Workstations`, `Users`) and seeded test accounts.
- Configured 50+ GPOs covering: SMBv1 disable, Windows Defender Firewall enforcement, BitLocker policy (allow-without-TPM for VM), audit logging, password policy.

### Endpoints (Windows 11, Ubuntu 24, CentOS Stream 9)

- **Windows 11:** Domain-joined; enabled BitLocker; disabled legacy services (Telnet, SMBv1).
- **Ubuntu:** UFW default-deny; SSH key-only with `PermitRootLogin no`; Fail2Ban; updates pinned.
- **CentOS:** `firewalld` default-deny zone; `httpd` headers hardened (`ServerTokens Prod`, `ServerSignature Off`, TRACE off); LUKS-encrypted volume mounted at `/mnt/encrypted`.

### Perimeter (OPNsense)

- Replaced the default permissive ruleset with explicit allow-lists (admin RDP scoped to a single management host, outbound web only).
- Configured aliases for management subnets and applied per-interface firewall rules.

### Detection (Wazuh)

- Stood up the manager and rolled agents to all four endpoints.
- Verified ingestion: SSH brute-force attempts on the Ubuntu host triggered alert level ≥10 within seconds.
- Tuned a small set of rules to reduce noise (Windows Defender informational events).

## Key Metrics

| Metric | Value |
|---|---|
| Course grade | 93/100 |
| Hosts hardened | 5 (incl. gateway) |
| GPOs configured | 50+ |
| Wazuh agents deployed | 4 |
| Lab duration | 8 weeks (cumulative) |

## Lessons Learned

- **Layer ordering matters.** Hardening individual hosts before the AD/GPO layer was in place created drift; rolling GPOs in early made later changes propagate cleanly.
- **Default-deny pays dividends.** Each time I tightened the firewall I broke something I had forgotten about, which surfaced legacy assumptions worth fixing.
- **SIEM without tuning is noise.** Wazuh's out-of-the-box rules generate too many low-severity alerts; carving out the relevant ones is half the work.

## Evidence

- Lab deliverables: see [`assignments/`](assignments/) (`Midterm_2_*.pdf`, `Midterm_3_*.pdf`, weekly `Week01`–`Week08` PDFs).
- Automation used in remediation: [`scripts/`](scripts/) (`Fix_Ubuntu_*.sh`, `Fix_CentOS_*.sh`).
- Visual evidence: [`screenshots/wk01_labsetup_1.png`](screenshots/wk01_labsetup_1.png), [`screenshots/wk12_opnsense_4.png`](screenshots/wk12_opnsense_4.png), and the screenshots indexed in [`EVIDENCE_INDEX.md`](EVIDENCE_INDEX.md).
