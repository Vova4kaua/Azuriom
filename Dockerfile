FROM php:8.3-cli-alpine

# Системні пакети
RUN apk add --no-cache \
    git curl zip unzip \
    libzip-dev postgresql-dev \
    openssl

# PHP розширення
RUN docker-php-ext-install pdo pdo_pgsql bcmath zip

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Робоча папка
WORKDIR /var/www/azuriom

# Копіюємо проєкт
COPY . .

# Встановлюємо залежності
RUN composer install --no-dev --prefer-dist --no-interaction

# Відкриваємо порт
EXPOSE 8080

# Запускаємо Laravel built-in server
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]
