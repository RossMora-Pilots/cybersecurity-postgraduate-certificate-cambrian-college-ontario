# Scripts — Usage and Notes

This document summarizes the purpose and basic usage of each script.

## Student-Created Scripts (scripts/)
- `Fix_CentOS_Nessus.sh` — Fix_CentOS_Nessus.sh – Address Nessus-reported vulnerabilities on CentOS Machine-specific check — [OK]
- `Fix_CentOS_Nmap.sh` — Fix_CentOS_Nmap.sh – Address Nmap-identified issues on CentOS Machine-specific check — [OK]
- `Fix_Ubuntu_Nessus.sh` — Fix_Ubuntu_Nessus.sh – Script to address vulnerabilities identified by Nessus on Ubuntu Machine-Specific Precheck — [OK]
- `Fix_Ubuntu_Nmap.sh` — Fix_Ubuntu_Nmap.sh – Script to address vulnerabilities identified by Nmap on Ubuntu Ensure the script is run on the correct system — [OK]
- `install_openvas.sh` — install_openvas.sh – Automates OpenVAS installation and setup on Kali — [OK]
- `kali_update.sh` — kali_update.sh — nightly updates for Kali — [OK]

## Provided/External Scripts (scripts-extra/)
- `1_networkadapters.ps1` — Create a NAT network called "WAN" — [OK]
- `2_img_to_iso.ps1` — Path to oscdimg — [OK]
- `3_img_to_vdi.ps1` — No description — [OK]
- `VulnerableCentOS.sh` — Intentionally Vulnerable Script for CentOS Stream 9 Use ONLY in an isolated educational lab environment! Run as root or with sudo privileges. — [OK]
- `VulnerableUbuntu.sh` — Intentionally Vulnerable Script for Ubuntu 24.04 Use ONLY in an isolated educational lab environment! Run as root or with sudo privileges. — [OK]
- `makevulnerable.ps1` — EXTREMELY VULNERABLE POWER SHELL SCRIPT                                 # WARNING: Use in an isolated lab environment ONLY!                       # WARNING: DO NOT use this script on production or connected systems.     # WARNING: The vulnerabilities introduced can result in full compromise! # — [OK]


Safety: Review scripts before running; test in lab VMs. Use with appropriate privileges.
