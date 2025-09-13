FROM debian:bullseye

RUN apt update && apt install -y mariadb-server mariadb-client

COPY mariadb.cnf /etc/mysql/mariadb.cnf

COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod 755 /usr/local/bin/script.sh

EXPOSE 3306

CMD ["bash", "/usr/local/bin/script.sh"]