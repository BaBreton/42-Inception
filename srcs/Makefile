DOCKER_COMPOSE_FILE = docker-compose.yml
CONFIG = ./configs
IMAGES = mariadb \
		nginx \
		wordpress \

all: build run

build:
	# @for image in $(IMAGES); do \
	# 	docker build -t $$image:latest $(CONFIG)/$$image; \
	# done
	docker-compose -f $(DOCKER_COMPOSE_FILE) build

run:
	docker-compose -f $(DOCKER_COMPOSE_FILE) up -d

stop:
	docker-compose -f $(DOCKER_COMPOSE_FILE) down

clean:
	docker system prune -af

fclean: stop
	@if [ -n "$$(docker ps -a -q)" ]; then docker rm -f $$(docker ps -a -q); fi
	@if [ -n "$$(docker images -q)" ]; then docker rmi -f $$(docker images -q); fi
	@if [ -n "$$(docker volume ls -q)" ]; then docker volume prune -f; fi

re: fclean all