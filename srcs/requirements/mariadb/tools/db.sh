#! /bin/bash

service mysqld start

mysql -u $DB_ROOT_USER -p$DB_ROOT_PASS -e "CREATE DATABASE IF NOT EXISTS $DB_NAME"
mysql -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS'"

mysql -e "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "ALTER USER '${DB_ROOT_USER}'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';"

mysqladmin -u ${DB_ROOT_USER} --password=${DB_ROOT_PASS} shutdown
        
mysqld
