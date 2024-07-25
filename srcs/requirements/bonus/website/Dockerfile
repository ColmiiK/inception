FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "server {" > /etc/nginx/sites-available/default && \
    echo "    listen 80;" >> /etc/nginx/sites-available/default && \
    echo "    root /var/www/html;" >> /etc/nginx/sites-available/default && \
    echo "    index index.html;" >> /etc/nginx/sites-available/default && \
    echo "    location / {" >> /etc/nginx/sites-available/default && \
    echo "        try_files \$uri \$uri/ =404;" >> /etc/nginx/sites-available/default && \
    echo "    }" >> /etc/nginx/sites-available/default && \
    echo "}" >> /etc/nginx/sites-available/default

RUN [ ! -e /etc/nginx/sites-enabled/default ] \
 && ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/ || echo "Symlink already exists"

COPY requirements/bonus/website/html /var/www/html

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
