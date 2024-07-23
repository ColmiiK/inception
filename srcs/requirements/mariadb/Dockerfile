FROM debian:bullseye

ARG DB_NAME
ARG DB_USER
ARG DB_USER_PASS
ARG DB_ADMIN_PASS

RUN apt-get update && apt-get install -y \
    mariadb-server mariadb-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld /etc/my.cnf.d/ \
    && chmod 777 /var/run/mysqld \
    && { \
         echo '[mysqld]'; \
         echo 'skip-host-cache'; \
         echo 'skip-name-resolve'; \
         echo 'bind-address=0.0.0.0'; \
       } | tee /etc/mysql/conf.d/docker.cnf \
    && echo "skip-networking = 0" >> /etc/my.cnf.d/mariadb-server.cnf

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

COPY requirements/mariadb/conf/create_db.sh /create_db.sh

CMD ["sh", "-c", "sh /create_db.sh && exec mysqld --defaults-extra-file=/etc/mysql/conf.d/docker.cnf --skip-log-error"]
