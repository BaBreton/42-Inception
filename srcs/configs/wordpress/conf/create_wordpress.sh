#!/bin/bash

# Wait for 10 seconds
sleep 10

# Move the file /conf/index.php to /var/www/wordpress/index.php
mv /conf/index.php /var/www/wordpress/index.php

# Check if /var/www/wordpress/wp-config.php doesn't exist
if [ ! -e /var/www/wordpress/wp-config.php ]; then
    echo "CREATION WP-CONFIG.PHP on $DOMAIN_NAME"
    
    # Create the wp-config.php file using wp-cli
    wp config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_ROOT_PASSWORD \
        --dbhost=mariadb:3306 --path='/var/www/wordpress'

    # Install WordPress using wp-cli
    wp core install --url=$DOMAIN_NAME \
        --title=$SITE_TITLE \
        --admin_user=$ADMIN_USER \
        --admin_password=$ADMIN_PASSWORD \
        --admin_email=$ADMIN_EMAIL \
        --allow-root --path='/var/www/wordpress'

    # Create a user using wp-cli
    wp user create --allow-root --role=author $USER1_LOGIN $USER1_MAIL \
        --user_pass=$USER1_PASS --path='/var/www/wordpress' >> /log.txt
fi

# Check if the directory /run/php doesn't exist, then create it
if [ ! -d /run/php ]; then
    mkdir /run/php
fi

# Start PHP-FPM 7.3 in the background
/usr/sbin/php-fpm7.3 -F
