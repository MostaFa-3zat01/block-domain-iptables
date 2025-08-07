Script Code:


#!/bin/bash
# Check if domain name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi
DOMAIN="$1"
# Resolve domain to IP
IP=$(dig +short "$DOMAIN" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | head -n 1)
# Check if IP was found
if [ -z "$IP" ]; then
    echo "Error: Could not resolve domain '$DOMAIN'"
    exit 2
fi
echo "[+] Domain resolved: $DOMAIN -> $IP"
# Block outgoing and incoming traffic
sudo iptables -A OUTPUT -d "$IP" -j DROP
sudo iptables -A INPUT -s "$IP" -j DROP
echo "[+] Traffic to/from $DOMAIN ($IP) has been blocked."
