# my first image
ARG alpine_version=latest
FROM alpine:${alpine_version}
ARG buildno=1

WORKDIR /
WORKDIR app
WORKDIR build
# / + app = build = /app/build

# RUN touch test.txt && echo "Hello, World!" >> test.txt
RUN apk add openjdk17
RUN cd .. \
    && wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.36/bin/apache-tomcat-10.1.36.tar.gz \
    && tar -xvzf apache-tomcat-10.1.36.tar.gz \
    && rm apache-tomcat-10.1.36.tar.gz
# /app/build/storage-new
# COPY storage storage-new
# *
# COPY storage/*.txt storage-new-txt/
# COPY apache-tomcat-10.1.36.tar.gz /app
# ADD https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.36/bin/apache-tomcat-10.1.36.tar.gz tomcat-add.tar.gz
ENTRYPOINT ["/app/build/apache-tomcat-10.1.36/bin/catalina.sh", "run"]