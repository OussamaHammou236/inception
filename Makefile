COMPOSE_PATH = srcs/docker-compose.yml

up:
	docker compose -f $(COMPOSE_PATH) up -d --build

down:
	docker compose -f $(COMPOSE_PATH) down

logs:
	docker compose -f $(COMPOSE_PATH) logs

fclean:
	docker compose -f $(COMPOSE_PATH) down --volumes --rmi all
	rm -rf /home/ohammou-/data/wordpress/*
	rm -rf /home/ohammou-/data/mariadb/*

re: fclean up