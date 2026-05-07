#!/usr/bin/env bash
# Fix_CentOS_Nmap.sh — Address Nmap-identified issues on CentOS Stream 9.
# Usage: sudo ./Fix_CentOS_Nmap.sh [--force]
set -euo pipefail

EXPECTED_HOSTNAME="localhost.localdomain"
FORCE=false
[[ "${1:-}" == "--force" ]] && FORCE=true

if [[ "$(hostname)" != "$EXPECTED_HOSTNAME" && "$FORCE" != true ]]; then
  echo "WARN: hostname '$(hostname)' != '$EXPECTED_HOSTNAME'. Re-run with --force to override." >&2
  exit 1
fi

echo "[*] Ensuring firewalld is running..."
if ! systemctl is-active --quiet firewalld; then
  systemctl start firewalld
  systemctl enable firewalld
fi

echo "[*] Disabling TRACE and restricting Indexes in Apache..."
if grep -q "TraceEnable" /etc/httpd/conf/httpd.conf; then
  sed -i 's/^TraceEnable.*/TraceEnable Off/' /etc/httpd/conf/httpd.conf
else
  echo "TraceEnable Off" >> /etc/httpd/conf/httpd.conf
fi
if ! grep -q "Options -Indexes" /etc/httpd/conf/httpd.conf; then
  cat <<'EOF' >> /etc/httpd/conf/httpd.conf
<Directory />
    Options -Indexes
    AllowOverride None
</Directory>
EOF
fi
systemctl restart httpd

echo "[*] Hardening SSH..."
if grep -q "^PermitRootLogin" /etc/ssh/sshd_config; then
  sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
else
  echo "PermitRootLogin no" >> /etc/ssh/sshd_config
fi
systemctl restart sshd

echo "[*] Restricting firewalld to ssh + http..."
firewall-cmd --add-service=ssh --permanent
firewall-cmd --add-service=http --permanent
firewall-cmd --reload

echo "[*] Hiding HTTP server tokens..."
grep -q "ServerTokens" /etc/httpd/conf/httpd.conf || echo "ServerTokens Prod" >> /etc/httpd/conf/httpd.conf
grep -q "ServerSignature" /etc/httpd/conf/httpd.conf || echo "ServerSignature Off" >> /etc/httpd/conf/httpd.conf
systemctl restart httpd

echo "[*] Disabling unnecessary services (avahi-daemon)..."
systemctl disable --now avahi-daemon || true

echo "[+] Fix_CentOS_Nmap.sh complete. Re-run Nmap to validate."
