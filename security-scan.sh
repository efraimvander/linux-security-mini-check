
#!/bin/bash
# linux-security-mini-check
# Quick security scan for Linux environments (BEAST mode)

RED="\e[31m"; GREEN="\e[32m"; YELLOW="\e[33m"; NC="\e[0m"

echo -e "${GREEN}=== Linux Security Mini Check ===${NC}"

# 1. Check user with sudo privileges
echo -e "\n${YELLOW}[1] Sudo Users:${NC}"
grep -Po '^sudo.+:\K.*$' /etc/group || echo "No sudo group found."

# 2. Check if password auth is enabled (should be disabled)
echo -e "\n${YELLOW}[2] SSH Password Authentication:${NC}"
PASS_AUTH=$(grep -E "^PasswordAuthentication" /etc/ssh/sshd_config | awk '{print $2}')
echo "PasswordAuthentication = ${PASS_AUTH:-not configured}"

# 3. Check open ports
echo -e "\n${YELLOW}[3] Open Ports:${NC}"
ss -tuln

# 4. Check world-writable files
echo -e "\n${YELLOW}[4] World-Writable Files (top 10):${NC}"
find / -type f -perm -0002 2>/dev/null | head

# 5. Check if firewall is enabled
echo -e "\n${YELLOW}[5] Firewall Status (ufw/firewalld):${NC}"
if command -v ufw >/dev/null; then
    ufw status
elif command -v firewall-cmd >/dev/null; then
    firewall-cmd --state
else
    echo "No firewall detected."
fi

# 6. Check system updates
echo -e "\n${YELLOW}[6] Pending Updates:${NC}"
if command -v apt >/dev/null; then
    apt update -qq >/dev/null
    apt list --upgradable 2>/dev/null
elif command -v dnf >/dev/null; then
    dnf check-update
else
    echo "Package manager not supported."
fi

# 7. Check login failures
echo -e "\n${YELLOW}[7] Recent Login Failures:${NC}"
journalctl -u ssh -n 20 | grep "Failed" || echo "No failed logins found."

echo -e "\n${GREEN}=== Scan Complete ===${NC}"
