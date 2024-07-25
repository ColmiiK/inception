# Use the official Debian Bullseye base image
FROM debian:bullseye

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Write the Nginx configuration file
RUN echo "server {" > /etc/nginx/sites-available/default && \
    echo "    listen 80;" >> /etc/nginx/sites-available/default && \
    echo "    root /var/www/html;" >> /etc/nginx/sites-available/default && \
    echo "    index index.html;" >> /etc/nginx/sites-available/default && \
    echo "    location / {" >> /etc/nginx/sites-available/default && \
    echo "        try_files \$uri \$uri/ =404;" >> /etc/nginx/sites-available/default && \
    echo "    }" >> /etc/nginx/sites-available/default && \
    echo "}" >> /etc/nginx/sites-available/default

# Ensure the configuration is enabled if not already
RUN [ ! -e /etc/nginx/sites-enabled/default ] && ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/ || echo "Symlink already exists"

# Copy the static website files to the web root
COPY requirements/bonus/website/html /var/www/html

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

