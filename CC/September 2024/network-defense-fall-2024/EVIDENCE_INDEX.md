# Evidence & Screenshots Index

This index groups every screenshot in [`screenshots/`](screenshots/) by the lab/topic it documents and provides a short caption.

> The Mobile & IoT Security lab (Week 10, Lab 6) generated the largest screenshot set in this portfolio. The series captures the end-to-end workflow: ManageEngine MDM enrollment, agent deployment to Android/Windows VMs, Bitdefender device-admin activation, and the final re-scan/validation pass.

## Week 1 — Lab Build

| File | Caption |
|------|---------|
| [`wk01_labsetup_1.png`](screenshots/wk01_labsetup_1.png) | OPNsense post-install console showing LAN (`vmx0`) and WAN (`vmx1`) interface bindings on `192.168.1.1/24`. |

## Week 10 — Mobile & IoT Security (Lab 6)

This lab spans 73 screenshots covering MDM platform setup, device enrollment, policy deployment, and validation. Highlights:

| File | Caption |
|------|---------|
| [`wk10_lab6_1.png`](screenshots/wk10_lab6_1.png) | Multi-pane lab view: Ubuntu router, Android (mobile) console, Windows server, and CentOS workstation running concurrently. |
| [`wk10_lab6_5.png`](screenshots/wk10_lab6_5.png) | ManageEngine MDM web console (Android lab device) loading. |
| [`wk10_lab6_12.png`](screenshots/wk10_lab6_12.png) | Endpoint Central — MDM enrollment & content lifecycle (devices → apps → policies → monitoring). |
| [`wk10_lab6_30.png`](screenshots/wk10_lab6_30.png) | Bitdefender Security — *Activate device admin app* prompt on the managed Android VM. |
| [`wk10_lab6_52.png`](screenshots/wk10_lab6_52.png) | CrystalMQ broker dashboard on CentOS — clients, topics, events, and rules panes used for IoT messaging tests. |

The remaining `wk10_lab6_*` files capture intermediate enrollment, configuration, and validation steps. They are best reviewed alongside [`assignments/Lab_6_Mobile_and_IoT_Security_Implementation.pdf`](assignments/Lab_6_Mobile_and_IoT_Security_Implementation.pdf), which narrates each step.

<details>
<summary>Full Week 10 file list (73 files)</summary>

`wk10_lab6_1.png` through `wk10_lab6_73.png` — sequential capture of the Mobile & IoT lab. See the lab PDF for ordered context.

</details>

## Weeks 11–12 — OPNsense Capstone

| File | Caption |
|------|---------|
| [`wk12_opnsense_3.png`](screenshots/wk12_opnsense_3.png) | OPNsense privilege matrix — Firewall: Rules and Firewall: Rules: Edit GUI permissions assigned to the admin role. |
| [`wk12_opnsense_4.png`](screenshots/wk12_opnsense_4.png) | OPNsense User Manager — System Administrator account, `/usr/local/sbin/opnsense-shell` login shell, `admins` group membership. |

> **Note:** Earlier `wk12_opnsense_*` screenshots that exposed plaintext API keys were removed before this repo was made public. The corresponding API keys were rotated in OPNsense.
