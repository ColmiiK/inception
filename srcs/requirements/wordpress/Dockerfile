FROM debian:bullseye

ARG DB_NAME \
    DB_USER \
    DB_USER_PASS

RUN mkdir -p /run/php/

RUN apt-get update

RUN apt-get install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysqli \
    php7.4-json \
    php7.4-curl \
    php7.4-dom \
    php7.4-exif \
    php7.4-fileinfo \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-zip \
    php7.4-redis \
    php7.4-gd \
    php7.4-intl \
    imagemagick \
    wget \
    unzip

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|g" /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php/7.4/fpm/pool.d/www.conf

WORKDIR /var/www

RUN wget https://wordpress.org/latest.zip && unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip

COPY requirements/wordpress/conf/wp-config-create.sh .

RUN sh wp-config-create.sh

RUN mkdir -p /var/www/wp-content/uploads && \
    chown -R www-data:www-data /var/www/wp-content && \
    chmod -R 755 /var/www/wp-content

CMD ["/usr/sbin/php-fpm7.4", "-F"]
