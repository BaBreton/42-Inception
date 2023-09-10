# syntax=docker/dockerfile:1

FROM debian:buster
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server
RUN mkdir -p /conf
RUN chmod 755 /conf
RUN chmod 755 /var/lib/mysql
RUN chown -R mysql:mysql /var/lib/mysql

COPY conf/createdb.sh /conf/createdb.sh
COPY conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# CMD ["service", "mysql", "start"]
ENTRYPOINT ["sh", "/conf/createdb.sh"]

EXPOSE 3306