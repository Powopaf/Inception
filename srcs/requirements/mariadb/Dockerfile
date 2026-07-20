FROM debian:trixie-slim

RUN apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install curl 
 
RUN curl -LsSO https://r.mariadb.com/downloads/mariadb_repo_setup | bash

RUN apt-get -y update \
  && apt-get -y install mariadb-server mariadb-client

RUN useradd db
USER db

CMD ["/bin/bash"]
