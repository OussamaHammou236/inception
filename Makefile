run:
	docker build -t nginx-image nginx/
	docker run -d --name nginx-container -p 443:443 nginx-image

fclean:
	docker stop nginx-container
	docker rm nginx-container
	docker rmi nginx-image

re: fclean run