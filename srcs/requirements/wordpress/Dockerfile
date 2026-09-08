FROM debian:bookworm-slim


RUN apt update -y 

RUN apt install php-fpm php-mysql -y

RUN apt install curl -y


COPY ./tools/setupWP.sh /script.sh
COPY ./tools/wp_conf.php /wp-config.php
RUN chmod +x /script.sh

EXPOSE 9000

CMD [ "/script.sh" ]