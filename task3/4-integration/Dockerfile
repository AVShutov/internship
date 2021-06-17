FROM centos:7

RUN yum -y update && \
    yum -y install httpd php

ARG VERSION=0.0.1

ARG DEVOPS
ENV DEVOPS="ashutau"

#COPY ./index.php /var/www/html/index.php

EXPOSE 80

ENTRYPOINT ["/usr/sbin/httpd", "-D","FOREGROUND"]
