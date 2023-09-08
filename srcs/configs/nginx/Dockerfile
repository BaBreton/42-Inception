# syntax=docker/dockerfile:1

FROM debian:latest
WORKDIR /etc/nginx
RUN apt-get update && apt upgrade -y && apt-get install -y sudo nginx ufw
RUN sudo ufw allow 'Nginx HTTP' && sudo ufw allow 'Nginx HTTPS'
COPY nginx.conf /etc/nginx/nginx.con
COPY ./html/index.html /var/www/html/index.html
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
