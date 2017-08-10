FROM ubuntu:14.04
MAINTAINER OEMS <oscaremu@gmail.com>

#RUN apt-get update && \
#  apt-get install squid-deb-proxy-client -y && \
#  echo 'Acquire::http::Proxy "http://192.168.122.1:8000/";' > /etc/apt/apt.conf.d/30autoproxy

RUN apt-get update && \
    apt-get install -y curl supervisor git php5 php5-mysql php5-gd libapache2-mod-php5 php5-curl libssh2-php apache2

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server && \
    touch /var/lib/mysql/run_mysql

ENV WIKKAWIKI_VERSION 1.3.7
ENV MD5_CHECKSUM 9e3ae79d96bf0581c01e1dc706698576

ADD http://wikkawiki.org/downloads/Wikka-$WIKKAWIKI_VERSION.tar.gz /var/www/html/wikka/$WIKKAWIKI_VERSION.tar.gz

RUN mkdir -p /var/www/html/wikka \
    && cd /var/www/html/wikka \
    && echo "$MD5_CHECKSUM  $WIKKAWIKI_VERSION.tar.gz" | md5sum -c - \
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

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
