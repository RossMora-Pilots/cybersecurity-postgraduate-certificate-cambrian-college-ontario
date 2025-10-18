#!/bin/bash
# Usage: bash kali_update.sh
# Usage: sudo ./kali_update.sh
# kali_update.sh — nightly updates for Kali
set -e
apt update
DEBIAN_FRONTEND=noninteractive apt -y upgrade
apt -y autoremove
echo "[kali_update] Completed at $(date)"
