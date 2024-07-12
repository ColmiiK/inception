#!bin/sh
if [ ! -d "/var/lib/mysql/mysql" ]; then
  chown -R mysql:mysql /var/lib/mysql

  mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm
  tfile='mktemp'
  if [ ! -f "$tfile" ]; then
    return 1
  fi
fi

if [ ! -d "/var/lib/mysql/wordpress" ]; then
  cat <<EOF >/tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT}';
CREATE DATABASE ${DB_NAME} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASS}';
GRANT SELECT, INSERT, UPDATE, DELETE ON ${DB_NAME}.* TO '${DB_USER}'@'%';
CREATE USER IF NOT EXISTS '${DB_ADMIN}'@'%' IDENTIFIED BY '${DB_ADMIN_PASS}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_ADMIN}'@'%';
FLUSH PRIVILEGES;
EOF
  /usr/bin/mysql --user=mysql </tmp/create_db.sql
  rm -f /tmp/create_db.sql
fi
