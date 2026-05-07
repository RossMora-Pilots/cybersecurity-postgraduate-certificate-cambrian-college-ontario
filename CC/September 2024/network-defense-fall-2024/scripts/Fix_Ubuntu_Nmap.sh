#!/usr/bin/env bash
# Fix_Ubuntu_Nmap.sh — Address Nmap-identified issues on Ubuntu.
# Usage: sudo ./Fix_Ubuntu_Nmap.sh [--force]
set -euo pipefail

EXPECTED_HOSTNAME="ubuntu-desktop"
FORCE=false
[[ "${1:-}" == "--force" ]] && FORCE=true

if [[ "$(hostname)" != "$EXPECTED_HOSTNAME" && "$FORCE" != true ]]; then
  echo "WARN: hostname '$(hostname)' != '$EXPECTED_HOSTNAME'. Re-run with --force to override." >&2
  exit 1
fi

echo "[*] Disabling SSH root login..."
sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart ssh

echo "[*] Restricting HTTP TRACE/TRACK..."
if [[ -f /etc/apache2/apache2.conf ]] && ! grep -q "RewriteCond %{REQUEST_METHOD} \^(TRACE|TRACK)" /etc/apache2/apache2.conf; then
  cat <<'EOF' >> /etc/apache2/apache2.conf
<Directory /var/www/html>
    <IfModule mod_headers.c>
        Header always unset X-Powered-By
    </IfModule>
    RewriteEngine On
    RewriteCond %{REQUEST_METHOD} ^(TRACE|TRACK)
    RewriteRule .* - [F]
</Directory>
EOF
fi
systemctl restart apache2

echo "[*] Closing unused ports (4444, 3389) via UFW..."
ufw --force enable
ufw deny 4444
ufw deny 3389
ufw reload

echo "[+] Fix_Ubuntu_Nmap.sh complete. Re-run Nmap to validate."
