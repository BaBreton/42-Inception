# syntax=docker/dockerfile:1

# Install debian buster
FROM debian:buster

# Install php and wget to download wordpress
RUN apt-get update && apt upgrade -y
RUN apt-get install -y wget
RUN apt-get install php7.3 php-fpm php-mysql mariadb-client -y

# Download wordpress, move it, extract, and delete the archive
RUN wget https://wordpress.org/wordpress-6.0.tar.gz -P /var/www/
RUN cd /var/www/ && tar -xvf wordpress-6.0.tar.gz && rm wordpress-6.0.tar.gz

# Download wp-cli and move it
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Create configuration folder, copy configuration file and custom index.php
RUN mkdir -p /conf
COPY conf/create_wordpress.sh /conf/create_wordpress.sh
COPY conf/index.php /conf/index.php

# Copy configuration files and give rights
COPY conf/php.conf /etc/php/7.3/fpm/pool.d/www.conf
RUN chown -R root:root /var/www/wordpress

# Run from the script
ENTRYPOINT ["/bin/bash", "/conf/create_wordpress.sh"]

# Expose port 9000
EXPOSE 9000