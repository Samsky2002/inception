all: 
	docker-compose -f srcs/docker-compose.yml up --build -d

clean:
	docker-compose -f srcs/docker-compose.yml down -v

fclean: clean
	docker system prune -af
	rm -rf /home/oakerkao/data/mariadb-data/* /home/oakerkao/data/wordpress-data/*

re: fclean all
