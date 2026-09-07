# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sahafid <sahafid@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/01 14:18:11 by sahafid           #+#    #+#              #
#    Updated: 2023/01/07 01:59:32 by sahafid          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #



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