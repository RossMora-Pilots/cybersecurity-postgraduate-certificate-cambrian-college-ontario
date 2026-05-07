#!/usr/bin/env bash
# Fix_Ubuntu_Nessus.sh — Address Nessus-reported vulnerabilities on Ubuntu.
# Usage: sudo ./Fix_Ubuntu_Nessus.sh [--force]
set -euo pipefail

EXPECTED_HOSTNAME="ubuntu-desktop"
FORCE=false
[[ "${1:-}" == "--force" ]] && FORCE=true

if [[ "$(hostname)" != "$EXPECTED_HOSTNAME" && "$FORCE" != true ]]; then
  echo "WARN: hostname '$(hostname)' != '$EXPECTED_HOSTNAME'. Re-run with --force to override." >&2
  exit 1
fi

echo "[*] Updating Suricata..."
apt-get install -y suricata

echo "[*] Hardening OpenSSH (PermitRootLogin no, PasswordAuthentication no)..."
sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

echo "[*] Updating Apache HTTP Server..."
apt-get install -y apache2

echo "[*] Removing any cron jobs containing 'malicious_command'..."
if crontab -u root -l 2>/dev/null | grep -q 'malicious_command'; then
  crontab -u root -l | grep -v 'malicious_command' | crontab -u root -
fi

echo "[*] Disabling Netcat backdoor service if present..."
if systemctl list-units --full -all | grep -q "malicious.service"; then
  systemctl stop malicious.service || true
  systemctl disable malicious.service || true
  rm -f /etc/systemd/system/malicious.service
fi

echo "[+] Fix_Ubuntu_Nessus.sh complete."
