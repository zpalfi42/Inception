#! /bin/bash

sleep 15

if [ -f ./wp-config.php ]
then
	echo "exists"
else
	wp core download --allow-root
	wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST --path=/var/www/html --allow-root
	wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASS --allow-root
	wp theme install twentysixteen --activate --allow-root
	chmod 777 wp-content wp-content/uploads wp-content/uploads/* wp-content/uploads/*/*
fi

/usr/sbin/php-fpm7.4 -F;
