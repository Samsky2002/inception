FROM debian:bookworm

RUN apt update -y && \
	apt upgrade -y && \
	apt install nginx -y && \
	apt install openssl && \
	openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout  /etc/nginx/conf.d/website.key -subj "/C=US/ST=California/L=San Francisco/O=My Organization/CN=mydomain.com" -out /etc/nginx/conf.d/website.crt

COPY ./conf/nginx.conf /etc/nginx/conf.d

CMD ["nginx", "-g", "daemon off;"]
