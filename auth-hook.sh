#!/bin/bash

# Load configuration with API credentials and host info
source "$(dirname "$0")/config.sh"

# Extract the root domain (e.g., example.com) from the full domain name
DOMAIN=$(echo "$CERTBOT_DOMAIN" | awk -F. '{print $(NF-1)"."$NF}')

# Add a TXT record for ACME challenge using the ISPManager DNS API
curl -s -X GET "https://$API_HOST/dnsmgr?out=json&authinfo=$API_USERNAME:$API_PASSWORD&func=domain.record.edit&name=_acme-challenge&plid=$DOMAIN&rtype=txt&ttl=120&value=$CERTBOT_VALIDATION&sok=ok" > /dev/null

# Wait a few seconds to allow the DNS record to propagate
sleep 10
