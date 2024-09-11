#!/bin/bash

#until mysql -h mariadb -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" -e 'SHOW DATABASES'; do
#    echo "Waiting for MariaDB to be ready..."
#    sleep 5
#done

cd /var/www/html
# to be deleted
#rm -rf *
wp core download --allow-root
wp config create --dbname=wordpress_db --dbuser=oussama --dbpass=password --dbhost=mariadb:3306 --dbprefix=wp_ --allow-root
wp core install --url="http://oakerkao.42.fr" --title="oakerkao" --admin_user=oussama --admin_password=password --admin_email=admin@example.com --allow-root
wp user create user1 regular_user@42.fr --role=editor --user_pass=0000 --allow-root

exec php-fpm8.2 -F
