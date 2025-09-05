#!/bin/sh

while ! mariadb -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" 2>/dev/null; do
    echo "Waiting for MariaDB Connection...";
    sleep 2
done

echo "MariaDB Connection Successful!"

echo "Creating WordPress Configuration..."

wp config create --allow-root \
	--dbname=$MYSQL_DATABASE \
	--dbuser=$MYSQL_USER \
	--dbpass=$MYSQL_PASSWORD \
	--dbhost=mariadb \
	--path='/var/www/wordpress/' \
	--force

echo "Installing Core..."

wp core install --allow-root \
	--url="$DOMAIN_NAME" \
	--title="$WP_TITLE" \
	--admin_user="$WP_ADMIN_NAME" \
	--admin_password="$WP_ADMIN_PASSWORD" \
	--admin_email="$WP_ADMIN_MAIL" --skip-email \
	--path='/var/www/wordpress'

echo "Creating User..."

wp user create --allow-root \
	"$WP_USER_NAME" "$WP_USER_MAIL" \
	--user_pass="$WP_USER_PASSWORD" \
	--role=author \
	--path='/var/www/wordpress'

echo "WordPress Configuration Completed!"

echo "Starting PHP-FPM..."
mkdir -p /run/php
exec php-fpm7.4 -F