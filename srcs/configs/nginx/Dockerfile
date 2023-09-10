# syntax=docker/dockerfile:1

FROM debian:buster

RUN apt-get update && apt upgrade -y
RUN apt-get install -y nginx vim curl
RUN mkdir -p /etc/nginx/ssl/certs
RUN mkdir -p /etc/nginx/ssl/private
RUN apt-get install -y openssl
RUN openssl req -newkey rsa:4096 -days 42 -nodes -x509 -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42Paris/CN=babreton.42.fr/UID=babreton" -out /etc/nginx/ssl/certs/inception.crt -keyout /etc/nginx/ssl/private/inception.key 
RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]

