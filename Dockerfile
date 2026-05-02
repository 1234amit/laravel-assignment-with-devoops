# -----------------------------
# Stage 1: Build dependencies
# -----------------------------
FROM composer:2.7 AS vendor

WORKDIR /app

COPY composer.json composer.lock ./
RUN composer install --no-dev --prefer-dist --no-interaction --no-progress --no-scripts

COPY . .
RUN composer dump-autoload --optimize


# -----------------------------
# Stage 2: Production image
# -----------------------------
FROM php:8.2-fpm-alpine

WORKDIR /var/www/html

# Install system dependencies
RUN apk add --no-cache \
    nginx \
    supervisor \
    bash \
    curl \
    libzip-dev \
    zip \
    unzip \
    icu-dev \
    oniguruma-dev \
    autoconf \
    g++ \
    make

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring zip intl

# Copy Laravel app
COPY --from=vendor /app /var/www/html

# Create Laravel required directories + permissions
RUN mkdir -p storage/framework/sessions \
    storage/framework/cache \
    storage/framework/views \
    storage/logs \
    bootstrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Create all required Laravel directories
RUN mkdir -p storage/framework/{sessions,views,cache} \
    storage/logs \
    bootstrap/cache

# Ensure correct permissions (VERY IMPORTANT)
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache



# Nginx config
COPY docker/nginx.conf /etc/nginx/nginx.conf

# Supervisor config
COPY docker/supervisord.conf /etc/supervisord.conf

EXPOSE 80

RUN chmod -R 777 storage bootstrap/cache

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]