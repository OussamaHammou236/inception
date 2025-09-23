FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl && \
                mkdir -p /etc/nginx/ssl

COPY nginx.conf /etc/nginx/nginx.conf

RUN 	openssl req -x509 -nodes \
			-keyout /etc/nginx/ssl/inception.key \
			-out /etc/nginx/ssl/inception.crt \
			-subj "/C=FR/ST=IDF/L=1337/O=42/OU=42/CN=UserName.42.fr/UID=UserName"

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

