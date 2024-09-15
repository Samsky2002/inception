#!/bin/bash

sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf
wait_for_mariadb() {
    echo "Waiting for MariaDB to be ready..."
    until mysql -h mariadb -u"${WORDPRESS_DB_ADMIN}" -p"${WORDPRESS_DB_ADMIN_PASSWORD}" -e 'SHOW DATABASES;' > /dev/null 2>&1; do
        sleep 5
        echo "Still waiting for MariaDB..."
    done
    echo "MariaDB is ready!"
}

wait_for_mariadb

mkdir -p /var/www/html

cd /var/www/html

if [ ! -f wp-config.php ]; then
    wp core download --allow-root
    wp config create --dbname=${WORDPRESS_DB_NAME} --dbuser=${WORDPRESS_DB_ADMIN} --dbpass=${WORDPRESS_DB_ADMIN_PASSWORD} --dbhost=${WORDPRESS_DB_HOST} --dbprefix=wp_ --allow-root
fi

if ! wp core is-installed --allow-root; then
    wp core install --url="http://${DOMAIN}" --title="${TITLE}" --admin_user=${WORDPRESS_DB_ADMIN} --admin_password=${WORDPRESS_DB_ADMIN_PASSWORD} --admin_email=${WORDPRESS_DB_ADMIN}@42.fr --allow-root
fi

if ! wp user get ${WORDPRESS_DB_USER} --allow-root > /dev/null 2>&1; then
    wp user create ${WORDPRESS_DB_USER} ${WORDPRESS_DB_ADMIN}@42.fr --role=editor --user_pass=${WORDPRESS_DB_PASSWORD} --allow-root
fi

echo "Starting PHP-FPM..."
exec php-fpm8.2 -F
