FROM postgres:12-alpine

ADD init-user-db.sh /docker-entrypoint-initdb.d/
ADD init-consul-service.sh /docker-entrypoint-initdb.d/

ENV LANG zh_CN.utf8