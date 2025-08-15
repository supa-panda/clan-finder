#!/usr/bin/env bash
set -e

cd /var/www/html

# Make sure runtime dirs exist and are writable
mkdir -p var/cache var/log var/sessions
chown -R www-data:www-data var
chmod -R 775 var

# If vendor is mounted from host, you may also need:
# chown -R www-data:www-data vendor || true

exec apache2-foreground
