USE mysql;

-- new admin user
GRANT ALL ON *.* TO '$DB_NAME'@'%' IDENTIFIED BY '$DB_PASS' WITH GRANT OPTION;
GRANT ALL ON *.* TO '$DB_NAME'@'localhost' IDENTIFIED BY '$DB_PASS' WITH GRANT OPTION;
SET PASSWORD FOR '$DB_NAME'@'localhost'=PASSWORD('$DB_PASS');

-- secure install
DELETE FROM mysql.user WHERE User = 'root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP USER IF EXISTS ''@'$DB_HOST';
DROP USER IF EXISTS ''@'localhost';
DROP DATABASE IF EXISTS test;

-- apply
FLUSH PRIVILEGES;
