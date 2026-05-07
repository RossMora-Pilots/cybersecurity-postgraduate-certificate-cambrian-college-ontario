#!/usr/bin/env bash
# Fix_CentOS_Nessus.sh — Address Nessus-reported vulnerabilities on CentOS Stream 9.
# Usage: sudo ./Fix_CentOS_Nessus.sh [--force]
set -euo pipefail

EXPECTED_HOSTNAME="localhost.localdomain"
FORCE=false
[[ "${1:-}" == "--force" ]] && FORCE=true

if [[ "$(hostname)" != "$EXPECTED_HOSTNAME" && "$FORCE" != true ]]; then
  echo "WARN: hostname '$(hostname)' != '$EXPECTED_HOSTNAME'. Re-run with --force to override." >&2
  exit 1
fi

echo "[*] Disabling Netcat backdoor service if active..."
if systemctl is-active --quiet malicious.service; then
  systemctl stop malicious.service
  systemctl disable malicious.service
fi

echo "[*] Correcting baseline file permissions..."
chmod 644 /etc/passwd
chmod 600 /etc/shadow

echo "[*] Updating Apache HTTP Server..."
yum clean all
yum update -y httpd

echo "[*] Updating FFmpeg if installed..."
if rpm -q ffmpeg >/dev/null 2>&1; then
  yum update -y ffmpeg
fi

echo "[*] Removing any cron jobs containing 'malicious_job_command'..."
crontab -l 2>/dev/null | grep -v 'malicious_job_command' | crontab -

echo "[*] Hardening SSH (PermitRootLogin no)..."
if grep -q "^PermitRootLogin" /etc/ssh/sshd_config; then
  sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
else
  echo "PermitRootLogin no" >> /etc/ssh/sshd_config
fi
systemctl restart sshd

echo "[*] Updating Suricata if installed..."
if rpm -q suricata >/dev/null 2>&1; then
  yum update -y suricata
fi

echo "[+] Fix_CentOS_Nessus.sh complete. Re-run Nessus to validate."
