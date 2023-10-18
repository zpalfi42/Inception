#! /bin/bash

wp core download --allow-root
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST --path=/var/www/html --allow-root
wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_USER_PASS --allow-root

ls .

service --status-all

ls /usr/sbin/

/usr/sbin/php-fpm7.4 -F;
