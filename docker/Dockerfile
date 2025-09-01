FROM dunglas/frankenphp:1.9.0-php8.4.11-bookworm AS base

COPY --from=composer:2.8.11 /usr/bin/composer /usr/bin/composer

RUN install-php-extensions apcu bcmath exif gd gmp intl mysqli zip imagick opcache

RUN useradd --create-home --shell /bin/bash app \
    && chown -R app:app /config /data \
    && apt update \
    && apt install -y default-mysql-client less

COPY docker/data/Caddyfile /etc/caddy/Caddyfile
COPY docker/data/php.local.ini /usr/local/etc/php/conf.d/php.local.ini

WORKDIR /app

EXPOSE 80

CMD ["frankenphp", "run", "--config", "/etc/caddy/Caddyfile"]

################
FROM base AS dev

RUN apt update \
    && apt install -y fzf git ripgrep sudo \
    && adduser app sudo \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN install-php-extensions xdebug

USER app

################
FROM base AS prod

RUN rm -rf /app
COPY . /app
RUN chown -R app:app /app

USER app
RUN composer install --no-dev --no-interaction --no-progress --optimize-autoloader --working-dir=/app

