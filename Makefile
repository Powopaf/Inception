LOGIN      = $(shell whoami)
DATA_DIR   = /home/$(LOGIN)/data
COMPOSE    = docker compose -f srcs/docker-compose.yml

all: up

up: prepare
	$(COMPOSE) up --build -d

prepare:
	mkdir -p $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

start:
	$(COMPOSE) start

restart: down up

clean: down
	docker system prune -af

fclean: clean
	sudo rm -rf $(DATA_DIR)

re: fclean all

.PHONY: all up prepare down stop start restart clean fclean re
