FROM httpd

COPY ./web/index.html /usr/local/apache2/htdocs/

RUN chown www-data:www-data /usr/local/apache2/htdocs/index.html

ENV LOGFILE=/var/log/httpd/access.log

EXPOSE 80

CMD ["httpd-foreground"]