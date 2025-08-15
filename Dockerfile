# PHP 8.3 with Apache for Symfony + PostgreSQL
FROM php:8.3-apache

ENV DEBIAN_FRONTEND=noninteractive \
    COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME=/tmp/composer

# --- System deps (incl. what's needed for pdo_pgsql & zip) ---
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      git unzip ca-certificates \
      libicu-dev libzip-dev zlib1g-dev libpq-dev \
 && rm -rf /var/lib/apt/lists/*

# --- PHP extensions ---
# zip requires configure step when using libzip
RUN docker-php-ext-configure zip \
 && docker-php-ext-install \
      intl \
      zip \
      opcache \
      pdo \
      pdo_pgsql

# Optional but recommended: APCu for fast app cache
RUN pecl install apcu \
 && docker-php-ext-enable apcu

# --- Apache setup: rewrite/headers/expires + docroot -> /public ---
RUN a2enmod rewrite headers expires \
 && sed -ri 's!DocumentRoot /var/www/html!DocumentRoot /var/www/html/public!g' /etc/apache2/sites-available/000-default.conf \
 && printf '%s\n' \
    '<Directory /var/www/html/public>' \
    '  AllowOverride All' \
    '  Require all granted' \
    '</Directory>' \
    >> /etc/apache2/sites-available/000-default.conf \
 && printf 'ServerName localhost\n' > /etc/apache2/conf-available/servername.conf \
 && a2enconf servername

# --- Composer (from official image) ---
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
RUN mkdir -p /tmp/composer && chmod -R 777 /tmp/composer

# --- PHP runtime settings (tune as needed) ---
RUN { \
      echo 'opcache.enable=1'; \
      echo 'opcache.enable_cli=1'; \
      echo 'opcache.memory_consumption=256'; \
      echo 'opcache.interned_strings_buffer=16'; \
      echo 'opcache.max_accelerated_files=20000'; \
      echo 'opcache.validate_timestamps=0'; \
      echo 'realpath_cache_size=4096K'; \
      echo 'realpath_cache_ttl=600'; \
      echo 'memory_limit=512M'; \
      echo 'upload_max_filesize=20M'; \
      echo 'post_max_size=25M'; \
    } > /usr/local/etc/php/conf.d/symfony.ini

# (Optional) enable Xdebug for local dev
# RUN pecl install xdebug && docker-php-ext-enable xdebug \
#  && { \
#       echo 'xdebug.mode=develop,debug'; \
#       echo 'xdebug.client_host=host.docker.internal'; \
#       echo 'xdebug.start_with_request=yes'; \
#     } > /usr/local/etc/php/conf.d/xdebug.ini

WORKDIR /var/www/html
