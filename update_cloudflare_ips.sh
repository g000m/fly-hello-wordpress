#!/bin/bash

# File where Cloudflare IP ranges will be added
REMOTEIP_CONF="/etc/apache2/conf-available/remoteip.conf"
TEMP_FILE="/tmp/remoteip.conf.tmp"

# Download the latest Cloudflare IP ranges
IPV4_URL="https://www.cloudflare.com/ips-v4"
IPV6_URL="https://www.cloudflare.com/ips-v6"

# Fetch the current Cloudflare IPs
CURRENT_IPV4=$(curl -s $IPV4_URL)
CURRENT_IPV6=$(curl -s $IPV6_URL)

# Create a temporary file for remoteip.conf with Cloudflare IPs
{
    echo "RemoteIPHeader X-Forwarded-For"
    echo "RemoteIPHeader CF-Connecting-IP"

    echo "RemoteIPInternalProxy 10.0.0.0/8"
    echo "RemoteIPInternalProxy 172.16.0.0/12"
    echo "RemoteIPInternalProxy 192.168.0.0/16"
    echo "RemoteIPInternalProxy 169.254.0.0/16"
    echo "RemoteIPInternalProxy 127.0.0.0/8"

    echo "# Cloudflare IPv4 ranges"
    for ip in $CURRENT_IPV4; do
        echo "RemoteIPTrustedProxy $ip"
    done

    echo "# Cloudflare IPv6 ranges"
    for ip in $CURRENT_IPV6; do
        echo "RemoteIPTrustedProxy $ip"
    done
} > $TEMP_FILE

# Compare the new configuration with the existing one
if ! cmp -s $TEMP_FILE $REMOTEIP_CONF; then
    # If there's a difference, replace the old file and restart Apache
    mv $TEMP_FILE $REMOTEIP_CONF
    echo "Cloudflare IP ranges updated. Restarting Apache."
    service apache2 restart
else
    echo "No updates to Cloudflare IP ranges."
    rm $TEMP_FILE
fi
