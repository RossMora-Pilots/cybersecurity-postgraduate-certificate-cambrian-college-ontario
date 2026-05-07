#!/usr/bin/env bash
# install_openvas.sh — install and initialize OpenVAS / Greenbone on Kali.
# Usage: sudo ./install_openvas.sh
set -euo pipefail

apt update
apt install -y openvas
gvm-setup
gvm-start

echo "[install_openvas] Setup complete."
