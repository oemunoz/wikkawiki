FROM php:apache
MAINTAINER OEMS <oscaremu@gmail.com>

ENV WIKKAWIKI_VERSION "1.4.1"

RUN docker-php-ext-install pdo pdo_mysql

# Interestingly, the URL download and archive unpacking features cannot be used together.
# Any archives copied via URL will NOT be automatically unpacked.
ADD http://wikkawiki.org/downloads/Wikka-1.4.1.tar.gz /var/www/html/wikka/$WIKKAWIKI_VERSION.tar.gz

RUN mkdir -p /var/www/html/wikka \
    && cd /var/www/html/wikka \
    && tar xzf "$WIKKAWIKI_VERSION.tar.gz" --strip 1 \
    && rm "$WIKKAWIKI_VERSION.tar.gz"

ADD setup/ /setup/

RUN chown -R www-data:www-data /var/www \
    && a2enmod rewrite \
    && rm /etc/apache2/sites-enabled/000-default.conf \
    && cp /setup/wikka.conf /etc/apache2/sites-available/wikka.conf \
    && ln -s /etc/apache2/sites-available/wikka.conf /etc/apache2/sites-enabled/
