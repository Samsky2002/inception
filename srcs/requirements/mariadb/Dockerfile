FROM debian:bookworm

WORKDIR /home

RUN apt update -y && \
    apt upgrade -y && \
    apt install mariadb-server -y && \
    apt install mariadb-client -y && \
	mkdir -p /var/run/mysqld && \
	sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf



COPY ./conf/mariadb.sh .

CMD ["./mariadb.sh"]
