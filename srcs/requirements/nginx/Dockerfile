FROM debian:bullseye

ARG DB_NAME \
    DB_USER \
    DB_USER_PASS

RUN apt-get update

RUN apt-get install -y \ 
    nginx \
    curl \
    openssl

RUN apt-get clean && rm -rf var/lib/apt/lists/*

COPY requirements/nginx/conf/nginx.conf /etc/nginx/nginx.conf
COPY requirements/nginx/tools /etc/nginx/ssl

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
