# Midterm Project: Multi-System Security Hardening & Integration
## Grade: 93/100

### Project Overview
This project hardened a multi-VM environment (Windows Server 2022, Windows 11, Ubuntu, CentOS, OPNsense) and integrated identity + monitoring.

### Objectives Achieved
- Domain Controller deployment and GPO configuration
- Windows/Linux baseline hardening
- OPNsense firewall rules + segmentation
- Wazuh SIEM visibility across hosts

### Architecture Deployed
```
[Client] -- [OPNsense] -- [Server 2022 DC] -- [Ubuntu/CentOS] -- [Wazuh]
```

### Key Implementations
1. Active Directory setup and OU structure (evidence in screenshots/)
2. Windows Server + Windows 11 hardening (assignments PDFs)
3. Ubuntu/CentOS hardening scripts (scripts/)
4. OPNsense rules + NAT (screenshots/)
5. Wazuh agent deployment and alerting (screenshots/)

### Evidence Links
- See assignments/ PDFs for lab deliverables
- See scripts/ for automation and remediation
- See screenshots/ for configuration and results

### Challenges & Solutions
- Service exposure: reduced via firewall + service pruning
- SSH/WinRM security: hardened auth and policies

### What This Demonstrates
- Multi-system security engineering, automation, and verification

### Key Metrics
| Metric | Value |
|-------|-------|
| Course Grade | 93/100 |
| Systems Hardened | 7 |
| GPO Policies Configured | 50+ |

### Evidence Links
- See assignments/ PDFs for lab deliverables
- See scripts/ for automation and remediation
- See screenshots/ for configuration and results
- Before/After examples:
  - OPNsense dashboard: screenshots/wk12_opnsense_5.png
  - Lab 6 validation: screenshots/wk10_lab6_12.png
  - Lab setup: screenshots/Screenshot1_LabSetup.png
