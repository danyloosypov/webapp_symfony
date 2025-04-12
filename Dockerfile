# Use official PHP image with required extensions
FROM php:8.2-fpm-alpine

# Install system dependencies and PHP extensions
RUN apk add --no-cache \
    bash \
    git \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql opcache

# Set the working directory
WORKDIR /var/www/html

# Copy the current directory contents into the container
COPY . .

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Symfony dependencies
RUN composer install --no-scripts --no-autoloader

# Expose port 9000
EXPOSE 9000

CMD ["php-fpm"]
