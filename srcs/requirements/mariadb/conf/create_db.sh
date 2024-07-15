#!/bin/bash

# Check if MySQL data directory exists
if [ ! -d "/var/lib/mysql/mysql" ]; then
  chown -R mysql:mysql /var/lib/mysql

  # Initialize MySQL data directory
  mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm

  # Create a temporary file for the SQL script
  tfile=$(mktemp)
  if [ ! -f "$tfile" ]; then
    echo "Failed to create temporary file"
    exit 1
  fi

  # Generate the SQL script
  cat <<EOF >$tfile
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
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_ADMIN}'@'%';
FLUSH PRIVILEGES;
EOF

  # Start MySQL server in the background
  mysqld_safe --datadir=/var/lib/mysql &

  # Wait for MySQL server to start (sleep for a few seconds)
  sleep 10

  # Execute the SQL script
  /usr/bin/mysql --user=root --password=${DB_ROOT} <$tfile

  # Clean up the temporary file
  rm -f $tfile
fi
