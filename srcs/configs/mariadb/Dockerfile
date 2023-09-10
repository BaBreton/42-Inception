# syntax=docker/dockerfile:1

FROM debian:buster
RUN apt-get update && apt upgrade -y && apt-get install -y sudo mariadb-server
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld
COPY conf/createdb.sh /tmp/createdb.sh
RUN chmod 755 /tmp/createdb.sh
RUN /tmp/createdb.sh