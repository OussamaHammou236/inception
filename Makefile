run:
	docker compose -f srcs/docker-compose.yml up

clean:
	docker compose -f srcs/docker-compose.yml down

fclean:
	docker compose -f srcs/docker-compose.yml down --volumes --rmi all
	sudo rm -rf /home/ohammou-/volume/wordpress/*
	sudo rm -rf /home/ohammou-/volume/mariadb/*

re: fclean run