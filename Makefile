run:
	docker compose up

fclean:
	docker compose down --volumes --rmi all

re: fclean run