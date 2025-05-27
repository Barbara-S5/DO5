FROM ubuntu:24.04

WORKDIR /usr/share/nginx

RUN apt-get update && \
    apt-get install -y \
    nginx \
    gcc \
    spawn-fcgi \
    libfcgi-dev \
    curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx /var/cache/nginx /var/run /var/lib/nginx /var/lib/nginx/body /var/lib/nginx/fastcgi /var/lib/nginx/proxy /var/lib/nginx/scgi /var/lib/nginx/uwsgi /var/log/nginx && \
    { getent group nginx || groupadd -r nginx; } && \
    { getent passwd nginx || useradd -r -g nginx -s /bin/false -d /nonexistent nginx; } && \
    chown -R nginx:nginx /etc/nginx /var/cache/nginx /usr/share/nginx /var/lib/nginx /var/run /var/log/nginx && \
    touch /var/run/nginx.pid /var/log/nginx/error.log /var/log/nginx/access.log && \
    chown nginx:nginx /var/run/nginx.pid /var/log/nginx/error.log /var/log/nginx/access.log && \
    chmod u-s /bin/umount && \
    chmod u-s /bin/su && \
    chmod g-s /usr/bin/chage && \
    chmod u-s /usr/bin/chfn && \
    chmod g-s /usr/bin/wall && \
    chmod u-s /usr/bin/gpasswd && \
    chmod u-s /bin/mount && \
    chmod u-s /usr/bin/newgrp && \
    chmod g-s /usr/bin/expiry && \
    chmod g-s /sbin/unix_chkpwd && \
    chmod g-s /sbin/pam_extrausers_chkpwd && \
    chmod u-s /usr/bin/passwd && \
    chmod u-s /usr/bin/chsh 

COPY ./my_server.c /usr/share/nginx/
RUN gcc /usr/share/nginx/my_server.c -lfcgi -o /usr/share/nginx/server && \
    chmod +x /usr/share/nginx/server

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
RUN chown nginx:nginx /etc/nginx/nginx.conf

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:80/ || exit 1

USER nginx

CMD ["/bin/bash", "-c", "spawn-fcgi -p 8080 -f /usr/share/nginx/server -a 127.0.0.1 & nginx -g 'daemon off;'"]

