#!/bin/bash
#export DOCKER_CONTENT_TRUST=1
docker build . -t app:test
docker run -d -p 80:81  -v ./nginx/nginx.conf:/etc/nginx/nginx.conf app:test
