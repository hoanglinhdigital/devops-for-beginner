#Stage 1
FROM node:14 as buildstep
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . . 
RUN npm run build

#Stage 2
FROM httpd

COPY --from=buildstep /app/build /usr/local/apache2/htdocs/

RUN chown www-data:www-data /usr/local/apache2/htdocs/index.html

ENV LOGFILE=/var/log/httpd/access.log

EXPOSE 80

CMD ["httpd-foreground"]