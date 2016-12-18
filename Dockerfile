FROM ubuntu:16.04
MAINTAINER OEMS <oscaremu@gmaiil.com>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl supervisor git php7.0 php7.0-mysql php7.0-gd php7.0-mbstring php7.0-curl libapache2-mod-php7.0 php-ssh2 apache2 mysql-server

#RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV WIKKAWIKI_VERSION "1.4.0-pre"
ENV MD5_CHECKSUM b2348ab73f2f486af1374d2fa1f7393c

ADD https://github.com/wikkawik/WikkaWiki/archive/$WIKKAWIKI_VERSION.tar.gz /var/www/html/wikka/$WIKKAWIKI_VERSION.tar.gz

RUN mkdir -p /var/www/html/wikka \
    && cd /var/www/html/wikka \
    && echo "$MD5_CHECKSUM  $WIKKAWIKI_VERSION.tar.gz" | md5sum -c - \
    && tar xzf "$WIKKAWIKI_VERSION.tar.gz" --strip 1 \
    && rm "$WIKKAWIKI_VERSION.tar.gz"

ADD wikka.conf /etc/apache2/sites-available/wikka.conf
ADD mysql_wikkawiki.sql /root/mysql_wikkawiki.sql
ADD supervisord.conf /etc/supervisord.conf
ADD fix_perm.sh /root/fix_perm.sh

RUN chown -R www-data:www-data /var/www \
    && a2enmod rewrite \
    && rm /etc/apache2/sites-enabled/000-default.conf \
    && ln -s /etc/apache2/sites-available/wikka.conf /etc/apache2/sites-enabled/

RUN service mysql start & \
    sleep 10s  \
    && mysql -u root < /root/mysql_wikkawiki.sql \
    && service mysql start && sleep 10 \
    && tar -cvf /mysql_basic.tar /var/lib/mysql

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
