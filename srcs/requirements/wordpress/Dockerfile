FROM debian:bullseye

ARG DB_NAME \
    DB_USER \
    DB_PASS

RUN apt-get update && apt-get install -y \
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
    wget \
    unzip

RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php/7.4/fpm/pool.d/www.conf

WORKDIR /var/www

RUN wget https://wordpress.org/latest.zip && unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip

COPY requirements/wordpress/conf/wp-config-create.sh .

RUN sh wp-config-create.sh && rm wp-config-create.sh && chmod -R 0777 wp-content/

CMD ["/usr/sbin/php-fpm7.4", "-F"]


