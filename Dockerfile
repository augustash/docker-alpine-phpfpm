FROM augustash/alpine-base-s6:4.0.0

# environment
ENV VERSION_ALPINE="3.9" \
    VERSION_PHP="7.3" \
    COMPOSER_HOME="/.composer"

# packages & configure
RUN curl -sS -o /etc/apk/keys/php-alpine.rsa.pub http://php.codecasts.rocks/php-alpine.rsa.pub \
    && echo "@php http://php.codecasts.rocks/v${VERSION_ALPINE}/php-${VERSION_PHP}" >> /etc/apk/repositories

RUN apk-install git mysql-client php7@php php7-bcmath@php php7-dom@php php7-ctype@php php7-curl@php \
        php7-ftp@php php7-fpm@php php7-gd@php php7-iconv@php php7-intl@php php7-json@php \
        php7-mbstring@php php7-mysqlnd@php php7-opcache@php php7-openssl@php php7-pdo@php \
        php7-pdo_mysql@php php7-phar@php php7-posix@php php7-redis@php php7-session@php \
        php7-soap@php php7-xml@php php7-xsl@php php7-zip@php php7-zlib@php zip \
    && curl -sSL https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -o ioncube.tar.gz \
    && tar -xf ioncube.tar.gz \
    && mv "ioncube/ioncube_loader_lin_${VERSION_PHP}.so" /usr/lib/php7/modules/ \
    && echo ";zend_extension = /usr/lib/php7/modules/ioncube_loader_lin_${VERSION_PHP}.so" > /etc/php7/conf.d/00-ioncube.ini \
    && rm -rf ./ioncube \
    && ln -nfs /usr/bin/php7 /usr/bin/php \
    && curl -sS https://getcomposer.org/installer | \
        php -- --no-ansi --install-dir=/usr/local/bin --filename=composer.phar \
    && chmod a+x /usr/local/bin/* \
    && mkdir -p "${COMPOSER_HOME}/cache" /var/log/cron /socket \
    && chown -R "${PUID}:${PGID}" "${COMPOSER_HOME}" /socket \
    && rm -rf /etc/php7/php-fpm.d/* \
    && apk-cleanup

# copy root filesystem
COPY rootfs /

# external
EXPOSE 9000
WORKDIR /src

# run s6 supervisor
ENTRYPOINT ["/init"]
