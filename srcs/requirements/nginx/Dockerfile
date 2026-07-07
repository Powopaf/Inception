FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
	nginx openssl && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl && \
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/inception/key \
	-out /etc/nginx/ssl/inception.crt \
	-subj "/C=FR/ST=IDF/L=PARIS/O=42/OU=42/CN=pifourni.42.fr"

COPY conf/nginx.conf etc/nginx/nginx.conf

EXPOSE 443
CMD ["nginx", "-g", "deamon off;"]
