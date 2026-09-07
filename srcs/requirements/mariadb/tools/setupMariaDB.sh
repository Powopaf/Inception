#!/bin/bash

mkdir -p /var/log/mysql /run/mysqld
chown -R mysql:mysql /var/log/mysql /run/mysqld

mysqld --user=mysql --skip-networking &

until mysqladmin --protocol=socket ping >/dev/null 2>&1; do
	sleep 1
done

echo "CREATE DATABASE IF NOT EXISTS $db1_name ;" > db1.sql
echo "CREATE OR REPLACE USER '$db1_user'@'%' IDENTIFIED BY '$db1_pwd' ;" >> db1.sql
echo "GRANT ALL PRIVILEGES ON $db1_name.* TO '$db1_user'@'%' ;" >> db1.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql

if mysql --protocol=socket -e "SELECT 1" >/dev/null 2>&1; then
	mysql --protocol=socket < db1.sql
else
	mysql --protocol=socket -uroot -p12345 < db1.sql
fi

mysqladmin --protocol=socket -uroot -p12345 shutdown 2>/dev/null || mysqladmin --protocol=socket shutdown

exec mysqld