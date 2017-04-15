FROM alpine:3.5

MAINTAINER Ianus IT GmbH <info@ianus-it.de>

RUN apk add --update ca-certificates nginx nginx-mod-http-headers-more php5 php5-gettext php5-fpm php5-ctype php5-dom php5-gd php5-iconv php5-json php5-xml php5-xmlreader php5-posix php5-zlib php5-zip php5-curl php5-opcache php5-openssl php5-mcrypt php5-apcu php5-ldap php5-intl php5-pdo_pgsql php5-pgsql wget bzip2 tar &&\
    mkdir -p /tmp/nginx/client-body

COPY files/etc/php /etc/php5
COPY files/start.sh /start.sh

RUN wget https://download.nextcloud.com/server/releases/nextcloud-11.0.2.tar.bz2 &&\
    bunzip2 nextcloud-11.0.2.tar.bz2 &&\
    tar xf nextcloud-11.0.2.tar &&\
    rm nextcloud-11.0.2.tar &&\
    mv nextcloud web &&\
    chown -R nginx:www-data /web &&\
    chown -R nginx /var/lib/nginx &&\
    chmod +x /start.sh &&\
    apk del wget bzip2 tar &&\
    rm -rf /var/cache/apk/*

CMD ["/start.sh"]
