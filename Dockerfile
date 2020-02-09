FROM composer:1.6.5 as build

WORKDIR /app
COPY . /app
RUN cp .env.example .env
RUN composer install
RUN php artisan key:generate

FROM php:7.2-apache

EXPOSE 80
COPY --from=build /app /app
COPY vhost.conf /etc/apache2/sites-available/000-default.conf
RUN chown -R www-data:www-data /app && a2enmod rewrite
