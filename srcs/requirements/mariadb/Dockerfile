FROM debian:bookworm-slim

RUN apt_get update && apt-get install -y --no-install-recommends \
	mariadb-server mariadb-client && rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf /etc/mysql/maridb.conf.d/50-server.cnf
COPY tools/db-setup.sh /usr/local/bin/db-setup.sh
RUN chmod +x /usr/local/bin/db_setup.sh

EXPOSE 3306
ENTRYPOINT ["/usr/local/bin/db_setup.sh"]
