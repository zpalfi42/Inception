# Base image for debian
FROM debian:bullseye

# Install mariadb-server
RUN apt update -y && apt upgrade -y && apt install mariadb-server -y

COPY conf/db.conf /etc/mysql/my.cnf
COPY tools/db.sh /usr/local/bin/

RUN mkdir -p /var/run/mysqld && \
	chown -R mysql:mysql /var/run/mysqld && \
	chmod 777 /var/run/mysqld /usr/local/bin/db.sh && \
	rm -rf ./wp-config.php && \
	mysql_install_db

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/db.sh"]
