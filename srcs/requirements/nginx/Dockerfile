FROM debian:bookworm

RUN apt update -y && \
	apt upgrade -y && \
	apt install nginx -y && \
	apt install openssl && \
	openssl genrsa -out /etc/nginx/conf.d/website.key 2048 && \
	openssl req -new -key /etc/nginx/conf.d/website.key -x509 -days 365 -out /etc/nginx/conf.d/website.crt \
		-subj "/C=US/ST=California/L=San Francisco/O=My Organization/CN=mydomain.com"

COPY ./conf/nginx.conf /etc/nginx/conf.d

CMD ["nginx", "-g", "daemon off;"]
