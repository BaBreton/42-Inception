NGINX_IMAGE_NAME = nginx-custom
DOCKER_COMPOSE_FILE = docker-compose.yml

all: build run

build:
	docker-compose -f $(DOCKER_COMPOSE_FILE) build

run:
	docker-compose -f $(DOCKER_COMPOSE_FILE) up -d nginx

stop:
	docker-compose -f $(DOCKER_COMPOSE_FILE) down

clean:
	docker system prune -af