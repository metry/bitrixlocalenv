FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli pdo pdo_mysql zip opcache \
    && a2enmod rewrite

COPY ./php.ini /usr/local/etc/php/php.ini

RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf
