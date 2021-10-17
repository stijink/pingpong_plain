# Stage: base
FROM php:8.0.11-cli-alpine AS base

    WORKDIR /var/www

    RUN docker-php-ext-install opcache pdo_mysql pcntl

    # PHP Configuration
    COPY build/php-conf/*.ini /usr/local/etc/php/conf.d/

    COPY --from=composer /usr/bin/composer /usr/bin/composer

    EXPOSE 3000

# Stage: Production
FROM base as production

    COPY . .

    RUN composer install --no-dev --classmap-authoritative
