# syntax=docker/dockerfile:1

FROM debian:latest
WORKDIR /etc/nginx
RUN apt-get update && sudo apt upgrade -y && apt-get install -y nginx
RUN sudo ufw allow 'Nginx HTTP' && sudo ufw allow 'Nginx HTTPS'
COPY nginx.conf /etc/nginx/nginx.conf