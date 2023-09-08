# syntax=docker/dockerfile:1

FROM debian:latest
WORKDIR /etc/nginx
RUN apt-get update && apt upgrade -y && apt-get install -y sudo nginx ufw
RUN sudo ufw allow 'Nginx HTTP' && sudo ufw allow 'Nginx HTTPS'
COPY nginx.conf /etc/nginx/nginx.conf
