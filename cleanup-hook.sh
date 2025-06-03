#!/bin/bash

# Load configuration with API credentials and host info
source "$(dirname "$0")/config.sh"

# Extract the root domain (e.g., example.com) from the full domain name
DOMAIN=$(echo "$CERTBOT_DOMAIN" | awk -F. '{print $(NF-1)"."$NF}')

# Remove the previously added TXT record for ACME challenge using the ISPManager DNS API
curl -s -X GET "https://$API_HOST/dnsmgr?out=json&authinfo=$API_USERNAME:$API_PASSWORD&func=domain.record.delete&elid=_acme-challenge.$DOMAIN.%20TXT%20%20$CERTBOT_VALIDATION&plid=$DOMAIN&sok=ok" > /dev/null
