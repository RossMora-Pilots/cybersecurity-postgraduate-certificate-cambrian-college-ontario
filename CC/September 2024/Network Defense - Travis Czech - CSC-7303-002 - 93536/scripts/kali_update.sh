#!/usr/bin/env bash
# kali_update.sh — nightly updates for Kali.
# Usage: sudo ./kali_update.sh
set -euo pipefail

apt update
DEBIAN_FRONTEND=noninteractive apt -y upgrade
apt -y autoremove

echo "[kali_update] Completed at $(date -Is)"
