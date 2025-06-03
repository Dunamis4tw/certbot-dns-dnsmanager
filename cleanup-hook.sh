#!/bin/bash

# Определяем путь до скрипта и загружаем конфиг с API_*
source "$(dirname "$0")/config.sh"

# Получаем основной домен (вида example.com)
DOMAIN=$(echo "$CERTBOT_DOMAIN" | awk -F. '{print $(NF-1)"."$NF}')

# Удаление TXT-записи
curl -s -X GET "https://$API_HOST/dnsmgr?out=json&authinfo=$API_USERNAME:$API_PASSWORD&func=domain.record.delete&elid=_acme-challenge.$DOMAIN.%20TXT%20%20$CERTBOT_VALIDATION&plid=$DOMAIN&sok=ok" > /dev/null
