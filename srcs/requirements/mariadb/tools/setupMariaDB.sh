#!/bin/sh

set -eu

DB_DIR=/var/lib/mysql
SOCKET_DIR=/var/run/mysqld
SOCKET_PATH="$SOCKET_DIR/mysqld.sock"
DB_PASSWORD_FILE=/run/secrets/db_password
DB_ROOT_PASSWORD_FILE=/run/secrets/db_root_password

if [ -f "$DB_PASSWORD_FILE" ]; then
    MYSQL_PASSWORD=$(tr -d '\r\n' < "$DB_PASSWORD_FILE")
fi

if [ -f "$DB_ROOT_PASSWORD_FILE" ]; then
    MYSQL_ROOT_PASSWORD=$(tr -d '\r\n' < "$DB_ROOT_PASSWORD_FILE")
fi

mkdir -p "$DB_DIR" "$SOCKET_DIR"
chown -R mysql:mysql "$DB_DIR" "$SOCKET_DIR"

if [ ! -d "$DB_DIR/mysql" ]; then
    mariadb-install-db --user=mysql --datadir="$DB_DIR" >/dev/null
fi

mariadbd --user=mysql --datadir="$DB_DIR" --socket="$SOCKET_PATH" --bind-address=0.0.0.0 &
pid="$!"

until mariadb-admin --no-defaults --protocol=SOCKET --socket="$SOCKET_PATH" ping --silent; do
    sleep 1
done

if [ -n "${MYSQL_DATABASE:-}" ] && \
    [ -n "${MYSQL_USER:-}" ] && \
    [ -n "${MYSQL_PASSWORD:-}" ]; then
    mariadb --no-defaults --protocol=SOCKET --socket="$SOCKET_PATH" -uroot <<EOSQL
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOSQL
fi

if [ -n "${MYSQL_ROOT_PASSWORD:-}" ]; then
    mariadb --no-defaults --protocol=SOCKET --socket="$SOCKET_PATH" -uroot <<EOSQL
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOSQL
fi

wait "$pid"
