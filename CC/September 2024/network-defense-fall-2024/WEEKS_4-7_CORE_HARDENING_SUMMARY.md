# Weeks 4–7 — Core Hardening Sequence

A short orientation to the four weeks that form the technical heart of the course. These weeks built the multi-OS hardening baseline that the midterm and final later validated.

## Week 4 — Linux Hardening (Ubuntu / CentOS)

- Brought both distributions to a current patch level (`apt`, `dnf/yum`).
- Established default-deny firewalls (UFW on Ubuntu, `firewalld` on CentOS) and explicitly allowed only SSH and HTTP.
- Disabled root SSH, switched to key-based authentication, installed Fail2Ban on Ubuntu.
- Deliverable: [`assignments/Week04_Lab_4_Implementing_Network_Security_Measures.pdf`](assignments/Week04_Lab_4_Implementing_Network_Security_Measures.pdf).

## Week 5 — Data-at-Rest

- BitLocker on Windows 11 (TPM-less GPO for the VM lab); recovery key stored out-of-band.
- LUKS file-backed encrypted volume on CentOS, mounted at `/mnt/encrypted`.
- Deliverable: [`assignments/Week05_Vulnerability_Testing_Midterm_Project.pdf`](assignments/Week05_Vulnerability_Testing_Midterm_Project.pdf).

## Week 6 — Vulnerability Assessment Baseline

- Credentialed Nessus scans against Ubuntu and CentOS; Nmap (`-sV --script vuln`) for protocol-level cross-check.
- Findings catalogued and prioritized by CVSS + exposure for the Week 7/8 remediation pass.
- Deliverable: [`assignments/Week06_Escalate_Win_VM_Midterm_Project.pdf`](assignments/Week06_Escalate_Win_VM_Midterm_Project.pdf).

## Week 7 — Ubuntu Remediation via Automation

- Authored [`scripts/Fix_Ubuntu_Nessus.sh`](scripts/Fix_Ubuntu_Nessus.sh) and [`scripts/Fix_Ubuntu_Nmap.sh`](scripts/Fix_Ubuntu_Nmap.sh) to close the Week 6 findings idempotently.
- Re-ran scans to confirm port/closure of `4444` and `3389`, disabled HTTP TRACE/TRACK, and verified SSH hardening.
- Deliverable: [`assignments/Week07_Security_Plan_Midterm_Project.pdf`](assignments/Week07_Security_Plan_Midterm_Project.pdf).
