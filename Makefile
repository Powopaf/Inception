.PHONY: all up down start status stop

all : up

up : 
	@docker compose -f ./docker-compose.yaml up -d --build

down : 
	@docker compose -f ./docker-compose.yaml down

stop : 
	@docker compose -f ./docker-compose.yaml stop

start : 
	@docker compose -f ./docker-compose.yaml start

status : 
	@docker ps