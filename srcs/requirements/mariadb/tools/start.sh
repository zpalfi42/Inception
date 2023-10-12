#!/bin/bash



service mysql start 


echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" > db1.sql
echo "CREATE USER IF NOT EXISTS '$DB_USR'@'%' IDENTIFIED BY '$db1_pwd' ;" >> db1.sql
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USR'@'%' ;" >> db1.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql

mysql < db1.sql

#terminate the MySQL service by sending a signal to the process ID stored in the /var/run/mysqld/mysqld.pid file. 
kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
