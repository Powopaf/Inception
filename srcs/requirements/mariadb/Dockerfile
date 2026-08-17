FROM debian:trixie-slim

RUN apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install curl 
 
RUN curl -LsSO https://r.mariadb.com/downloads/mariadb_repo_setup | bash

RUN apt-get -y update \
  && apt-get -y install mariadb-server mariadb-client

EXPOSE 3306 

RUN mkdir -p /var/lib/mysql /var/run/mysqld \
  && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

COPY tools/setupMariaDB.sh /usr/local/bin/setupMariaDB.sh
RUN chmod +x /usr/local/bin/setupMariaDB.sh
ENTRYPOINT [ "/usr/local/bin/setupMariaDB.sh" ]
