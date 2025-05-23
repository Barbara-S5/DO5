FROM nginx:latest
WORKDIR /home
RUN apt-get update && \
    apt-get install -y \
    gcc \
    spawn-fcgi \
    libfcgi-dev && \
    rm -rf /var/lib/apt/lists/*

RUN chown -R nginx:nginx /etc/nginx/nginx.conf \
    && chown -R nginx:nginx /var/cache/nginx \
    && chown -R nginx:nginx /home \
    && touch /var/run/nginx.pid \
    && chown -R nginx:nginx /var/run/nginx.pid \
    && chmod u-s /bin/umount \
    && chmod u-s /bin/su \
    && chmod g-s /usr/bin/chage \
    && chmod u-s /usr/bin/chfn \
    && chmod g-s /usr/bin/wall \
    && chmod u-s /usr/bin/gpasswd \
    && chmod u-s /bin/mount \
    && chmod u-s /usr/bin/newgrp \
    && chmod g-s /usr/bin/expiry \
    && chmod g-s /sbin/unix_chkpwd \
    && chmod u-s /usr/bin/passwd \
    && chmod u-s /usr/bin/chsh

COPY ./my_server.c /home/
RUN gcc my_server.c -lfcgi -o server && chmod +x /home/server
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

USER nginx 
CMD (spawn-fcgi -p 8080 -f /home/server -a 0.0.0.0 && nginx -g 'daemon off;')
HEALTHCHECK NONE
