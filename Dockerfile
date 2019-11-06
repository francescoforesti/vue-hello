FROM arm32v7/nginx:stable
RUN mkdir /var/www
COPY ./dist /var/www
COPY ./docker/nginx.conf /etc/nginx/nginx.conf

