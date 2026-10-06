FROM php:8.2-apache

# Install dependencies and PHP extensions
RUN apt-get update \
    && apt-get install -y --no-install-recommends libzip-dev zip unzip libpng-dev libonig-dev \
    && docker-php-ext-install pdo pdo_mysql mysqli \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

COPY . /var/www/html
WORKDIR /var/www/html

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["apache2-foreground"]
