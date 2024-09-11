#!/bin/bash
cat  <<EOF > /tmp/init.sql
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

#ALTER USER 'root'@'%' IDENTIFIED BY 'password';
#GRANT ALL PRIVILEGES ON * . * TO 'root'@'%';
mysqld --user=root --bootstrap < /tmp/init.sql

exec mysqld --user=root --bind-address=0.0.0.0
