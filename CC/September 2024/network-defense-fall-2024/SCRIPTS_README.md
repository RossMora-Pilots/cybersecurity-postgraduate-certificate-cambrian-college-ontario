# Scripts — Usage and Notes

All scripts share a common shape:

- `#!/usr/bin/env bash` shebang and `set -euo pipefail` — fail fast on errors and undefined variables.
- A hostname precheck so the script refuses to run on the wrong host. Pass `--force` to override (useful when running outside the original lab VM).

Run as root or via `sudo`.

## Student-Authored (`scripts/`)

| Script | Purpose |
|---|---|
| [`Fix_Ubuntu_Nessus.sh`](scripts/Fix_Ubuntu_Nessus.sh) | Address Nessus findings on Ubuntu — Suricata update, SSH hardening, Apache update, malicious cron/service removal. |
| [`Fix_Ubuntu_Nmap.sh`](scripts/Fix_Ubuntu_Nmap.sh) | Address Nmap findings on Ubuntu — disable HTTP TRACE/TRACK, close ports 4444/3389 via UFW. |
| [`Fix_CentOS_Nessus.sh`](scripts/Fix_CentOS_Nessus.sh) | Address Nessus findings on CentOS Stream 9 — file-permission baseline, `httpd`/Suricata patching, SSH hardening. |
| [`Fix_CentOS_Nmap.sh`](scripts/Fix_CentOS_Nmap.sh) | Address Nmap findings on CentOS — `firewalld` enforcement, Apache header hardening, service pruning. |
| [`install_openvas.sh`](scripts/install_openvas.sh) | Install and initialize OpenVAS / Greenbone on Kali. |
| [`kali_update.sh`](scripts/kali_update.sh) | Nightly unattended `apt update && upgrade && autoremove` on Kali. |

### Example invocations

```bash
sudo ./Fix_Ubuntu_Nessus.sh                # runs only on hostname=ubuntu-desktop
sudo ./Fix_Ubuntu_Nessus.sh --force        # bypass the hostname check
sudo ./kali_update.sh                      # safe to run anywhere apt is present
```

## Provided / External (`scripts-extra/`)

These were supplied by the instructor for course infrastructure and adversarial-baseline scenarios. They are kept here for transparency about how the lab environment was prepared and how starting-state vulnerabilities were introduced.

| Script | Purpose |
|---|---|
| `1_networkadapters.ps1` | Create a NAT network ("WAN") in VirtualBox for the lab topology. |
| `2_img_to_iso.ps1` | Convert image media during VM preparation. |
| `3_img_to_vdi.ps1` | Convert disk images to VDI for VirtualBox. |
| `VulnerableCentOS.sh` | **Deliberately weakens** a CentOS Stream 9 VM for the final-exam scenario. |
| `VulnerableUbuntu.sh` | **Deliberately weakens** an Ubuntu 24.04 VM for the final-exam scenario. |
| `makevulnerable.ps1` | **Deliberately weakens** a Windows VM (disables UAC, enables SMBv1, etc.). |

> **Safety:** Every "Vulnerable*" script reduces security on purpose. They must only run inside an isolated, disposable lab VM that has no internet routing or shared credentials. See `scripts-extra/README.md` for the full warning.
