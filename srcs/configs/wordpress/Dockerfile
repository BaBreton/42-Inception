# syntax=docker/dockerfile:1

FROM debian:buster
RUN apt-get update && apt upgrade -y
RUN apt-get install -y wget
RUN apt-get install php7.3 php-fpm php-mysql mariadb-client -y

RUN wget https://wordpress.org/wordpress-6.0.tar.gz -P /var/www/
RUN cd /var/www/ && tar -xvf wordpress-6.0.tar.gz && rm wordpress-6.0.tar.gz

COPY conf/php.conf /etc/php/7.3/fpm/pool.d/www.conf
RUN chown -R root:root /var/www/wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
RUN mkdir -p /conf
COPY conf/wp-config.sh /conf/wp-config.sh
COPY conf/index.php /conf/index.php

ENTRYPOINT ["bash", "/conf/wp-config.sh"]

EXPOSE 9000
