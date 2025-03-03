# Используем Alpine Linux
ARG alpine_version=latest
FROM alpine:${alpine_version} AS base

# Указываем, что дальше будем использовать ARG
ARG buildno=1

# Устанавливаем необходимые пакеты
RUN apk update && apk add --no-cache openjdk17 wget tar \
    && rm -rf /var/cache/apk/*

# Создаем рабочую директорию
WORKDIR /app/build

# Скачиваем и распаковываем Apache Tomcat
RUN cd .. \
    && wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.36/bin/apache-tomcat-10.1.36.tar.gz \
    && tar -xvzf apache-tomcat-10.1.36.tar.gz \
    && rm apache-tomcat-10.1.36.tar.gz

FROM alpine:latest
RUN apk add openjdk17
COPY --from=base /app/apache-tomcat-10.1.36 /app/apache-tomcat-10.1.36

EXPOSE 8080
ENTRYPOINT ["/app/build/apache-tomcat-10.1.36/bin/catalina.sh"]
CMD ["run"]