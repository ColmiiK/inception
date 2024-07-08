FROM debian:bullseye

ARG DB_NAME DB_ADMIN DB_ADMIN_PASS DB_USER DB_USER_PASS

RUN apt-get update && apt-get install -y \
    mariadb-server mariadb-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld \
    && chmod 777 /var/run/mysqld \
    && mkdir -p /etc/my.cnf.d/

RUN { \ 
      echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee /etc/my.cnf.d/docker.cnf \
    && echo "skip-networking = 0" >> /etc/my.cnf.d/mariadb-server.cnf

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

COPY requirements/mariadb/conf/create_db.sh .
RUN sh create_db.sh && rm create_db.sh

USER mysql
# COPY tools/db.sh .
# ENTRYPOINT ["sh", "db.sh"]
CMD ["mysqld", "--skip-log-error"]

