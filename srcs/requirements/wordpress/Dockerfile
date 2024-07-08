FROM debian:bullseye

RUN apt-get update && apt-get install -y \
  lsb-release \
  apt-transport-https \
  ca-certificates \
  wget \
  php7.4-fpm \
  php7.4-cli \
  php7.4-gd \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html/

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]
