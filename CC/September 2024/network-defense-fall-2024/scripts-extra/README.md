# scripts-extra — Lab infrastructure & intentionally vulnerable baselines

> **DANGER — READ BEFORE RUNNING ANYTHING IN THIS FOLDER.**
>
> This folder contains scripts supplied by the course instructor. **Three of them deliberately reduce security on the target VM** so that students can practice detection and remediation against a known-bad baseline:
>
> - `VulnerableCentOS.sh`
> - `VulnerableUbuntu.sh`
> - `makevulnerable.ps1`
>
> Running them on a host that is connected to a real network, shares credentials with other systems, or holds anything you care about will create real, exploitable weaknesses. Treat them like malware: only run inside an isolated, snapshotted lab VM with no internet routing.

## Files

| File | Purpose | Risk |
|---|---|---|
| `1_networkadapters.ps1` | Create a NAT network ("WAN") in VirtualBox for the lab topology. | Low (lab plumbing). |
| `2_img_to_iso.ps1` | Convert image media during VM preparation. | Low. |
| `3_img_to_vdi.ps1` | Convert disk images to VDI for VirtualBox. | Low. |
| `VulnerableCentOS.sh` | Apply known-weak settings to a CentOS Stream 9 VM (lab/exam). | **HIGH — intentional weakening.** |
| `VulnerableUbuntu.sh` | Apply known-weak settings to an Ubuntu 24.04 VM (lab/exam). | **HIGH — intentional weakening.** |
| `makevulnerable.ps1` | Disable UAC, enable SMBv1, store plaintext creds, weaken ACLs on a Windows VM. | **HIGH — intentional weakening.** |

## Why include them?

A portfolio reviewer should be able to see exactly what starting state the remediation work in [`../scripts/`](../scripts/) was applied to. Including these (with this warning) is more honest than describing the baseline second-hand.

## Hard rules

- **Do not** run any "Vulnerable*" script on a system that is reachable from another network, shared with non-lab users, or carries real data.
- **Do** revert to a clean snapshot after each exercise.
- **Do not** copy these files into another repo or pipeline without preserving this warning.
