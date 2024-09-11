FROM debian:bookworm

WORKDIR /home

COPY ./conf/wordpress.sh /home

RUN apt update -y && \
	apt upgrade -y && \
	apt install wget -y && \
	apt install php8.2 php8.2-fpm php8.2-mysql -y && \
	apt install mariadb-client -y && \
	apt install mariadb-server -y && \
	sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf && \
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

CMD ["./wordpress.sh"]
