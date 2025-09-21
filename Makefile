run:
	docker compose -f srcs/docker-compose.yml up -d --build

clean:
	docker compose -f srcs/docker-compose.yml down

fclean:
	docker compose -f srcs/docker-compose.yml down --volumes --rmi all
	sudo rm -rf /home/ohammou-/data/wordpress/*
	sudo rm -rf /home/ohammou-/data/mariadb/*

re: fclean run