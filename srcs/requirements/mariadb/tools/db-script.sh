#!bin/sh

# Checking is mysql is correctly intalled and has correctly started working. If it is not it tries to initiate it.
if [ ! -d "/var/lib/mysql/mysql" ]; then

	chown -R mysql:mysql /var/lib/mysql

	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm

	tfile = `mktemp`
	if [ ! -f "$tfile" ]; then
		return 1
	fi
fi

# Checking if a database called wordpress exists, if not we write all the information in a temporary file and then create the database. Last we delete the temp file.

if [ ! -d "/var/lib/mysql/wordpress" ]; then

	cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM     mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '1234';
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASS}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
	# run init.sql
	/usr/bin/mysql --user=mysql --bootstrap < /tmp/create_db.sql
	rm -f /tmp/create_db.sql
fi
