FROM php:8.1-fpm-bullseye AS base

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
RUN which composer && composer -V

WORKDIR /app

ENV PATH="${PATH}:/app/vendor/bin"

COPY composer.* ./

################################################################################

FROM base AS build

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
    git libpng-dev libzip-dev mariadb-client unzip

RUN docker-php-ext-install gd pdo_mysql zip


RUN composer validate
RUN composer install

COPY tools/docker/images/php/root /

ENTRYPOINT ["/usr/local/bin/docker-entrypoint-php"]
CMD ["php-fpm"]

################################################################################

FROM base AS test

COPY . .

RUN parallel-lint src --no-progress \
  && phpcs -vv \
  && phpstan \
  && phpunit --testdox

################################################################################

FROM nginx:1 as web

EXPOSE 8080

WORKDIR /app

COPY tools/docker/images/web/root /
