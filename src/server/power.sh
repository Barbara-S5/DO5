gcc my_server.c -o my_server -lfcgi
sudo nginx -p $(pwd)/nginx -c nginx.conf
sudo spawn-fcgi -p 8080 -n ./my_server
