# syntax=docker/dockerfile:1

FROM debian:buster
RUN apt-get update && apt upgrade -y
RUN apt-get install -y wget
RUN apt-get install -y php7.3\
	php-fpm\
	php-mysql\
	mariadb-client
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN		chown -R root:root /var/www/wordpress

COPY conf/php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY conf/config_wp.sh /tmp/config_wp.sh
RUN chmod 755 /tmp/config_wp.sh
RUN /tmp/config_wp.sh
