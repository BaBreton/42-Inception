# syntax=docker/dockerfile:1

# Install debian buster
FROM debian:buster

# Install mariadb
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server

# Create configuration folder and copy configuration file
RUN mkdir -p /conf && chmod 755 /conf
COPY /conf/create_database.sh /conf
COPY /conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Run from the script
ENTRYPOINT ["/bin/bash", "/conf/create_database.sh"]

# Expose port 3306
EXPOSE 3306