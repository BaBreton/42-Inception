#!/bin/sh

sudo cp ./srcs/.tmp/hosts  /etc/hosts
sudo rm -rf /home/$USER/data
rm -rf ./srcs/.tmp
rm -f srcs/.env
rm -f srcs/docker-compose.yml