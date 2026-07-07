#!/bin/bash

set -e

if [ ! -f wp-config.php ]; then
	curl -sO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar /usr/local/bin/wp
	mv wp-cli.phar /usr/local/bin/wp

	curl -sSl https://wordpress.org/latest.tar.gz | tar xz --strip-components=1
	DP_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")
	ADMIN_PASSWORD=$(CAT "$WP_ADMIN_PASSWORD_FILE")
	
	wp config create \
		--dbname="${MYSQL_DATABASE}" --dbuser="${MYSQL_USER}" \
		--dbpass="${DB_PASSWORD}" --dbhost=mariadb --allow-root

	until mysadmin ping -h mariadb -u"${MYSQL_USER}" -p"${DB_PASSWORD}" --silent; do
		sleep 2
	done

	wp core install \
		--url="https://${DOMAIN_NAME}" --title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" --admin_password="${ADMIN_PASSWORD}" \
	    --admin_email="${WP_ADMIN_EMAIL}" --allow-root
	wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --role=author --user_pass="${WP_USER_PASSWORD}" --allow-root

	chown -R www-data:www-data /var/www/html
fi

exec php-fpm8.2 -F
