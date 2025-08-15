FROM php:8.3-apache

# Install PHP extensions for PostgreSQL
RUN docker-php-ext-install pdo pdo_pgsql

# Enable Apache mod_rewrite (often useful for frameworks)
RUN a2enmod rewrite

# Optional: set Apache docroot to /var/www/html/public if your framework uses "public"
# RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf
