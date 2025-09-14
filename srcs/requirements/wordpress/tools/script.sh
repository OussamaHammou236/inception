#!/bin/sh

rm -f /var/www/wordpress/wp-content/object-cache.php
WP_PATH='/var/www/wordpress'

Waiting_for_mariadb()
{
	while ! mariadb -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" 2>/dev/null; do
    echo "Waiting for MariaDB Connection...";
    sleep 2
	done

	echo "MariaDB Connection Successful!"
}


Waiting_for_redis()
{
	while ! redis-cli -h redis -p 6379 ping | grep -q PONG; do
		echo "Waiting for Redis Connection...";
		sleep 2
	done

	echo "Redis Connection Successful!"
}

sleep 5

wordpress_configuration()
{
	sleep 5
	echo "Configuring WordPress..."
	wp config create --allow-root \
	--dbname=$MYSQL_DATABASE \
	--dbuser=$MYSQL_USER \
	--dbpass=$MYSQL_PASSWORD \
	--dbhost=mariadb \
	--path='/var/www/wordpress/' \
	--force

}



installing_core()
{
	echo "Installing Core..."

	if ! wp core is-installed --allow-root --path=$WP_PATH; then
		echo "👉 WordPress not installed. Installing..."
		wp core install --allow-root \
			--url="$DOMAIN_NAME" \
			--title="$WP_TITLE" \
			--admin_user="$WP_ADMIN_NAME" \
			--admin_password="$WP_ADMIN_PASSWORD" \
			--admin_email="$WP_ADMIN_MAIL" --skip-email \
			--path=$WP_PATH
	else
		echo "👉 WordPress already installed. Updating values..."
		if [ -n "$WP_TITLE" ]; then
			wp option update blogname "$WP_TITLE" --allow-root --path=$WP_PATH
		fi

		if [ -n "$WP_ADMIN_MAIL" ]; then
			wp option update admin_email "$WP_ADMIN_MAIL" --allow-root --path=$WP_PATH
		fi

		if [ -n "$DOMAIN_NAME" ]; then
			wp option update siteurl "https://$DOMAIN_NAME" --allow-root --path=$WP_PATH
			wp option update home "https://$DOMAIN_NAME" --allow-root --path=$WP_PATH
		fi

	fi
}


creating_user()
{
	echo "Creating User..."

	if wp user get "$WP_USER_NAME" --allow-root --path=/var/www/wordpress &> /dev/null; then
		echo "👉 User $WP_USER_NAME kayn deja"
	else
		wp user create --allow-root \
		"$WP_USER_NAME" "$WP_USER_MAIL" \
		--user_pass="$WP_USER_PASSWORD" \
		--role=author \
		--path='/var/www/wordpress'
	fi
}

redis_configuration()
{
	echo "Configuring Redis Cache..."
	wp config set WP_CACHE true --raw --type=constant --allow-root --path="/var/www/wordpress"
	wp config set WP_REDIS_HOST redis --type=constant --allow-root --path="/var/www/wordpress"
	wp config set WP_REDIS_PORT 6379 --raw --type=constant --allow-root --path="/var/www/wordpress"

	wp plugin install redis-cache --activate --force --allow-root --path="/var/www/wordpress" || true
	wp redis enable --allow-root --path="/var/www/wordpress" || true
	echo "WordPress Configuration Completed!"

}

Waiting_for_mariadb
wordpress_configuration
installing_core
creating_user
Waiting_for_redis
redis_configuration

echo "Starting PHP-FPM..."
mkdir -p /run/php
exec php-fpm7.4 -F