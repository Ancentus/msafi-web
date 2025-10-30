#!/bin/bash
set -e
echo "Starting services..."
service php8.2-fpm start




nginx -g "daemon off;" &
echo "Ready."
for log in /var/log/nginx/*.log; do
    mkdir -p "$(dirname "$log")"
    touch "$log"
    tail -s 1 "$log" -f &
done
for log in /var/www/html/storage/logs/*.log; do
    mkdir -p "$(dirname "$log")"
    touch "$log"
    tail -s 10 "$log" -f &
done


wait




