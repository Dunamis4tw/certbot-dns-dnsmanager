#!/bin/bash

source "$(dirname "$0")/config.sh"

DOMAIN=$(echo "$CERTBOT_DOMAIN" | awk -F. '{print $(NF-1)"."$NF}')

# Добавление TXT-записи
curl -s -X GET "https://$API_HOST/dnsmgr?out=json&authinfo=$API_USERNAME:$API_PASSWORD&func=domain.record.edit&name=_acme-challenge&plid=$DOMAIN&rtype=txt&ttl=120&value=$CERTBOT_VALIDATION&sok=ok" > /dev/null

# Небольшая задержка для DNS
sleep 10