FROM debian:bullseye

ARG DB_NAME \
    DB_USER \
    DB_USER_PASS

RUN apt-get update && apt-get install -y \
  nginx \
  curl \
  && apt-get clean && rm -rf var/lib/apt/lists/*

COPY requirements/nginx/conf/nginx.conf /etc/nginx/nginx.conf

COPY requirements/nginx/html /usr/share/nginx/html

COPY requirements/nginx/tools /etc/nginx/ssl

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
