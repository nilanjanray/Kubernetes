FROM ubuntu:20.04

ENV CONTAINER_TIMEZONE="Europe/Brussels"
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

RUN apt update && apt install -y apache2

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_RUN_DIR /var/www/html

#RUN echo 'Hello, docker' > /var/www/index.html

COPY apache2/new-vhost.conf /etc/apache2/sites-available/
COPY apache2/ports.conf /etc/apache2/
RUN ln -s /etc/apache2/sites-available/new-vhost.conf /etc/apache2/sites-enabled/new-vhost.conf    

EXPOSE 8081

ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND"]
