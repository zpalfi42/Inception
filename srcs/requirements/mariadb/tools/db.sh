#! /bin/bash

/usr/sbin/mysqld &
sleep 5

if [ ! -d /var/lib/mysql/${DB_NAME} ];
then
	mysql --user=$DB_ROOT_USER --password=$DB_ROOT_PASS -e "CREATE DATABASE $DB_NAME;"
	mysql -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';"
	mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' WITH GRANT OPTION;"
	mysql -e "FLUSH PRIVILEGES;"
	mysql -e "ALTER USER '${DB_ROOT_USER}'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';"
fi
	
mysqladmin -u ${DB_ROOT_USER} --password=${DB_ROOT_PASS} shutdown
mysqld --bind-address=0.0.0.0
