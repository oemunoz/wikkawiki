FROM ubuntu:16.04
MAINTAINER OEMS <oscaremu@gmail.com>

RUN apt-get update && \
  apt-get install squid-deb-proxy-client -y && \
  echo 'Acquire::http::Proxy "http://192.168.122.1:8000/";' > /etc/apt/apt.conf.d/30autoproxy

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl supervisor git php7.0 php7.0-sqlite php7.0-mysql php7.0-gd php7.0-mbstring php7.0-curl libapache2-mod-php7.0 php-ssh2 apache2 mysql-server

#RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Removed MD5sum for Develop.

ENV WIKKAWIKI_VERSION "1.4.0-pre"

ADD https://github.com/wikkawik/WikkaWiki/archive/$WIKKAWIKI_VERSION.tar.gz /var/www/html/wikka/$WIKKAWIKI_VERSION.tar.gz

RUN mkdir -p /var/www/html/wikka \
    && cd /var/www/html/wikka \
    && tar xzf "$WIKKAWIKI_VERSION.tar.gz" --strip 1 \
    && rm "$WIKKAWIKI_VERSION.tar.gz"

ADD supervisord/supervisord.conf /etc/supervisord.conf
ADD supervisord/ /etc/supervisord/
ADD setup/ /setup/

RUN chown -R www-data:www-data /var/www \
    && a2enmod rewrite \
    && rm /etc/apache2/sites-enabled/000-default.conf \
    && cp /setup/wikka.conf /etc/apache2/sites-available/wikka.conf \
    && ln -s /etc/apache2/sites-available/wikka.conf /etc/apache2/sites-enabled/

RUN service mysql start && \
    sleep 10s && \
    mysql -u root < /setup/mysql_wikkawiki.sql && \
    service mysql stop && sleep 10 && \
    tar -cvf /mysql_basic.tar /var/lib/mysql

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
