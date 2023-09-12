# syntax=docker/dockerfile:1

# Install debian buster
FROM debian:buster

# Install nginx and openssl to generate certificate
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nginx
RUN apt-get install -y openssl

# Create certificate's folder and nginx's configuration folder
RUN mkdir -p /etc/nginx/ssl/certs
RUN mkdir -p /etc/nginx/ssl/private
RUN mkdir -p /var/run/nginx

# Generate certificate
RUN openssl req -newkey rsa:4096 -days 42 -nodes -x509 -out /etc/nginx/ssl/certs/inception.crt -keyout /etc/nginx/ssl/private/inception.key -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42Paris/CN=babreton.42.fr/UID=babreton"

# Copy nginx's configuration file
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Attribute rights to nginx's html configuration folder
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Run nginx
CMD ["nginx", "-g", "daemon off;"]