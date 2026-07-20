FROM debian:trixie-slim

RUN apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install -y curl php php-fpm php-mysqli

RUN curl -LsSO https://wordpress.org/wordpress-7.0.2.tar.gz \
  && tar -xvf wordpress-7.0.2.tar.gz -C /var/www\
  && rm wordpress-7.0.2.tar.gz

EXPOSE 9000

CMD ["php-fpm8.4", "-F"]