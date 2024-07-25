FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y \
    lsb-release \
    wget \
    apt-transport-https \
    ca-certificates \
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
    php7.4-intl
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www

RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php \
 && mv adminer-4.8.1.php index.php && chown -R root:root /var/www/

EXPOSE 8080

CMD ["php7.4", "-S", "[::]:8080", "-t", "/var/www"]
