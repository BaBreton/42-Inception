NAME = inception
CONFIGS_FOLDER = ./srcs/configs
COMPOSE_FILE = ./srcs/docker-compose.yml
ENV = ./srcs/.env
BASEYML = ./srcs/tools/base.yml
LOGIN = $(shell whoami)

all: config build run

config:
	@bash ./srcs/tools/create_inception.sh $(ENV) $(BASEYML) $(COMPOSE_FILE)

build:
	@bash ./srcs/tools/check_data.sh $(ENV)
	sudo docker-compose -f $(COMPOSE_FILE) build
	@echo "\n\nInception is ready to be launched."

run:
	sudo docker-compose -f $(COMPOSE_FILE) up -d
	@echo "\n\nInception is now running on https://${LOGIN}.42.fr."

stop:
	sudo docker-compose -f $(COMPOSE_FILE) stop

test: build run

clean: stop
	sudo docker-compose -f $(COMPOSE_FILE) down -v

fclean: clean
	@bash ./srcs/tools/delete_inception.sh
	@if [ -n "$$(sudo docker ps -a -q)" ]; then sudo docker rm -f $$(sudo docker ps -a -q); fi
	@if [ -n "$$(sudo docker images -q)" ]; then sudo docker rmi -f $$(sudo docker images -q); fi
	@if [ -n "$$(sudo docker volume ls -q)" ]; then sudo docker volume prune -f; fi

re: fclean all


