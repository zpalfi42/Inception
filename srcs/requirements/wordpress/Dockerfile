FROM debian:bullseye

RUN apt-get update -y && apt-get -y install \
	curl \
	php-fpm \
	php-mysqli \
	mariadb-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp 

COPY conf/www.conf /etc/php/7.3/fpm/pool.d/

RUN mkdir -p /var/run/php && \
	chmod 777 /var/run/php

COPY	./tools/wp.sh /usr/local/bin/wp.sh
RUN	chmod 777 /usr/local/bin/wp.sh

EXPOSE 9000
WORKDIR /var/www/html/

ENTRYPOINT ["/usr/local/bin/wp.sh"]
