FROM httpd

COPY index.html /usr/local/apache2/htdocs/

RUN chown www-data:www-data /usr/local/apache2/htdocs/index.html

CMD ["httpd-foreground"]
