# Base image for debian
FROM debian:bullseye

# Install mariadb-server
RUN apt update -y && apt upgrade -y && apt install mariadb-server -y

COPY conf/db.conf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysql && \
	chown -R mysql:mysql /var/run/mysql && \
	chmod 77 /var/run/mysql

EXPOSE 3306

COPY tools/db.sh /usr/local/bin/db.sh
RUN chmod 777 /usr/local/bin/db.sh

RUN mysql_install_db

ENTRYPOINT ["/usr/local/bin/db.sh"]
