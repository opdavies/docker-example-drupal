ARG PHP_VERSION=8.1

FROM php:${PHP_VERSION}-fpm-bullseye AS base

###

FROM base AS build

ENV PATH=${PATH}:/var/www/html/vendor/bin

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

RUN useradd --create-home app \
  && chown app:app -R /var/www/html \
  && apt-get update -yqq \
  && apt-get install -yqq \
    git \
    libpng-dev \
    mariadb-client \
    unzip \
  && rm -fr /var/lib/apt/lists/* \
  && pecl install xdebug \
  && docker-php-ext-install \
    gd \
    opcache \
    pdo_mysql \
  && docker-php-ext-enable \
    xdebug

COPY tools/docker/images/php/root /

COPY --chown=app:app composer.* ./

USER app
RUN composer install --no-dev --prefer-dist --optimize-autoloader

COPY --chown=app:app . .

###

FROM build AS test

# RUN composer install \
#   && phpunit

###

FROM build AS production

RUN composer install --no-dev --prefer-dist --optimize-autoloader
