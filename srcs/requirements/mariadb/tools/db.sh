#! /bin/bash

#service mariadb start

#mariadb --user=$DB_ROOT_USER --password=$DB_ROOT_PASS -e "CREATE DATABASE IF NOT EXISTS $DB_NAME"
#mariadb -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS'"

#mariadb -e "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' WITH GRANT OPTION;"
#mariadb -e "FLUSH PRIVILEGES;"
#mariadb -e "ALTER USER '${DB_ROOT_USER}'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';"

#mariadb-admin -u ${DB_ROOT_USER} --password=${DB_ROOT_PASS} shutdown
        
#mariadb

set -e

/usr/sbin/mysqld &
sleep 5

#mysql -e "UPDATE mysql.user SET Host='%', Password=PASSWORD('$DB_ROOT_PASS') WHERE USER='$DB_ROOT_USER';"
mysql --user=$DB_ROOT_USER --password=$DB_ROOT_PASS -e "SHOW DATABASES;"
mysql --user=$DB_ROOT_USER --password=$DB_ROOT_PASS -e "CREATE DATABASE $DB_NAME;"
mysql --user=$DB_ROOT_USER --password=$DB_ROOT_PASS -e "SHOW DATABASES;"
mysql -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';"
mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "ALTER USER '${DB_ROOT_USER}'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';"
mysqladmin -u ${DB_ROOT_USER} --password=${DB_ROOT_PASS} shutdown

mysqld

