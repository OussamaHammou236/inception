FROM    debian:bullseye

# RUN     apt install -y wget php php-fpm php-mysql mariadb-client
RUN apt-get update && apt-get install -y \
    wget \
    php \
    php-fpm \
    php-mysql \
    mariadb-client \
    redis-tools


RUN		wget https://wordpress.org/wordpress-6.8.1.tar.gz -P /var/www

RUN     cd /var/www && tar -xzf wordpress-6.8.1.tar.gz && rm wordpress-6.8.1.tar.gz

RUN		chmod -R 755 /var/www/wordpress

COPY 	www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN		chmod 755 wp-cli.phar

RUN		mv wp-cli.phar /usr/local/bin/wp

COPY    tools/script.sh /

RUN     chmod 755 /script.sh

CMD ["bash", "script.sh"]