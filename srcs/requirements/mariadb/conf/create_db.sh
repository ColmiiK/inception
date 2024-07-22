#!/bin/sh
set -e
# Check if MySQL data directory exists and initialize if not
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "MySQL data directory not found. Initializing..."
  chown -R mysql:mysql /var/lib/mysql

  # Initialize MySQL data directory
  mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm
else
  echo "MySQL data directory already exists. Skipping initialization."
fi

# Stop MySQL/MariaDB server if running
if pgrep mysqld; then
  echo "Stopping MySQL/MariaDB server..."
  mysqladmin -u root -p${DB_ADMIN_PASS} shutdown
fi

# Check if the WordPress database is already created
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
  echo "Creating ${DB_NAME} database and user..."

  cat <<EOF >create_db.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='' OR User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
CREATE USER IF NOT EXISTS 'root'@'localhost' IDENTIFIED BY '${DB_ADMIN_PASS}';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ADMIN_PASS}';
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
ALTER DATABASE ${DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
GRANT CREATE, ALTER, DROP, INDEX, LOCK TABLES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

  # Start MySQL/MariaDB and execute SQL commands
  mysqld --user=mysql --bootstrap <create_db.sql

  # Check if mysqld startup was successful
  if [ $? -ne 0 ]; then
    echo "Failed to start MySQL/MariaDB and execute initialization SQL."
    exit 1
  fi

  echo "${DB_NAME} database and user created successfully."

else
  echo "${DB_NAME} database already exists. Skipping creation."
fi

# Start MySQL/MariaDB server again
echo "Starting MySQL/MariaDB server..."
mysqld_safe --user=mysql &
