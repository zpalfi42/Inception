#!/bin/sh
if [ ! -f "/var/www/html/wordpress/index.php" ]; then
	# download wordpress
	wp core download --allow-root

	#set user and pwd  for database
	wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST --dbcharset="utf8"  --allow-root

	# create admin user and pwd 
	wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email   --allow-root

	#create another user and pwd 
	wp user create $WP_USR $WP_USR_EMAIL --role=author --user_pass=$WP_USR_PASS   --allow-root

	#set them for wordpress site
	wp theme install hitchcock --activate --allow-root
fi

exec php-fpm7.3 -F
