#!/bin/bash

sleep 10
mv /conf/index.php /var/www/wordpress/index.php
if [ ! -e /var/www/wordpress/wp-config.php ]; then
	echo "CREATION WP-CONFIG.PHP on $DOMAIN_NAME"
	echo "DB_NAME: $SQL_DATABASE"
	echo "DB_USER: $SQL_USER"
	echo "DB_PASSWORD: $SQL_PASSWORD"
	wp config create	--allow-root \
						--dbname=$SQL_DATABASE \
						--dbuser=$SQL_USER \
						--dbpass=$SQL_ROOT_PASSWORD \
						--dbhost=mariadb:3306 --path='/var/www/wordpress'
sleep 2
wp core install     --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/wordpress'
wp user create      --allow-root --role=author $USER1_LOGIN $USER1_MAIL --user_pass=$USER1_PASS --path='/var/www/wordpress' >> /log.txt
fi

if [ ! -d /run/php ]; then
    mkdir ./run/php
fi
/usr/sbin/php-fpm7.3 -F