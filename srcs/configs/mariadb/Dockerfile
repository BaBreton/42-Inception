# syntax=docker/dockerfile:1

FROM debian:latest
RUN apt-get update && apt upgrade -y && apt-get install -y sudo mariadb-server
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld
EXPOSE 3306
CMD ["mysqld", "--socket=/var/run/mysqld/mysqld.sock"]
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD mysqladmin ping -h localhost || exit 1
